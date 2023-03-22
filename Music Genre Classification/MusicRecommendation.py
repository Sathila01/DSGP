import os
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import requests

# Set your Spotify API credentials
SPOTIPY_CLIENT_ID = '76b62fa654a34f3aa096d8b6fd79d459'
SPOTIPY_CLIENT_SECRET = 'f4f12b9755114eb78f5408499c02cd1d'

client_credentials_manager = SpotifyClientCredentials(client_id=SPOTIPY_CLIENT_ID, client_secret=SPOTIPY_CLIENT_SECRET)
sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

def get_top_10_trending_songs(genre):
    # Get the Spotify category ID for the genre
    categories = sp.categories(limit=50)['categories']['items']
    category_id = None
    for category in categories:
        if category['name'].lower() == genre.lower():
            category_id = category['id']
            break

    if category_id is None:
        print(f"Genre '{genre}' not found.")
        return

    # Get the playlists for the genre
    playlists = sp.category_playlists(category_id, limit=10)['playlists']['items']

    # Get the top 10 trending songs from the genre's playlists
    trending_songs = []
    for playlist in playlists:
        tracks = sp.playlist_tracks(playlist['id'], limit=10)['items']
        for track in tracks:
            if len(trending_songs) >= 10:
                break
            song_info = {
                'name': track['track']['name'],
                'url': track['track']['external_urls']['spotify']
            }
            trending_songs.append(song_info)
        if len(trending_songs) >= 10:
            break

    return trending_songs

if __name__ == "__main__":
    genre = "jazz"
    trending_songs = get_top_10_trending_songs(genre)
    if trending_songs:
        print(f"Top 10 trending songs in {genre} genre:")
        for idx, song in enumerate(trending_songs, start=1):
            print(f"{idx}. {song}")


