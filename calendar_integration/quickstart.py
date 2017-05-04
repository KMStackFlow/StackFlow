
from __future__ import print_function
import httplib2
import os

from apiclient import discovery
from oauth2client import client
from oauth2client import tools
from oauth2client.file import Storage
import dateparser
import dateutil.parser
import pytz
import datetime
from datetime import timezone

try:
    import argparse
    flags = argparse.ArgumentParser(parents=[tools.argparser]).parse_args()
except ImportError:
    flags = None

# If modifying these scopes, delete your previously saved credentials
# at ~/.credentials/calendar-python-quickstart.json
SCOPES = 'https://www.googleapis.com/auth/calendar.readonly'
CLIENT_SECRET_FILE = 'client_secret.json'
APPLICATION_NAME = 'Google Calendar API Python Quickstart'





def get_credentials():
    """Gets valid user credentials from storage.

    If nothing has been stored, or if the stored credentials are invalid,
    the OAuth2 flow is completed to obtain the new credentials.

    Returns:
        Credentials, the obtained credential.
    """
    home_dir = os.path.expanduser('~')
    credential_dir = os.path.join(home_dir, '.credentials')
    if not os.path.exists(credential_dir):
        os.makedirs(credential_dir)
    credential_path = os.path.join(credential_dir,
                                   'calendar-python-quickstart.json')

    store = Storage(credential_path)
    credentials = store.get()
    if not credentials or credentials.invalid:
        flow = client.flow_from_clientsecrets(CLIENT_SECRET_FILE, SCOPES)
        flow.user_agent = APPLICATION_NAME
        if flags:
            credentials = tools.run_flow(flow, store, flags)
        else: # Needed only for compatibility with Python 2.6
            credentials = tools.run(flow, store)
        print('Storing credentials to ' + credential_path)
    return credentials

def main():
    """Shows basic usage of the Google Calendar API.

    Creates a Google Calendar API service object and outputs a list of the next
    10 events on the user's calendar.
    """
    credentials = get_credentials()
    http = credentials.authorize(httplib2.Http())
    service = discovery.build('calendar', 'v3', http=http)

    page_token = None
    while True:
      calendar_list = service.calendarList().list(pageToken=page_token).execute()
      for calendar_list_entry in calendar_list['items']:
        print (calendar_list_entry['summary'])
      page_token = calendar_list.get('nextPageToken')
      if not page_token:
        break

    now = datetime.datetime.utcnow().isoformat() + 'Z' # 'Z' indicates UTC time
    print('Getting the upcoming 10 events')
    eventsResult = service.events().list(
        calendarId='primary', timeMin=now, maxResults=10, singleEvents=True,
        orderBy='startTime').execute()
    events = eventsResult.get('items', [])

    if not events:
        print('No upcoming events found.')
    for event in events:
        start = event['start'].get('dateTime', event['start'].get('date'))
        end = event['end'].get('dateTime', event['end'].get('date'))
        print("start: ", start, "end: ", end, event['summary'])

    def promptFlow(events_list):
        start_next_meeting = events_list[0]['start'].get('dateTime', event['start'].get('date')) 
        print("start_next_meeting", start_next_meeting, "type = ", type(start_next_meeting))
        current_time = datetime.datetime.time(datetime.datetime.now(pytz.timezone('US/Eastern')))
        current_date_time = datetime.datetime.now(pytz.timezone('US/Eastern'))
        start_day_time = datetime.time(9, 0, 0, 0,    pytz.timezone('US/Eastern'))
        end_day_time = datetime.time(18, 30, 0, 0,    pytz.timezone('US/Eastern'))
        print("current_time: ", current_time, "type = ", type(current_time))
        print("start_day_time: ", start_day_time, "type = ", type(start_day_time))
        print("end_day_time: ", end_day_time, "type = ", type(end_day_time))


        dt1 = dateutil.parser.parse(start_next_meeting)
        time_till_next_meeting = dt1 - current_date_time
        print( "time_till_next_meeting: ", time_till_next_meeting)
        s = time_till_next_meeting.seconds
        hours_free, remainder = divmod(s, 3600)
        minutes_free, seconds = divmod(remainder, 60)
        print("hours_free: ", hours_free)
        if hours_free >= 1 and start_day_time < current_time < end_day_time :
            print ("It looks like you have more than one hour before your next meeting, let's start a flow time")
        else:
            print ("not enough time for flow")


    promptFlow(events)

    ## two options check free busy to see if free, or look at space between calendar events

    ## free/busy ###
    ## Not being used as of now ###

    start = now
    end = datetime.datetime.utcnow().replace(hour=23, microsecond=0).isoformat() + 'Z'
    print ("start", dateparser.parse(start))
    print ("end", dateparser.parse(end))


    print ("start", start)
    print ("end", end)

    body = {
      "timeMin": start,
      "timeMax": end,
      "timeZone": 'UTC',
      "items": [{"id": 'claireopila@gmail.com'}]
    }

    eventsResult = service.freebusy().query(body=body).execute()
    cal_dict = eventsResult[u'calendars']
    for cal_name in cal_dict:
        print(cal_name, cal_dict[cal_name])

    # def checkFreetime():
    #     if start


    ##How do we prompt flow times if you have the rest of the evening free?


    # freebusy = service.freebusy().query(body=
    #     {"timeMin": start,
    #       "timeMax": end,
    #       "timeZone": 'US',
    #       "items": "primary"
    #     }).execute()
    # print("freebusy is", freebusy)
    # availability = calendar.freebusy().query(body=freebusy_query).execute()


    # freeResult = service.freebusy().list(
    #     calendarId='primary', timeMin=now, maxResults=10, singleEvents=True,
    #     orderBy='startTime').execute()
    # free = freeResult.get('items', [])


if __name__ == '__main__':
    main()