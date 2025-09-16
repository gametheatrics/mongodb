# Deploy MongoDB with Authentication on Render

This repo deploys [MongoDB] with username/password authentication on Render. The setup includes a root admin user and additional application users for secure database access.

## Features

- ✅ **Authentication Enabled**: MongoDB runs with `--auth` flag
- ✅ **Port Exposed**: Fixes "no open ports detected" error on Render
- ✅ **Multiple Users**: Root admin, application user, and read-only user
- ✅ **Environment Variables**: Configurable credentials via Render dashboard
- ✅ **Auto-initialization**: Users created automatically on first startup

## Quick Deploy on Render

### One Click Deploy

[![Deploy to Render](http://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

### Manual Deployment

1. **Create a new Web Service on Render**

   - Connect your GitHub repository
   - Choose "Docker" as the environment

2. **Set Environment Variables in Render Dashboard**

   ```
   MONGO_INITDB_ROOT_USERNAME=your_admin_username
   MONGO_INITDB_ROOT_PASSWORD=your_secure_password
   MONGO_INITDB_DATABASE=admin
   ```

3. **Configure Service Settings**

   - **Port**: `27017` (automatically detected)
   - **Health Check Path**: Leave empty (MongoDB doesn't use HTTP)
   - **Persistent Disk**: Add disk mounted to `/data/db` for data persistence

4. **Deploy**
   - Click "Create Web Service"
   - Wait for deployment to complete

## Created User Accounts

The setup automatically creates these users:

### Root Admin User

- **Username**: Set via `MONGO_INITDB_ROOT_USERNAME` (default: `admin`)
- **Password**: Set via `MONGO_INITDB_ROOT_PASSWORD` (default: `password123`)
- **Database**: `admin`
- **Permissions**: Full administrative access

### Application User

- **Username**: `appuser`
- **Password**: `apppass123`
- **Database**: `myapp`
- **Permissions**: Read/Write access to `myapp` database

### Read-Only User

- **Username**: `readonly`
- **Password**: `readonly123`
- **Database**: `myapp`
- **Permissions**: Read-only access to `myapp` database

## Connection Examples

### From Your Application

```javascript
// Using the admin user
const uri =
  "mongodb://your_admin_username:your_secure_password@your-service.onrender.com:27017/admin";

// Using the application user
const uri =
  "mongodb://appuser:apppass123@your-service.onrender.com:27017/myapp";
```

### Using MongoDB Compass or CLI

```bash
# Connect as admin
mongosh "mongodb://your_admin_username:your_secure_password@your-service.onrender.com:27017/admin"

# Connect as application user
mongosh "mongodb://appuser:apppass123@your-service.onrender.com:27017/myapp"
```

## Important Security Notes

1. **Change Default Passwords**: Always set strong passwords via environment variables
2. **Use Application Users**: Don't use the admin user for application connections
3. **Network Security**: Render provides HTTPS/TLS encryption by default
4. **Regular Backups**: Set up regular database backups

## Troubleshooting

### "No Open Ports Detected" Error

✅ **Fixed**: The Dockerfile now includes `EXPOSE 27017` and `--bind_ip_all`

### Authentication Issues

- Verify environment variables are set in Render dashboard
- Check username/password combination
- Ensure you're connecting to the correct database

### Connection Timeouts

- Verify your service is running in Render dashboard
- Check if you're using the correct hostname (your-service.onrender.com)
- Ensure your application allows outbound connections on port 27017

## Local Development

To test locally with Docker:

```bash
# Build and run
docker build -t mongodb-auth .
docker run -d \
  --name mongodb-test \
  -p 27017:27017 \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=password123 \
  mongodb-auth

# Connect locally
mongosh "mongodb://admin:password123@localhost:27017/admin"
```

## Support

For MongoDB deployment help on Render: https://render.com/docs/deploy-mongodb

If you need assistance, chat with us at https://render.com/chat.

[MongoDB]: https://www.mongodb.com/
