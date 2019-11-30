;;; .doom.d/config.el -*- lexical-binding: t; -*-

(setq cc-lpass-spotify "auth/spotify-app")
(defalias 'cc-fetch-spotify-id (apply-partially 'cc-lpass-user cc-lpass-spotify))
(defalias 'cc-fetch-spotify-secret (apply-partially 'cc-lpass-pass cc-lpass-spotify))

(def-package! spotify
  :config
  (setq spotify-oauth2-client-id (funcall 'cc-fetch-spotify-id))
  (setq spotify-oauth2-client-secret (funcall 'cc-fetch-spotify-secret))
  (setq spotify-transport 'connect)
  (map! :leader
        "a SPC" #'spotify-toggle-play
        "a l" #'spotify-next-track
        "a h" #'spotify-previous-track
        "a j" #'spotify-volume-down
        "a k" #'spotify-volume-up
        "a s" #'spotify-track-search
        "a S" #'spotify-playlist-search
        "a p" #'spotify-my-playlists
        "a d" #'spotify-select-device
        "a r" #'spotify-recently-played
        "a t r" #'spotify-toggle-repeat
        "a t m" #'spotify-volume-mute-unmute
        "a t s" #'spotify-volume-mute-shuffle)
  (map! :map spotify-track-search-mode-map
        :n "RET" #'spotify-track-select
        :n "f" #'spotify-track-add
        :n "s" #'spotify-track-search)
  (map! :map spotify-playlist-search-mode-map
        :n "f" #'spotify-playlist-follow
        :n "F" #'spotify-playlist-unfollow
        :n "s" #'spotify-playlist-search)
  (map! :map (spotify-track-search-mode-map spotify-device-select-mode-map spotify-playlist-search-mode-map)
        :n "q" #'kill-this-buffer))
