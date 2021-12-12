class Board:
    def __init__(self, layout, called, name):
        self.layout = layout
        self.called = called
        self.name = name

    def hasWon(self):
        for i in range(0, len(self.layout)):
            if self.checkAcross(i):
                return True
            elif self.checkDown(i):
                return True
        return False
    
    def checkAcross(self, i):
        for j in range(0, len(self.layout[i])):
            if not self.layout[i][j] in self.called:
                return False
        return True

    def checkDown(self, i):
        for j in range(0, len(self.layout[0])):
            if not self.layout[j][i] in self.called:
                return False
        return True

    def calcScore(self, lastCalled):
        def sumUnmarked():
            sum = 0
            for i in range(0, len(self.layout)):
                for j in range(len(self.layout[i])):
                    if not self.layout[i][j] in self.called:
                        sum += int(self.layout[i][j])
            return sum
        print("S: " + str(sumUnmarked()))
        return sumUnmarked() * int(lastCalled)

def makeBoards():
    with open("./python/files/board.txt") as f:
        calls = [] #Todo: Clean this up
        boards = []
        curBoard = []
        name = 1
        for (i, line) in enumerate(f.readlines()):
            if i == 0:
                calls = line.split(',')
            elif line == '\n' and i == 1:
                continue
            elif line == '\n' and i != 1:
                boards.append(Board(curBoard, [], name))
                curBoard = []
                name +=1
            else:
                line = line.replace('\n', '')
                line = ' '.join(line.split())
                curBoard.append(line.split(' '))
        boards.append(Board(curBoard, [], name))
        return (calls, boards)

def pt1():
    [draws, boards] = makeBoards()
    for draw in draws:
        for board in boards:
            board.called.append(draw)
            if board.hasWon():
               return board.calcScore(draw)


def pt2():
    [draws, boards] = makeBoards()
    lastWonTotal = 0
    for draw in draws:
        if len(boards) == 0:
            print(draw)
            return lastWonTotal
        for board in boards:
            board.called.append(draw)
            if board.hasWon():
                lastWonTotal = board.calcScore(draw)
                print("Board " + str(board.name) + " has won after " + draw)
                print(board.called)
                boards.remove(board)
                
    return lastWonTotal

print("The ans for pt1 is: " + str(pt1()))
print("The ans for pt2 is: " + str(pt2()))