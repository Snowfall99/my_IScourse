### 分组交换：
1. **存储转发传输：** 存储转发传输是指在交换机能够开始向输出链路传输该分组的第一个比特之前，必须接收到整个分组。  
考虑一般情况：通过由N条速率均为R的链路组成的路径（在源和目的之间有N-1台路由器），从源到目的地发送一个分组，端到端时延时：$d_{端到端}=N\frac{L}{R}$
1. **排队时延和分组丢失：** 每台分组交换机有多条链路与之相连。对于每条相连的链路，该分组交换机具有一个输出缓存，用于存储路由器准备发往那条链路的分组。如果到达分组需要传输到某条链路，但是发现该链路正忙于传输其他分组，该到达分组必须在输出缓存中等待。因此，除了存储转发时延以外，分组还要承受输出缓存的排队时延。  
因为缓存空间的大小是有限的，一个到达的分组可能发现该缓存已被其他等待传输的分组完全充满了，在此情况下，将出现分组丢失（丢包），到达的分组或已经排队的分组之一将被丢弃。
1. **转发表和路由选择协议：** 在因特网中，每个端系统具有一个被称为IP地址的地址。当源主机要向目的端系统发送一个分组时，源在该分组的首部包含了目的地址的IP地址。当一个分组到达时，路由器检查该分组的目的地址的一部分，并向一台相邻路由器转发该分组。更特别的是，每台路由器具有一个转发表，用于将目的地址（或目的地址的一部分）映射成为输出链路。当分组到达一台路由器时，路由器检查该地址，并用这个目的地址搜索其转发表，已发现适当的出链路。路由器则将分组导向该出链路。

### 电路交换：
在电路交换网络中，在端系统间通信会话期间，预留了端系统间沿路径通信所需要的资源（缓存，链路传输速率）  
1. **电路交换网络中的复用：** 链路中的电路是通过频分复用（FDM）或时分复用（TDM）来实现的
    - FDM：链路的频谱由跨越链路创建的所有链接共享。特别地，在连接期间链路为每条连接专用一个频段。
    - TDM：对于一条TDM链路，时间被划分为固定周期的帧，并且每个帧又被划分为固定数量的时隙。当网络跨越一条链路创建一条连接时，网络中每个帧中为该连接指定了一个时隙。这些时隙专门由该连接单独使用，一个时隙可用于传输该连接的数据

### 时延的类型：
1. **处理时延：** 检查分组首部和决定将该分组导向何处所需的时间是处理时延的一部分
1. **排队时延：** 在队列中，当分组在链路上等待传输时，它经受排队时延。一个特定分组的排队时延长度将取决于先期到达的正在排队等待向链路传输的分组的数目
1. **传输时延**
1. **传播时延：** 一旦一个比特被推向链路，该比特需要向路由器B传播。从该链路的起点到路由器B传播所需要的时间是传播时延

### 协议分层：
各层的所有协议被称为协议栈。因特网的协议栈由5个层次组成：物理层、链路层、网络层、运输层和应用层  
1. 应用层：应用层是网络应用程序及它们的应用层协议存留的地方。应用层协议分布在多个端系统上，而一个系统中的应用程序使用协议与另一个端系统中的应用程序交换信息分组。把这种位于应用层的信息分组称为报文  
1. 运输层：因特网的运输层在应用程序端点之间传送应用层报文。运输层的分组称为报文段  
1. 网络层：因特网的网络层负责将称为数据报的网络层分组从一台主机移动到另一台主机  
1. 链路层：因特网的网络层通过源和目的地之间的一系列路由器路由数据报。为了将分组从一个节点（主机或路由器）移动到路径上的下一个节点，网络层必须依靠该链路层的服务。特别是在每个节点，网络层将数据报下传给链路层，链路层沿着路径将数据报传递给下一个节点。在该下一个节点，链路层将数据报上传给网络层。链路层分组称为帧  
1. 物理层：物理层的任务是将帧中的一个个比特从一个节点移动到下一个节点