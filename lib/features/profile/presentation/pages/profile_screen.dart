import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        children: [
          // --- HEADER: User Info ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text(
                    'KD', // Dummy initials
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Karim Developer', // Dummy Name
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'karim.dev@example.com', // Dummy Email
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          const Divider(height: 1),

          // --- SECTION: Account ---
          _buildSectionHeader(context, 'Account'),
          _buildListTile(
            context,
            icon: Icons.receipt_long_outlined,
            title: 'Order History',
            onTap: () {}, // TODO: Wire up to past orders
          ),
          _buildListTile(
            context,
            icon: Icons.credit_card_outlined,
            title: 'Payment Methods',
            onTap: () {},
          ),
          _buildListTile(
            context,
            icon: Icons.location_on_outlined,
            title: 'Saved Addresses',
            onTap: () {},
          ),

          const Divider(height: 1),

          // --- SECTION: Settings (Ready for Step 4) ---
          _buildSectionHeader(context, 'App Settings'),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
            leading: Icon(Icons.dark_mode_outlined, color: theme.colorScheme.primary),
            title: Text(
              'Dark Mode',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            trailing: Switch(
              value: false, // TODO: Wire up to ThemeCubit in Step 4
              onChanged: (value) {},
            ),
          ),
          _buildListTile(
            context,
            icon: Icons.language_outlined,
            title: 'Language',
            trailingText: 'English',
            onTap: () {},
          ),

          const Divider(height: 1),

          // --- SECTION: Auth (Ready for Step 6) ---
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: OutlinedButton.icon(
              onPressed: () {}, // TODO: Wire up to AuthCubit in Step 6
              icon: const Icon(Icons.logout),
              label: const Text('Log Out'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                foregroundColor: theme.colorScheme.error,
                side: BorderSide(color: theme.colorScheme.error.withValues(alpha: 0.5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER METHODS ---

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildListTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        String? trailingText,
        required VoidCallback onTap,
      }) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      trailing: trailingText != null
          ? Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            trailingText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, size: 20),
        ],
      )
          : const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}