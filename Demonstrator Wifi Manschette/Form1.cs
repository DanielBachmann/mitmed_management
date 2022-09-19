using System.Net.Sockets;
using System.Net;
using System.Xml.Serialization;
using System.Runtime.CompilerServices;
using UDP;
using System.Text;

namespace MitMed_Demonstrator
{
    public partial class Form1 : Form
    {
        Dictionary<string, string> emotionMap = new Dictionary<string, string>();
        bool connected = false;
        List<UDPSocket> udpSocketClients = new List<UDPSocket>();

        public Form1()
        {
            InitializeComponent();
            setHostIp();

            emotionMap.Add("N-3-HI", "FPN3HI"); // MEANING -> [Valenz (N/P)][Intensity][Arousal (Frequency)]
            emotionMap.Add("N-3-LO", "FPN3LO");
            emotionMap.Add("N-4-LO", "FPN4LO");
            emotionMap.Add("N-6-HI", "FPN6HI");
            emotionMap.Add("N-6-LO", "FPN6LO");
            emotionMap.Add("P-1-HI", "FPP1HI");
            emotionMap.Add("P-1-LO", "FPP1LO");
            emotionMap.Add("P-3H-I", "FPP3HI");
            emotionMap.Add("P-3L-O", "FPP3LO");
            emotionMap.Add("P-4-LO", "FPP4LO");
            emotionMap.Add("P-6-HI", "FPP6HI");
            emotionMap.Add("P-6-LO", "FPP6LO");
            // ToDo -> Add Emotions

            foreach (string emotion in emotionMap.Keys)
            {
                EmotionSelect.Items.Add(emotion);
            }

            EmotionSelect.SelectedIndex = 0;
        }

        private void setHostIp()
        {
            log("# Call Refresh Host IP's #");
            try
            {
                HostIpTextBox.Text = "";
                var host = Dns.GetHostEntry(Dns.GetHostName());
                foreach (var ip in host.AddressList)
                {
                    HostIpTextBox.AppendText($"{ip} ({ip.AddressFamily}){Environment.NewLine}");
                }
            }
            catch (Exception ex)
            {
                log(ex.Message, error:true);
            }
        }

        private void RefreshHostIp_Click(object sender, EventArgs e)
        {
           setHostIp();
        }

        private void log(string text, bool error=false)
        {
            string type = "INFO";
            if (error)
            {
                type = "ERROR";
            }

            LogTextBox.AppendText($"[{DateTime.Now}] [{type}] {text}{Environment.NewLine}");
        }

        private void ConnectButton_Click(object sender, EventArgs e)
        {
            String ip = ClientIpTextbox.Text;

            if (connected)
            {
                // Disconnect
                udpSocketClients.Clear();
                log($"-> Demonstrator(s) disconnected");
                connected = false;
                SendEmotionButton.Enabled = false;
                numberOfClients.Enabled = true;
                EmotionSelect.Enabled = false;
                ClientIpTextbox.Enabled = true;    
                ConnectButton.Text = "Connect";
            }
            else
            {
                // Connect
                // Check if IP was valid
                if (ValidateIPv4(ip))
                {
                    // Connect & Initialize
                    for (int i = 0; i < numberOfClients.Value; i++)
                    {
                        var ip_segments = ip.Split('.');
                        int last_segment = int.Parse(ip_segments[ip_segments.Length - 1]);
                        last_segment += i;
                        ip_segments[ip_segments.Length - 1] = last_segment.ToString();
                        UDPSocket c = new UDPSocket();
                        c.Client(string.Join(".", ip_segments), 2000);
                        udpSocketClients.Add(c);
                        log($"-> Try to connect to demonstrator {ip}");
                    }          

                    try
                    {
                        foreach(var c in udpSocketClients)
                        {
                            // 1. Send Timestamp
                            c.Send($"t");
                            c.Send($"{DateTimeOffset.Now.ToUnixTimeSeconds()}");
                            // 2. Turn Off Data Logging
                            c.Send($"S2");
                            log($"-> {c.client_ip} connected");
                        }

                        //if success: -> TODO CHECK IF REALLY SUCCESS
                        ConnectButton.Text = "Disconnect";
                        connected = true;

                        numberOfClients.Enabled = false;
                        SendEmotionButton.Enabled = true;
                        EmotionSelect.Enabled = true;
                        ClientIpTextbox.Enabled = false;
                    }
                    catch (Exception ex)
                    {
                        log(ex.Message, error: true);
                    }
                }
                else
                {
                    log($"Client-IP '{ip}' is not a valid IP-address. It should look like '192.168.1.100'", error:true);
                }
            }
        }

        private void SendEmotionButton_Click(object sender, EventArgs e)
        {
            string emotion = EmotionSelect.SelectedItem.ToString();
            string file = emotionMap.GetValueOrDefault(emotion);
            
            foreach(var c in udpSocketClients)
            {
                log($"-> Send emotion '{emotion}' (File '{file}') to {c.client_ip}");
                c.Send(file);
            }
        }

        private bool ValidateIPv4(string ipString)
        {
            if (String.IsNullOrWhiteSpace(ipString))
            {
                return false;
            }

            string[] splitValues = ipString.Split('.');
            if (splitValues.Length != 4)
            {
                return false;
            }

            byte tempForParsing;

            return splitValues.All(r => byte.TryParse(r, out tempForParsing));
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}