# pythonjjw.github.io
from  peewee import *
import os,base64
db=SqliteDatabase('peewee.db')

__authur__ = "jjw"

class BaseModel(Model):
    class Meta:
        database=db
#用peewee建立数据库和表格
# 点击的用例表

class click_case(BaseModel):
    Screen_coord    = CharField(null=True)#1、屏幕坐标 json 或者字符串 {x:"",y:""}
    Picture_descrip = CharField(null=True)#2、画面描述         字符串
    Click_descrip   = CharField(null=True)#3、点击的部品描述   字符串
    Picture_shot    = CharField(null=True)#4、画面截图         文件
    # image  需要进行 base64转换    读取 图片进行base64转换保存至数据库    查询的时候 反向base64转换  即可生成文件
    # 压缩的方法
# 测试地点表
class pos_case(BaseModel):
    Lat             = CharField(null=True)#1、经度        字符串      ##度分秒  
    lon             = CharField(null=True)#2、纬度        字符串      ##度分秒  
    descrip         = CharField(null=True)#3、说明        字符串

# 测试组合表
class evaluation_case(BaseModel):
    Tes_locate      = ForeignKeyField(pos_case, related_name='Points',null=True)#1、测试地点 外键 一对多
    point_descrip   = CharField(null=True)#2、点说明 json 或者字符串
    descrip         = CharField(null=True)#3、说明     字符串

 
#增加数据，注意传递图片的时候传递的是图片所在路径
def click_case_create_item(Screen_coord=None,Picture_descrip=None,Click_descrip=None,Picture_shot=None):
    if(Picture_shot!=None):
        f=open(Picture_shot,'rb') #二进制方式打开图文件
        ls_f=base64.b64encode(f.read()) #读取文件内容，转换为base64编码
        Picture_shot=str(ls_f)
    click_case.create(Screen_coord=Screen_coord
                     ,Picture_descrip=Picture_descrip
                     ,Click_descrip=Click_descrip
                     ,Picture_shot=Picture_shot )

#删除数据
def click_case_delete_item(click_case_ID):
    st = click_case.get(click_case.id==click_case_ID)
    st.delete_instance()

#修改数据
def click_case_updata_item(click_case_ID,Screen_coord=None,Picture_descrip=None,Click_descrip=None,Picture_shot=None):
    if(Picture_shot!=None):
        f=open(Picture_shot,'rb') #二进制方式打开图文件
        ls_f=base64.b64encode(f.read()) #读取文件内容，转换为base64编码
        Picture_shot=str(ls_f)
    else:
        pass
    click_case.update(Screen_coord=Screen_coord,Picture_descrip=Picture_descrip,Click_descrip=Click_descrip,Picture_shot=Picture_shot).where(click_case.id==click_case_ID ).execute()
#查询数据
def click_case_query_item(Screen_coord="null",Picture_descrip="null",Click_descrip="null",Picture_shot="null"):
    if(Picture_shot!=None):
        f=open(Picture_shot,'rb') #二进制方式打开图文件
        ls_f=base64.b64encode(f.read()) #读取文件内容，转换为base64编码
        Picture_shot=str(ls_f)
    else: 
        pass
    str2 = click_case.select().where(
    (click_case.Screen_coord==Screen_coord)|(click_case.Click_descrip==Click_descrip)
    |(click_case.Picture_descrip==Picture_descrip)|(click_case.Picture_shot==Picture_shot))
    if(len(str2)!=0):
        for i in str2:  
            imgdata=base64.b64decode(b"i.Picture_shot")  
            file=open('1.gif','wb')  
            file.write(imgdata)  
            file.close()  
            print (i.Screen_coord,i.Picture_descrip,i.Click_descrip)
    else:
        pass

#增加数据
def pos_case_create_item(Lat=None,lon=None,descrip=None):
    pos_case.create(Lat=Lat
                   ,lon=lon
                   ,descrip=descrip )


