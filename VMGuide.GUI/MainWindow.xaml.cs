using System;
using System.Windows;
using System.Windows.Navigation;

namespace VMGuide
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            MainFrame.Navigated += MainFrame_Navigated;
        }

        private void MainFrame_Navigated(object sender, NavigationEventArgs e)
        {
            if (MainFrame.Content is FrameworkElement element)
            {
                element.DataContext = element.DataContext ?? element;
            }
        }
    }
}
