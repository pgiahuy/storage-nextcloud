# File Management System with Nextcloud

## Description
This project is a demo of a **file upload/download system** using **Django backend**,  
integrated with a **Nextcloud server** for storage.  
The frontend (HTML/JS/React) calls Django APIs to handle file operations.  
File metadata is stored in **MySQL** for management and tracking.

---

## Requirements

- Python 3.10+  
- Django + Django REST Framework  
- MySQL server  
- Nextcloud server (running)  
- `requests` Python library (for Nextcloud API)

---

## Installation

### 1. Clone the project
```bash
git clone <https://github.com/pgiahuy/storage-nextcloud.git>
cd storage-nextcloud
```
### 2. Create virtual environment & install dependencies
```bash
# Windows
python -m venv venv
venv\Scripts\activate  
pip install --upgrade pip
pip install -r backend/requirements.txt
```
### 3. Configure MySQL in backend/backend/settings.py
```bash
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'db_name',
        'USER': 'db_user',
        'PASSWORD': 'db_password',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}
```
### 4. Configure Nextcloud in backend/apps/files/utils.py
```bash
NEXTCLOUD_URL = "https://<nextcloud_ip_or_domain>/remote.php/dav/files/<username>/"
NEXTCLOUD_USER = "admin"
NEXTCLOUD_PASS = "password"
```
### 5. Migrate database & create Django superuser
```bash
cd backend
python manage.py migrate
python manage.py createsuperuser
```
### 6. Run Django server
```bash
python manage.py runserver
```
🛠️ Admin interface: http://127.0.0.1:8000/admin/

📤 File upload API: http://127.0.0.1:8000/files/upload/ (POST file)

📥 File download API: http://127.0.0.1:8000/files/download/<filename> (GET file)

---

## Usage

- Backend Django calls Nextcloud WebDAV API to upload/download files

- Metadata stored in MySQL:
  - File name, path on Nextcloud
  - Uploader, upload timestamp
- Frontend sends file → Django handles it → Uploads to Nextcloud → Saves metadata

---

## Notes

- Django Admin manages metadata only, not the actual file content

- Make sure the Nextcloud server has enough storage for uploads
