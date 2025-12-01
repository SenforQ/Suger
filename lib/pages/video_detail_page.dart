import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
import 'report_page.dart';
import '../utils/preference_helper.dart';

class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({
    super.key,
    required this.character,
    required this.videoPath,
  });

  final Map<String, dynamic> character;
  final String videoPath;

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isLoading = true;
  bool _isLiked = false;
  bool _isFavorited = false;
  int _currentLikeNum = 0;
  int _currentFollowNum = 0;

  @override
  void initState() {
    super.initState();
    _currentLikeNum = widget.character['SugerShowLike'] as int;
    _currentFollowNum = widget.character['SugerShowFollowNum'] as int;
    _loadSavedStates();
    _initializeVideo();
  }

  Future<void> _loadSavedStates() async {
    final String nickName = widget.character['SugerNickName'] as String;
    final bool liked = await PreferenceHelper.isLiked(nickName);
    final bool favorited = await PreferenceHelper.isFavorited(nickName);
    
    final int baseLikeNum = widget.character['SugerShowLike'] as int;
    final int baseFollowNum = widget.character['SugerShowFollowNum'] as int;
    
    setState(() {
      _isLiked = liked;
      _isFavorited = favorited;
      
      _currentLikeNum = baseLikeNum;
      _currentFollowNum = baseFollowNum;
      
      if (liked) {
        _currentLikeNum += 1;
        _currentFollowNum += 1;
      }
      if (favorited) {
        _currentFollowNum += 1;
      }
    });
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset(widget.videoPath);
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _isLoading = false;
          _isPlaying = _controller!.value.isPlaying;
        });
        _controller!.setLooping(true);
        _controller!.addListener(_videoListener);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _videoListener() {
    if (_controller != null && mounted) {
      setState(() {
        _isPlaying = _controller!.value.isPlaying;
      });
    }
  }

  void _togglePlayPause() {
    if (_controller == null || !_isInitialized) return;

    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
        _isPlaying = false;
      } else {
        _controller!.play();
        _isPlaying = true;
      }
    });
  }

  void _toggleLike() async {
    final String nickName = widget.character['SugerNickName'] as String;
    final bool wasLiked = _isLiked;
    
    setState(() {
      _isLiked = !_isLiked;
      
      if (_isLiked && !wasLiked) {
        _currentLikeNum += 1;
        _currentFollowNum += 1;
      } else if (!_isLiked && wasLiked) {
        _currentLikeNum -= 1;
        _currentFollowNum -= 1;
      }
    });
    
    await PreferenceHelper.setLiked(nickName, _isLiked);
  }

  void _toggleFavorite() async {
    final String nickName = widget.character['SugerNickName'] as String;
    final bool wasFavorited = _isFavorited;
    
    setState(() {
      _isFavorited = !_isFavorited;
      
      if (_isFavorited && !wasFavorited) {
        _currentFollowNum += 1;
      } else if (!_isFavorited && wasFavorited) {
        _currentFollowNum -= 1;
      }
    });
    
    await PreferenceHelper.setFavorited(nickName, _isFavorited);
  }

  Map<String, dynamic> _getUpdatedCharacter() {
    final updatedCharacter = Map<String, dynamic>.from(widget.character);
    updatedCharacter['SugerShowLike'] = _currentLikeNum;
    updatedCharacter['SugerShowFollowNum'] = _currentFollowNum;
    return updatedCharacter;
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ReportPage(
                    character: widget.character,
                  ),
                ),
              );
            },
            child: const Text(
              'Report',
              style: TextStyle(
                color: Color(0xFF007AFF),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop({
                'action': 'block',
                'character': _getUpdatedCharacter(),
              });
            },
            isDestructiveAction: true,
            child: const Text(
              'Block',
              style: TextStyle(
                color: Color(0xFFFF3B30),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop({
                'action': 'mute',
                'character': _getUpdatedCharacter(),
              });
            },
            isDestructiveAction: true,
            child: const Text(
              'Mute',
              style: TextStyle(
                color: Color(0xFFFF3B30),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Color(0xFF007AFF),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final String userIcon = widget.character['SugerUserIcon'] as String;
    final String nickName = widget.character['SugerNickName'] as String;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop({
          'action': 'update',
          'character': _getUpdatedCharacter(),
        });
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(
              child: _VideoPlayerSection(
                controller: _controller,
                isInitialized: _isInitialized,
                isPlaying: _isPlaying,
                isLoading: _isLoading,
                onTogglePlayPause: _togglePlayPause,
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  _AppBar(
                    onBack: () {
                      Navigator.of(context).pop({
                        'action': 'update',
                        'character': _getUpdatedCharacter(),
                      });
                    },
                    onInfo: () => _showActionSheet(context),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        _ProfileHeader(
                          userIcon: userIcon,
                          nickName: nickName,
                          followNum: _currentFollowNum,
                          likeNum: _currentLikeNum,
                          isLiked: _isLiked,
                          isFavorited: _isFavorited,
                        ),
                        const SizedBox(height: 24),
                        _ActionButtons(
                          isLiked: _isLiked,
                          isFavorited: _isFavorited,
                          onLike: _toggleLike,
                          onFavorite: _toggleFavorite,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_isInitialized)
              Center(
                child: GestureDetector(
                  onTap: _togglePlayPause,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    required this.onBack,
    required this.onInfo,
  });

  final VoidCallback onBack;
  final VoidCallback onInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onBack,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Color(0xFF222222),
              ),
            ),
          ),
          GestureDetector(
            onTap: onInfo,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.info_outline,
                size: 20,
                color: Color(0xFF222222),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.userIcon,
    required this.nickName,
    required this.followNum,
    required this.likeNum,
    required this.isLiked,
    required this.isFavorited,
  });

  final String userIcon;
  final String nickName;
  final int followNum;
  final int likeNum;
  final bool isLiked;
  final bool isFavorited;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              userIcon,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nickName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _StatItem(
                    icon: isFavorited ? Icons.favorite : Icons.favorite_outline,
                    count: followNum,
                    label: 'Followers',
                    isHighlighted: isFavorited,
                  ),
                  const SizedBox(width: 20),
                  _StatItem(
                    icon: isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    count: likeNum,
                    label: 'Likes',
                    isHighlighted: isLiked,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.count,
    required this.label,
    this.isHighlighted = false,
  });

  final IconData icon;
  final int count;
  final String label;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: isHighlighted
              ? const Color(0xFFFFC600)
              : Colors.white.withOpacity(0.8),
        ),
        const SizedBox(width: 4),
        Text(
          '$count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _VideoPlayerSection extends StatelessWidget {
  const _VideoPlayerSection({
    required this.controller,
    required this.isInitialized,
    required this.isPlaying,
    required this.isLoading,
    required this.onTogglePlayPause,
  });

  final VideoPlayerController? controller;
  final bool isInitialized;
  final bool isPlaying;
  final bool isLoading;
  final VoidCallback onTogglePlayPause;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    if (isLoading) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xFFFFC600),
          ),
        ),
      );
    }
    
    if (isInitialized && controller != null) {
      return SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: controller!.value.size.width,
            height: controller!.value.size.height,
            child: VideoPlayer(controller!),
          ),
        ),
      );
    }
    
    return Container(
      color: Colors.black,
      child: const Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 48,
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.isLiked,
    required this.isFavorited,
    required this.onLike,
    required this.onFavorite,
  });

  final bool isLiked;
  final bool isFavorited;
  final VoidCallback onLike;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onLike,
          child: Container(
            width: 120,
            height: 48,
            decoration: BoxDecoration(
              color: isLiked ? const Color(0xFFFFC600) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isLiked ? const Color(0xFFFFC600) : const Color(0xFFE0E0E0),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  size: 20,
                  color: isLiked ? const Color(0xFF222222) : const Color(0xFF666666),
                ),
                const SizedBox(width: 6),
                Text(
                  isLiked ? 'Liked' : 'Like',
                  style: TextStyle(
                    color: isLiked ? const Color(0xFF222222) : const Color(0xFF666666),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: onFavorite,
          child: Container(
            width: 120,
            height: 48,
            decoration: BoxDecoration(
              color: isFavorited ? const Color(0xFFFFC600) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isFavorited ? const Color(0xFFFFC600) : const Color(0xFFE0E0E0),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border,
                  size: 20,
                  color: isFavorited ? const Color(0xFF222222) : const Color(0xFF666666),
                ),
                const SizedBox(width: 6),
                Text(
                  isFavorited ? 'Saved' : 'Save',
                  style: TextStyle(
                    color: isFavorited ? const Color(0xFF222222) : const Color(0xFF666666),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

