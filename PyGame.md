# Pygame

1. 事件处理

   ```python
   def getEvent(self):
       #获取所有事件
       eventList = pygame.event.get()
       #遍历事件
       for event in eventList:
           if event.type == pygame.QUIT:
               print("退出游戏")
               self.endGame()
           if event.type == pygame.KEYDOWN:
               if event.key == pygame.K_LEFT:
                   print("按住左键，向左移动")
               elif event.key == pygame.K_RIGHT:
                   print("按住下键，向又移动")
               elif event.key == pygame.K_UP:
                   print("按住上键，向上移动")
               elif event.key == pygame.K_DOWN:
                   print("按住下键，向下移动")
   ```

2. 字体初始化和绘制

   ```python
   
   ```

   

