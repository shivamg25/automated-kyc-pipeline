from flask import Flask, request, jsonify
import functions_framework
from utils import get_cors_headers
from storage_manager import upload_file_to_storage

@functions_framework.http
def upload_document(request):
    if request.method == "OPTIONS":
        return '', 204, get_cors_headers(is_preflight=True)

    headers = get_cors_headers()

    try:
        if 'file' not in request.files:
            return jsonify({"error": "No file part"}), 400, headers
        uploadedFile = request.files['file']
        if uploadedFile.filename == '':
            return jsonify({"error": "No selected file"}), 400, headers

        message = upload_file_to_storage(uploadedFile, uploadedFile.filename)
        return jsonify({"message": message}), 200, headers
    except Exception as e:
        return jsonify({"error": str(e)}), 500, headers
