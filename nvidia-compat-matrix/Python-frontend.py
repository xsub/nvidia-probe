import click
import requests

@click.command()
@click.option('--file', '-f', type=click.File('rb'), help='The file to upload.')
@click.option('--token', '-t', prompt=True, hide_input=True, help='Your GitHub token.')
@click.option('--url', '-u', default='http://localhost:8000/upload/', help='The URL of the FastAPI service.')
# TODO: SSL
#@click.option('--url', '-u', default='https://localhost:8000/upload/', help='The URL of the FastAPI service.')

def upload(file, token, url):
    """Upload a file to the FastAPI service."""
    if file:
        files = {'file': file}
        headers = {'Authorization': f'Bearer {token}'}
        response = requests.post(url, files=files, headers=headers)

        if response.status_code == 200:
            click.echo('File uploaded successfully.')
        else:
            click.echo(f'Failed to upload file. Status code: {response.status_code}.')
    else:
        click.echo('You must specify a file to upload.')

if __name__ == '__main__':
    upload()

