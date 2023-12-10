$mdf = @"
[DllImport("kernel32.dll", EntryPoint = "BeginUpdateResourceW", SetLastError = true, CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
public extern static IntPtr BeginUpdateResourceW(string pFileName,bool bDeleteExistingResources);
[DllImport("kernel32.dll", EntryPoint = "UpdateResourceW", SetLastError = true, CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
public static extern bool UpdateResourceW(IntPtr hUpdate,string lpType,string lpName,UInt16 wLanguage,string lpData,UInt32 cbData);
[DllImport("kernel32.dll", EntryPoint = "EndUpdateResourceW", SetLastError = true, CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
public static extern bool EndUpdateResourceW(IntPtr hUpdate,bool fDiscard);
"@
$k32=Add-Type -MemberDefinition $mdf -Name 'Kernel32' -Namespace 'Win32' -PassThru;
$data="0"
#* yuh
$hUpdate=($k32::BeginUpdateResourceW("mloop.exe",0))
$result=($k32::UpdateResourceW($hUpdate,"data","persistent",1033,$data,([System.Text.Encoding]::UTF8.GetByteCount($data)*2)))
$final=($k32::EndUpdateResourceW($hUpdate,!($result)))
pause