#删除数据
def pos_case_delete_item(pos_case_ID):
    st = pos_case.get(pos_case.id==pos_case_ID)
    st.delete_instance()

#修改数据
def pos_case_updata_item(pos_case_ID,Lat=None,lon=None,descrip=None):
    pos_case.update(Lat=Lat,lon=lon,descrip=descrip).where(pos_case.id==pos_case_ID ).execute()

#查询数据
def pos_case_query_item(Lat="null",lon="null",descrip="null"):
    str2 = pos_case.select().where(
    (pos_case.Lat==Lat)
    |(pos_case.descrip==descrip)
    |(pos_case.lon==lon))
    for i in str2:
        print (i.Lat,i.descrip,i.lon)

#增加数据，通过数据进行自动增加
def evaluation_case_create_item(Tes_locate=None,point_descrip=None,descrip=None):
    evaluation_case.create(Tes_locate=Tes_locate
                          ,point_descrip=point_descrip
                          ,descrip=descrip )

#删除数据，通过id进行删除
def evaluation_case_delete_item(evaluation_case_ID):
    st = evaluation_case.get(evaluation_case.id==evaluation_case_ID)
    st.delete_instance()

#修改数据，通过id与修改值进行update
def evaluation_case_updata_item(evaluation_case_ID,Tes_locate=None,point_descrip=None,descrip=None):
    evaluation_case.update(Tes_locate=Tes_locate,point_descrip=point_descrip,descrip=descrip).where(evaluation_case.id==evaluation_case_ID ).execute()

#查询数据，可以该表的任意一个或多个字段进行查询
def evaluation_case_query_item(Tes_locate="null",point_descrip="null",descrip="null"):
    str2 = evaluation_case.select().where(
    (evaluation_case.Tes_locate==Tes_locate)
    |(evaluation_case.descrip==descrip)
    |(evaluation_case.point_descrip==point_descrip))
    for i in str2:
        print (i.Tes_locate,i.descrip,i.point_descrip)





 #click_case测试函数
def click_case_test(click_case_1):
    click_case_create_item()
    click_case_delete_item()
    click_case_updata_item()
    click_case_query_item()


#pos_case测试函数
def pos_case_test(pos_case_1):
    pos_case_create_item()
    pos_case_delete_item()
    pos_case_updata_item()
    pos_case_query_item()
    

#evaluation_case测试函数
def evaluation_case_test(evaluation_case_1):
    evaluation_case_create_item()
    evaluation_case_delete_item()
    evaluation_case_updata_item()
    evaluation_case_query_item()



#主函数运行进行数据库的增删改查
def main():
    #数据库连接
    db.connect()
    #建立三个表格
    # TO.DO   需要表格存在，需要判断当前表格是不是当前的格式，表格需要进行修改，如果表格不存在，则表格需要创建
    #改函数加上Ture参数后，peewee将在创建它之前检查该表格是否存在
    db.create_tables([click_case, pos_case,evaluation_case])

    click_case_create_item("xing","ming","xiao",'D:\work\peewee_work\shot_screen.gif')
    click_case_query_item(Picture_shot='D:\work\peewee_work\shot_screen.gif')
    # pos_case_create_item("xing","ming","xiao")
    # pos_case_create_item("xing","hajs","sjjw")
    # pos_case_create_item("xing","ming","xiao")
    # pos_case_create_item("xing","hajs","sjjw")
    # pos_case_delete_item(2)
    # pos_case_create_item("xing","ming","xiao")
    # pos_case_updata_item(1,"dog","dog","dog")
    # pos_case_create_item("cili","cili","deli")
    # pos_case_create_item("cili","cili","ddo")
    # pos_case_query_item (lon="cili")
    # #click_case测试函数
    # click_case_test()
    # #pos_case测试函数
    # pos_case_test()
    # #evaluation_case测试函数
    # evaluation_case_test()



if __name__ == '__main__':
    main()
