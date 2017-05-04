# StackFlow

### Development
```bash
$ virtualenv -p python3 --no-site-packages .venv # Create Virtual Environment under .venv
$ source .venv/bin/activate # Switch to local Python in .venv
$ pip install -U pyobjc # Install pyobjc
$
```
### Calendar Integration

Download the credentials file from google developer console
Move it in the calendar_integration folder and name it client_secret.json

#### Development

```bash
$ pip install --upgrade google-api-python-client
$ pip install python-dateutil 
```
Then, you can open StackFlow.xcodeproj and build & run the app.

### Attribution
This software includes the following open source packages:
[ulogme](https://github.com/karpathy/ulogme) - MIT

### License
MIT
