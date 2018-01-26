# pythonjjw.github.io
from  peewee import *
import os,base64
import time
import pyautogui as pag
from PIL import ImageGrab
import zlib, urllib
import pythoncom
import pyHook
import win32api
import win32con
db=SqliteDatabase('mouse_click.db')

__authur__ = "jjw"

class BaseModel(Model):
    class Meta:
        database=db
#用peewee建立数据库和表格
# 点击的用例表

class click_case(BaseModel):
    Screen_coord    = CharField(null=True)#1、屏幕坐标 json 或者字符串 {x:"",y:""}
    Picture_shot    = CharField(null=True)#4、画面截图         文件

 
#增加数据，注意传递图片的时候传递的是图片所在路径
def click_case_create_item(Screen_coord=None,Picture_shot=None):
    if(Picture_shot!=None):
        f=open(Picture_shot,'rb') #二进制方式打开图文件
        ls_f=base64.b64encode(f.read()) #读取文件内容，转换为base64编码
#str1为二进制
        str1 = zlib.compress(ls_f, 9)
#变成二进制形式的字符串了
        Picture_shot=str(ls_f , encoding='utf-8')
        click_case.create(Screen_coord=Screen_coord
                     ,Picture_shot=Picture_shot )


def onMouse_leftdown(event):
    # 监听鼠标左键按下事件
    global  count,tup1,tup2
    count+=1
    position=event.Position
    if( ((position[0]>=tup1[0])&(position[0]<=tup2[0]))&((position[1]>=tup1[1])&(position[1]<=tup2[1])) ):
        box=(tup1[0],tup1[1],tup2[0],tup2[1])
        img = ImageGrab.grab(box)
        img.save("D:/work/shot_cut_work/picture/"+"shot_"+str(count)+"."+"jpg")
        file_name=''
        file_name="D:/work/shot_cut_work/picture/"+"shot_"+str(count)+"."+"jpg"
        print(event.Position)
        print ("left DOWN DOWN" )
        click_case_create_item(event.Position,file_name)
    else:
        pass
    return True
    # 返回 True 表示响应此事件，False表示拦截

def main():
    db.connect()
    #建立三个表格
    # TO.DO   需要表格存在，需要判断当前表格是不是当前的格式，表格需要进行修改，如果表格不存在，则表格需要创建
    #改函数加上Ture参数后，peewee将在创建它之前检查该表格是否存在
    db.create_tables([click_case, ],True)
    hm = pyHook.HookManager()

    hm.MouseLeftDown = onMouse_leftdown

    hm.HookMouse()

    # 进入循环，如不手动关闭，程序将一直处于监听状态
    pythoncom.PumpMessages()


if __name__ == "__main__":
    count=0
    tup1=(0,0)
    tup2=(700,500)
    # up_num = 0
    # # 新线程执行的代码:
    # print('thread %s is running...' % threading.current_thread().name)
    # t = threading.Thread(target=send_click, name='sendThread')
    # t.start()
    # # t.join()
    main()
