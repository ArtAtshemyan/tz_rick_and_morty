import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/extension/context_extension.dart';
import '/common/theme/app_colors.dart';
import '/domain/entities/character_entity.dart';
import '/presentation/manager/cubit/favorite_character_cubit/favorite_character_cubit.dart';
import '/presentation/widgets/character_cache_image.dart';

class CharacterCard extends StatefulWidget {
  final CharacterEntity character;
  final bool isFavorite;

  const CharacterCard({
    super.key,
    required this.character,
    required this.isFavorite,
  });

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  late bool isFavorite;

  @override
  void initState() {
    isFavorite = widget.isFavorite;
    super.initState();
  }

  void _favoriteCharacter() {
    if (isFavorite) {
      context.read<FavoriteCharacterCubit>().deleteFavoriteCharacters(
            widget.character.id,
          );
      isFavorite = false;
    } else {
      context.read<FavoriteCharacterCubit>().saveFavoriteCharacters(
            widget.character.id,
          );
      isFavorite = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: context.themMode == Brightness.light
                ? AppColors.lightBackground
                : AppColors.darkBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              spacing: 12.0,
              children: [
                CharacterCacheImage(
                  width: 130,
                  height: 130,
                  imageUrl: widget.character.image,
                ),
                Expanded(
                  child: Column(
                    spacing: 5.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.0),
                      Text(
                        widget.character.name,
                        style: context.titleLarge,
                      ),
                      Row(
                        spacing: 4.0,
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              color: widget.character.status == 'Alive'
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${widget.character.status} - ${widget.character.species}',
                              style: context.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'Last known location:',
                        style: context.bodyMedium,
                      ),
                      Text(
                        widget.character.location.name,
                        style: context.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Origin:',
                        style: context.bodyMedium,
                      ),
                      Text(
                        widget.character.origin.name,
                        style: context.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 40,
          right: 10,
          child: IconButton(
            onPressed: () => _favoriteCharacter(),
            icon: Icon(
              isFavorite ? Icons.bookmark : Icons.bookmark_outline,
              size: 44.0,
              color: isFavorite
                  ? Colors.orange
                  : context.themMode == Brightness.light
                      ? AppColors.darkBlue
                      : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
