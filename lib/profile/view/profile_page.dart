import 'package:animate_do/animate_do.dart';
import 'package:bikex/auth/auth.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/widgets/icon_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final user = switch (state) {
          AuthAuthenticated(:final user) => user,
          _ => null,
        };

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar with consistent IconCircle style
              const IconCircle(
                icon: Icons.person,
                size: 100,
                iconSize: 56,
              ),
              const SizedBox(height: 20),
              // Name with fade animation
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 400),
                child: Text(
                  user?.name ?? 'Guest',
                  style: const TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Email with fade animation
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 400),
                child: Text(
                  user?.email ?? '',
                  style: const TextStyle(
                    color: AppTheme.textDescColor,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Sign out button with fade animation
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 400),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => context.read<AuthCubit>().signOut(),
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 14,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.logout, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Sign Out',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
