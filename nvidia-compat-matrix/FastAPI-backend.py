# Note: needs .env file containing:
#GH_BASIC_CLIENT_ID=your_github_client_id
#GH_BASIC_SECRET_ID=your_github_secret_id


from fastapi import FastAPI, Depends, HTTPException, UploadFile, File
from fastapi.security import OAuth2PasswordBearer
from typing import List
import requests
import os
from dotenv import load_dotenv

load_dotenv()

app = FastAPI()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

@app.post("/upload/")
async def upload_file_to_kodkod(file: UploadFile = File(...), token: str = Depends(oauth2_scheme)):
    user = verify_token(token)
    if not user:
        raise HTTPException(status_code=400, detail="Invalid credentials")

    content = await file.read()

    upload_file_to_kodkod_server(content, user)

def verify_token(token: str):
    # Assuming using OAuth Apps (https://docs.github.com/en/developers/apps/building-oauth-apps)
    client_id = os.getenv('GH_BASIC_CLIENT_ID')
    client_secret = os.getenv('GH_BASIC_SECRET_ID')

    # Exchange the code for a token
    data = {
        'client_id': client_id,
        'client_secret': client_secret,
        'code': token,
    }
    headers = {
        'Accept': 'application/json',
    }
    response = requests.post(
        'https://github.com/login/oauth/access_token',
        headers=headers,
        data=data
    )
    if response.status_code == 200:
        # Extract the token from the response
        return response.json().get("access_token")
    else:
        return None

def upload_file_to_kodkod_server(content, user):
    # TODO: Implement the file upload storage
    # Sanitization/verification and... commit to local git copy of https://github.com/xsub/nvidia-compat-matrix/
    pass

