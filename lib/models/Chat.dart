class Chat {
  final String name, lastMessage, image, time;
  final bool isActive;

  Chat({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
  });
}

List chatsData = [
  Chat(
    name: "Ethnochatinalists",
    lastMessage: "Donda George sent a video",
    image: "assets/images/user_2.png",
    time: "3m ago",
    isActive: false,
  ),
];
