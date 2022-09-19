namespace MitMed_Demonstrator
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.HostIpTextBox = new System.Windows.Forms.TextBox();
            this.RefreshHostIp = new System.Windows.Forms.Button();
            this.LogTextBox = new System.Windows.Forms.TextBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.label4 = new System.Windows.Forms.Label();
            this.numberOfClients = new System.Windows.Forms.NumericUpDown();
            this.label3 = new System.Windows.Forms.Label();
            this.SendEmotionButton = new System.Windows.Forms.Button();
            this.EmotionSelect = new System.Windows.Forms.ComboBox();
            this.ConnectButton = new System.Windows.Forms.Button();
            this.ClientIpTextbox = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.label5 = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numberOfClients)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // HostIpTextBox
            // 
            this.HostIpTextBox.Location = new System.Drawing.Point(6, 27);
            this.HostIpTextBox.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.HostIpTextBox.Multiline = true;
            this.HostIpTextBox.Name = "HostIpTextBox";
            this.HostIpTextBox.ReadOnly = true;
            this.HostIpTextBox.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.HostIpTextBox.Size = new System.Drawing.Size(217, 118);
            this.HostIpTextBox.TabIndex = 0;
            // 
            // RefreshHostIp
            // 
            this.RefreshHostIp.Location = new System.Drawing.Point(6, 153);
            this.RefreshHostIp.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.RefreshHostIp.Name = "RefreshHostIp";
            this.RefreshHostIp.Size = new System.Drawing.Size(217, 36);
            this.RefreshHostIp.TabIndex = 2;
            this.RefreshHostIp.Text = "Refresh";
            this.RefreshHostIp.UseVisualStyleBackColor = true;
            this.RefreshHostIp.Click += new System.EventHandler(this.RefreshHostIp_Click);
            // 
            // LogTextBox
            // 
            this.LogTextBox.Location = new System.Drawing.Point(14, 234);
            this.LogTextBox.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.LogTextBox.Multiline = true;
            this.LogTextBox.Name = "LogTextBox";
            this.LogTextBox.ReadOnly = true;
            this.LogTextBox.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.LogTextBox.Size = new System.Drawing.Size(855, 362);
            this.LogTextBox.TabIndex = 3;
            this.LogTextBox.Tag = "";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.label5);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.numberOfClients);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.SendEmotionButton);
            this.groupBox1.Controls.Add(this.EmotionSelect);
            this.groupBox1.Controls.Add(this.ConnectButton);
            this.groupBox1.Controls.Add(this.ClientIpTextbox);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Location = new System.Drawing.Point(168, 16);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.groupBox1.Size = new System.Drawing.Size(456, 196);
            this.groupBox1.TabIndex = 4;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Demonstrator";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(16, 73);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(53, 20);
            this.label4.TabIndex = 7;
            this.label4.Text = "Clients";
            // 
            // numberOfClients
            // 
            this.numberOfClients.Location = new System.Drawing.Point(141, 71);
            this.numberOfClients.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.numberOfClients.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numberOfClients.Name = "numberOfClients";
            this.numberOfClients.Size = new System.Drawing.Size(138, 27);
            this.numberOfClients.TabIndex = 6;
            this.numberOfClients.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(16, 113);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(65, 20);
            this.label3.TabIndex = 5;
            this.label3.Text = "Emotion";
            // 
            // SendEmotionButton
            // 
            this.SendEmotionButton.Enabled = false;
            this.SendEmotionButton.Location = new System.Drawing.Point(296, 143);
            this.SendEmotionButton.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.SendEmotionButton.Name = "SendEmotionButton";
            this.SendEmotionButton.Size = new System.Drawing.Size(86, 31);
            this.SendEmotionButton.TabIndex = 4;
            this.SendEmotionButton.Text = "Send";
            this.SendEmotionButton.UseVisualStyleBackColor = true;
            this.SendEmotionButton.Click += new System.EventHandler(this.SendEmotionButton_Click);
            // 
            // EmotionSelect
            // 
            this.EmotionSelect.Enabled = false;
            this.EmotionSelect.FormattingEnabled = true;
            this.EmotionSelect.Location = new System.Drawing.Point(141, 143);
            this.EmotionSelect.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.EmotionSelect.Name = "EmotionSelect";
            this.EmotionSelect.Size = new System.Drawing.Size(138, 28);
            this.EmotionSelect.TabIndex = 3;
            // 
            // ConnectButton
            // 
            this.ConnectButton.Location = new System.Drawing.Point(296, 32);
            this.ConnectButton.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.ConnectButton.Name = "ConnectButton";
            this.ConnectButton.Size = new System.Drawing.Size(86, 31);
            this.ConnectButton.TabIndex = 2;
            this.ConnectButton.Text = "Connect";
            this.ConnectButton.UseVisualStyleBackColor = true;
            this.ConnectButton.Click += new System.EventHandler(this.ConnectButton_Click);
            // 
            // ClientIpTextbox
            // 
            this.ClientIpTextbox.Location = new System.Drawing.Point(141, 32);
            this.ClientIpTextbox.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.ClientIpTextbox.Name = "ClientIpTextbox";
            this.ClientIpTextbox.Size = new System.Drawing.Size(138, 27);
            this.ClientIpTextbox.TabIndex = 1;
            this.ClientIpTextbox.Text = "192.168.1.200";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(16, 36);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(104, 20);
            this.label2.TabIndex = 0;
            this.label2.Text = "Client IP (First)";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(12, 19);
            this.pictureBox1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(148, 95);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox1.TabIndex = 5;
            this.pictureBox1.TabStop = false;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(141, 113);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(307, 20);
            this.label5.TabIndex = 8;
            this.label5.Text = "[Valenz (N/P)][Intensity][Arousal (Frequency)]";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.HostIpTextBox);
            this.groupBox2.Controls.Add(this.RefreshHostIp);
            this.groupBox2.Location = new System.Drawing.Point(639, 16);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(230, 196);
            this.groupBox2.TabIndex = 6;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Host IP(s)";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(880, 609);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.LogTextBox);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "Form1";
            this.Text = "MitMed Demonstrator";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numberOfClients)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private TextBox HostIpTextBox;
        private Button RefreshHostIp;
        private TextBox LogTextBox;
        private GroupBox groupBox1;
        private Button ConnectButton;
        private TextBox ClientIpTextbox;
        private Label label2;
        private Label label3;
        private Button SendEmotionButton;
        private ComboBox EmotionSelect;
        private PictureBox pictureBox1;
        private Label label4;
        private NumericUpDown numberOfClients;
        private Label label5;
        private GroupBox groupBox2;
    }
}