import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  static const String _historyKey = 'search_history';
  static const int _maxHistoryItems = 10;

  // Récupérer l'historique
  Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_historyKey) ?? [];
    return history;
  }

  // Ajouter une recherche à l'historique
  Future<void> addToHistory(String query) async {
    if (query.trim().isEmpty) return;
    
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_historyKey) ?? [];
    
    // Supprimer si existe déjà (pour le remettre en premier)
    history.remove(query);
    
    // Ajouter au début
    history.insert(0, query);
    
    // Limiter la taille de l'historique
    if (history.length > _maxHistoryItems) {
      history = history.sublist(0, _maxHistoryItems);
    }
    
    await prefs.setStringList(_historyKey, history);
  }

  // Supprimer un élément de l'historique
  Future<void> removeFromHistory(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_historyKey) ?? [];
    history.remove(query);
    await prefs.setStringList(_historyKey, history);
  }

  // Effacer tout l'historique
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}