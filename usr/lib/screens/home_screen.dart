import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedMood = -1;
  final List<String> _moodEmojis = ['😫', '😕', '🙂', '🤩'];
  final List<String> _moodLabels = ['Stressed', 'Okay', 'Good', 'Great'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning, Alex',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Let\\'s make today productive.',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Morning Check-in (Engagement Driver)
            _buildSectionTitle(theme, 'Morning Check-in', 'Required 1/2 daily interactions'),
            const SizedBox(height: 12),
            _buildMoodTracker(theme),
            const SizedBox(height: 24),

            // 2. AI Task Automation (Removes Manual Work)
            _buildSectionTitle(theme, 'AI Daily Priorities', 'Auto-generated from your emails & slack'),
            const SizedBox(height: 12),
            _buildAITaskCard(
              theme, 
              'Review Q3 Marketing Deck', 
              'AI summarized 14 comments. 3 require your approval.',
              Icons.auto_awesome,
            ),
            const SizedBox(height: 8),
            _buildAITaskCard(
              theme, 
              'Approve Timesheets', 
              'Routine task. AI verified all entries match schedules.',
              Icons.fact_check_outlined,
            ),
            const SizedBox(height: 24),

            // 3. Peer Recognition (Engagement & Culture)
            _buildSectionTitle(theme, 'Team Pulse', 'Recent recognitions'),
            const SizedBox(height: 12),
            _buildRecognitionCard(theme),
            
            const SizedBox(height: 80), // Space for FAB
          ],
        ),
      ),
      // Conversational UI Trend
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/chat'),
        icon: const Icon(Icons.auto_awesome),
        label: const Text('Ask AI Assistant'),
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary),
        ),
      ],
    );
  }

  Widget _buildMoodTracker(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How are you feeling today?',
            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (index) {
              final isSelected = _selectedMood == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedMood = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? theme.colorScheme.primaryContainer : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(_moodEmojis[index], style: const TextStyle(fontSize: 32)),
                      const SizedBox(height: 4),
                      Text(
                        _moodLabels[index],
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAITaskCard(ThemeData theme, String title, String subtitle, IconData icon) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.secondaryContainer,
          child: Icon(icon, color: theme.colorScheme.onSecondaryContainer, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: IconButton(
          icon: const Icon(Icons.check_circle_outline),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildRecognitionCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.tertiaryContainer,
            theme.colorScheme.primaryContainer.withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onTertiaryContainer),
                    children: const [
                      TextSpan(text: 'Sarah ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'sent a Kudos to '),
                      TextSpan(text: 'David', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '"Thanks for helping me debug the API issue yesterday! 🚀"',
                  style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
