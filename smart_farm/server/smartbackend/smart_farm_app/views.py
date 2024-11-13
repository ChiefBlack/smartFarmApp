from django.shortcuts import render
from django.http import JsonResponse
import vonage
from django.utils import timezone
from datetime import timedelta
from .models import CustomUser
import random

# Vonage client setup
client = vonage.Client(key="7ffa6e92", secret="je62Y4jm0SCFdODM")
sms = vonage.Sms(client)

# Constants for OTP validity and cooldown time
OTP_VALIDITY_MINUTES = 5
OTP_COOLDOWN_SECONDS = 60  # Cooldown of 1 minute to request OTP again

from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
def send_otp_view(request):
    if request.method == "POST":
        phone_number = request.POST.get("phone_number")
        
        # Generate a random 6-digit OTP
        otp = random.randint(100000, 999999)
        expiration_time = timezone.now() + timedelta(minutes=OTP_VALIDITY_MINUTES)
        cooldown_time = timezone.now() + timedelta(seconds=OTP_COOLDOWN_SECONDS)

        # Send the OTP
        response = sms.send_message({
            "from": "Smart_farm_application",
            "to": phone_number,
            "text": f"Your verification code is {otp}",
        })

        # Check if the message was sent successfully
        if response["messages"][0]["status"] == "0":
            # Save OTP details in session
            request.session["otp"] = otp
            request.session["phone_number"] = phone_number
            request.session["otp_expiration"] = expiration_time.timestamp()
            request.session["otp_cooldown"] = cooldown_time.timestamp()
            return JsonResponse({"status": "OTP sent successfully"})
        else:
            return JsonResponse({"status": "Failed to send OTP", "error": response["messages"][0]["error-text"]})

@csrf_exempt
@csrf_exempt
def resend_otp_view(request):
    if request.method == "POST":
        phone_number = request.session.get("phone_number")
        
        if not phone_number:
            return JsonResponse({"status": "Phone number not found. Request OTP first."}, status=400)

        # Enforce a cooldown period (e.g., 1 minute) to prevent spamming
        otp_cooldown = request.session.get("otp_cooldown")
        current_time = timezone.now().timestamp()

        if otp_cooldown and current_time < otp_cooldown:
            return JsonResponse({"status": "Please wait before requesting a new OTP."}, status=429)

        # Generate a new OTP and expiration time
        otp = random.randint(100000, 999999)
        expiration_time = timezone.now() + timedelta(minutes=5)

        # Send the OTP
        response = sms.send_message({
            "from": "Smart_farm_application",
            "to": phone_number,
            "text": f"Your new verification code is {otp}",
        })

        if response["messages"][0]["status"] == "0":
            # Update OTP, expiration, and cooldown in the session
            request.session["otp"] = otp
            request.session["otp_expiration"] = expiration_time.timestamp()
            request.session["otp_cooldown"] = current_time + 60  # 1-minute cooldown

            return JsonResponse({"status": "New OTP sent successfully"})
        else:
            return JsonResponse({"status": "Failed to resend OTP", "error": response["messages"][0]["error-text"]}, status=500)



@csrf_exempt
def verify_otp_view(request):
    if request.method == "POST":
        otp = request.POST.get("otp")
        phone_number = request.session.get("phone_number")
        otp_expiration = request.session.get("otp_expiration")

        # Check if OTP and phone number are in the session
        if not phone_number or not otp_expiration:
            return JsonResponse({"status": "Phone number or OTP expired. Request OTP again."}, status=400)

        # Check if OTP is expired
        current_time = timezone.now().timestamp()
        if current_time > otp_expiration:
            # Clear expired OTP from session
            del request.session["otp"]
            del request.session["phone_number"]
            del request.session["otp_expiration"]
            del request.session["otp_cooldown"]
            return JsonResponse({"status": "OTP expired. Request OTP again."}, status=400)

        # Check if OTP matches
        if str(otp) == str(request.session.get("otp")):
            # Check if a user with this phone number exists
            user, created = CustomUser.objects.get_or_create(
                phone_number=phone_number,
                defaults={'username': f"user_{phone_number}"}  # Default username if user is created
            )

            # If the user already exists but `username` is a duplicate, generate a new one
            if not created and CustomUser.objects.filter(username=user.username).exists():
                user.username = f"user_{phone_number}_{random.randint(1000, 9999)}"
                user.save()

            # Mark the user as verified
            user.is_verified = True
            user.save()

            # Clear OTP data from the session after successful verification
            del request.session["otp"]
            del request.session["phone_number"]
            del request.session["otp_expiration"]
            del request.session["otp_cooldown"]

            return JsonResponse({"status": "OTP verified. User created/updated successfully."})
        else:
            return JsonResponse({"status": "Invalid OTP"}, status=400)
