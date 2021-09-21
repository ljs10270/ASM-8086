# ASM-8086
* 8086-Assembly를 활용해 DOSBox 환경에서 레지스터를 조작한 C+ASM 크리스마스 트리
![image](https://user-images.githubusercontent.com/59761622/134140047-615a1589-1610-4b2a-abaf-a7e6e2beba81.png)

C에서 int n의 변수로 depth를 입력 받아 어셈블리 프로시저에 인수 n으로 호출한다. Turbo C++ 컴파일러에 의해 int는 16bit로 스택 세그먼트 영역에 Push 되며 다시 C로 돌아갈 리턴 주소가 Push 된다. 어셈블리어 프로시저에서 DX 레지스터와 BP 레지스터에 값을 조작해야 하므로 C에서 사용하던 DX와 BP의 기존 값들은 다시 C로 리턴할 때 C가 하던 작업을 정상적으로 다시 시작할 수 있도록 Push 해준다. 이 후 BP를 SP와 동일하게 맞춰주고 BP+4로 스택 세그먼트의 인수 n에 접근한다. 
중앙의 위치를 DI 레지스터에 40으로 잡았다. 
중앙을 기준으로 왼쪽 .은 아래로 갈수록 –1씩 줄어들며 오른쪽 – 도 마찬가지 이다.
DI 레지스터를 n만큼 –1씩 줄임으로써 구현할 수 있다.

 *은 아래로 갈수록 2씩 증가하므로 등차수열을 이용하였다.
* 등차수열 = s = 첫항 + (n-1) * d(공차)

d는 2이므로 *2를 해줄 때 왼쪽으로 Shift 1을 해줌으로써 구할 수 있다.

. 과 – 출력에 있어 CX 레지스터는 라인을 의미하며 SI 레지스터를 DI 레지스터만큼 증가시켜 출력하였다.
*출력에 있어 CX 레지스터를 통해 해당 라인의 등차수열을 구한 후 SI 레지스터에 대입. 이후 SI 레지스터를 –1씩 감소시켜 출력하였다.

해당 라인의 출력이 끝나면 아스키 0Dh를 통해 줄바꿈을 하였다.
크리스마스트리의 상단 st1과 st2는 스택 세그먼트에서 BP+4인 n을 가져와 DX 레지스터에 대입하고 CX 레지스터와 비교하여 depth만큼 반복하였다.
문제의 조건에 맞게 2st를 출력하기 위해 1st가 끝난 시점의 CX 레지스터를 오른쪽으로 Shift 1하여 /2를 하였고 BX 레지스터와 SI 레지스터에 대입. 

이 후 SI 레지스터에 등차수열을 구한 후 *의길이에 맞게 .과 – 출력을 위해 SI 레지스터를 다시 /2 하여 중앙 40을 기준으로 빼주었다. 이후 2st는 스택 세그먼트에서 BP+4로 접근하여 인수 n을 DX에 가져와 BX를 더해주었고 CX 레지스터와 비교하여 depth만큼 반복하였다.

마지막 줄기(st3)는 문제의 조건에 맞게 출력하기 위해 스택 세그먼트에서 BP+4로 인수 n을 가져와 오른쪽으로 Shift 1하여 /2를 해주고 CX 레지스터에 대입 후 CX 레지스터를 –1 씩 감소시켜 n/2만큼 반복하였다.

마지막으로 Push 해두었던 C에서 사용하던 DX레지스터와 BX레지스터를 pop 하여 원래 값으로 되돌리고 ret(retrun)하여 C 복귀주소를 pop하여 C로 되돌린다.
