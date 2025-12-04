#  CinéHub - Application Flutter Movies

---


## Documentation de l'API

###  Authentification

**Type :** API Key (v3)  
**Format de la requête :**
```
https://api.themoviedb.org/3/{endpoint}?api_key=YOUR_API_KEY&language=fr-FR
```

###  Endpoints utilisés

#### 2.1 Films au cinéma (Now Playing)
```
GET https://api.themoviedb.org/3/movie/now_playing
```

**Paramètres :**
- `api_key` (obligatoire) : Votre clé API
- `language` (optionnel) : Code langue (ex: fr-FR)
- `page` (optionnel) : Numéro de page (défaut: 1)

**Exemple de requête complète :**
```
https://api.themoviedb.org/3/movie/now_playing?api_key=8d6d91941230817f7807d643736e8a49&language=fr-FR&page=1
```

**Réponse JSON (structure) :**
```json
{
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
      "genre_ids": [18, 53, 35],
      "id": 550,
      "original_language": "en",
      "original_title": "Fight Club",
      "overview": "Un employé de bureau insomniaque et un fabricant de savon...",
      "popularity": 65.789,
      "poster_path": "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
      "release_date": "1999-10-15",
      "title": "Fight Club",
      "video": false,
      "vote_average": 8.433,
      "vote_count": 26280
    }
  ],
  "total_pages": 42,
  "total_results": 832
}
```

#### 2.2 Films à venir (Upcoming)
```
GET https://api.themoviedb.org/3/movie/upcoming
```
**Paramètres identiques à Now Playing**

#### 2.3 Films populaires (Popular)
```
GET https://api.themoviedb.org/3/movie/popular
```
**Paramètres identiques à Now Playing**

#### 2.4 Films les mieux notés (Top Rated)
```
GET https://api.themoviedb.org/3/movie/top_rated
```
**Paramètres identiques à Now Playing**

###  URLs des images

**Format :**
```
https://image.tmdb.org/t/p/{size}{file_path}
```


**Exemples :**
```
https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg
https://image.tmdb.org/t/p/w780/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg
```

###  Détails des champs JSON

| Champ | Type | Description | Exemple |
|-------|------|-------------|---------|
| `id` | int | Identifiant unique du film | `550` |
| `title` | string | Titre du film (traduit) | "Fight Club" |
| `original_title` | string | Titre original | "Fight Club" |
| `overview` | string | Synopsis du film | "Un employé de bureau..." |
| `poster_path` | string/null | Chemin de l'affiche | "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg" |
| `backdrop_path` | string/null | Chemin de l'image de fond | "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg" |
| `release_date` | string | Date de sortie | "1999-10-15" |
| `vote_average` | float | Note moyenne (0-10) | `8.433` |
| `vote_count` | int | Nombre de votes | `26280` |
| `popularity` | float | Score de popularité | `65.789` |
| `genre_ids` | array[int] | IDs des genres | `[18, 53, 35]` |
| `adult` | boolean | Contenu adulte | `false` |
| `original_language` | string | Langue originale | "en" |

###  Codes de statut HTTP

| Code | Signification | Action |
|------|---------------|--------|
| 200 | Succès | Traiter les données |
| 401 | Non autorisé | Vérifier la clé API |
| 404 | Non trouvé | Endpoint incorrect |
| 429 | Trop de requêtes | Attendre et réessayer |
| 500 | Erreur serveur | Réessayer plus tard |

---


###  Licence

Ce projet utilise l'API TMDB sous leurs conditions d'utilisation.

---
