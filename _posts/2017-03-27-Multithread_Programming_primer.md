---
title: 【转】Java多线程机制以及wait、notify、notifyall、synchronized等的使用
date: 2017-03-27 00:57:51
tags:
- Java
- 多线程

---
### 基本原理
每个java对象都有一把锁， 当有多个线程同时访问共享资源的时候， 需要synchronized 来控制安全性， synchronized 分 synchronized 方法 和synchronized块，使用synchronized块时， 一定要显示的获得该对象的锁（如synchronized（object))而方法则不需要。
java的内存模型是对每一个进程有一个主内存， 每个线程有自己的内存， 他们从主内存中取数据， 然后计算， 再存入主内存中。
并发问题如下：如果多个线程同事操作同一数据， A线程从主内存中取的I的值为1， 然后进行加1操作， 这时B线程也取I的值， 进行加2操作， 然后A存入2到主内存中， B也存入， 这样就覆盖了A的值（同数据库中的并发问题一样）。
### 使用机制
#### 基本形式
```java
# 代码块形式
private Object obj = new Object();//自定义同步锁
synchronized(obj) {
		while(!condition) {
			obj.wait();
	}
	obj.doSomething();
}

# 函数形式
public synchronized void change() {
	while(!condition){
		wait();
	}
	...
}
```

当线程A获得了obj锁后，发现条件condition不满足，无法继续下一处理，于是线程A就wait() , 放弃对象锁。
之后在另一线程B中，如果B更改了某些条件，使得线程A的condition条件满足了，就可以唤醒线程A：
```java
synchronized(obj) {
	condition = true;
	obj.notify();
}
```

#### 概念注意
1. 调用`obj`的`wait()`, `notify()`方法前，必须获得obj锁，也就是必须写在`synchronized(obj) {…}` 代码段内。
2. 调用`obj.wait()`后，线程A就释放了`obj`的锁，否则线程B无法获得`obj`锁，也就无法在`synchronized(obj) {…}` 代码段内唤醒A。
3. 当`obj.wait()`方法返回后，线程A需要再次获得`obj`锁，才能继续执行。
4. 如果A1,A2,A3都在`obj.wait()`，则B调用`obj.notify()`只能唤醒A1,A2,A3中的一个（具体哪一个由JVM决定）。
5. `obj.notifyAll()`则能全部唤醒A1,A2,A3，但是要继续执行`obj.wait()`的下一条语句，必须获得`obj`锁，因此，A1,A2,A3只有一个有机会获得锁继续执行，例如A1，其余的需要等待A1释放`obj`锁之后才能继续执行。
6. 当B调用`obj.notify/notifyAll`的时候，B正持有`obj`锁，因此，A1,A2,A3虽被唤醒，但是仍无法获得`obj`锁。直到B退出`synchronized`块，释放obj锁后，A1,A2,A3中的一个才有机会获得锁继续执行。
7. JAVA中规定对非FLOAT, LONG的原始类型的取和存操作为原子操作。 其实就是对一个字（32位）的取，存位原始操作， 因为FLOAT, LONG为两个字节的长度， 所以其取， 存为非原子操作。 如果想把他们也变为原子操作， 可以用`volatile`关键字来修饰.

### 
出处：
http://www.cnblogs.com/adamzuocy/archive/2010/03/08/1680851.html
http://blog.csdn.net/weizhaozhe/article/details/3922647



