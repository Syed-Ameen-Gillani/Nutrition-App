import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrovite/features/settings/bloc/theme_cubit.dart';

class Appearances extends StatelessWidget {
  const Appearances({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearances'),
        centerTitle: true,
      ),
      body: BlocBuilder<ThemeModeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text(
                //   'Appearance Settings',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                // const SizedBox(height: 20),
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Theme Mode',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        DropdownButton<ThemeMode>(
                          value: themeMode,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 4,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          dropdownColor: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          onChanged: (ThemeMode? newThemeMode) {
                            if (newThemeMode != null) {
                              context
                                  .read<ThemeModeCubit>()
                                  .setThemeMode(newThemeMode);
                            }
                          },
                          items: ThemeMode.values
                              .map<DropdownMenuItem<ThemeMode>>(
                                  (ThemeMode value) {
                            return DropdownMenuItem<ThemeMode>(
                              value: value,
                              child: Text(
                                value.toString().split('.').last,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
