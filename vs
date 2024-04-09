using System;

// 定义接口 IProductionFactory，包含生产鸭脖和鸭翅的方法。
public interface IProductionFactory
{
    void ProduceDuckNeck();
    void ProduceDuckWing();
}

// 定义类 WuhanFactory、NanjingFactory、ChangshaFactory 分别实现接口 IProductionFactory，用于具体的生产工厂。
public class WuhanFactory : IProductionFactory
{
    public void ProduceDuckNeck()
    {
        Console.WriteLine("武汉工厂生产鸭脖。");
    }

    public void ProduceDuckWing()
    {
        Console.WriteLine("武汉工厂生产鸭翅。");
    }
}

public class NanjingFactory : IProductionFactory
{
    public void ProduceDuckNeck()
    {
        throw new NotSupportedException("南京工厂无法生产鸭脖。");
    }

    public void ProduceDuckWing()
    {
        Console.WriteLine("南京工厂生产鸭翅。");
    }
}

public class ChangshaFactory : IProductionFactory
{
    public void ProduceDuckNeck()
    {
        Console.WriteLine("长沙工厂生产鸭脖。");
    }

    public void ProduceDuckWing()
    {
        throw new NotSupportedException("长沙工厂无法生产鸭翅。");
    }
}

class Program
{
    // 定义委托 ProductionDelegate
    public delegate void ProductionDelegate();
    public static void FactoryProduct(ProductionDelegate productionDelegate)
    {
        // 如果委托无误，正常调用
        try
        {
            productionDelegate();
        }
        // 如果捕获到异常，则输出错误信息
        catch (NotImplementedException e)
        {
            Console.WriteLine(e.Message);
        }
    }

    private static void Main(string[] args)
    {
        // 创建工厂实例
        IProductionFactory wuhanFactory, nanjingFactory, changshaFactory;
        wuhanFactory = new WuhanFactory();
        nanjingFactory = new NanjingFactory();
        changshaFactory = new ChangshaFactory();
        // 实现委托
        ProductionDelegate wuhanDelegate, nanjingDelegate, changshaDelegate;
        wuhanDelegate = wuhanFactory.ProduceDuckNeck;
        wuhanDelegate += wuhanFactory.ProduceDuckWing;
        nanjingDelegate = nanjingFactory.ProduceDuckWing;
        changshaDelegate = changshaFactory.ProduceDuckNeck;
         // 通过委托进行生产
        FactoryProduct(wuhanDelegate);
        FactoryProduct(nanjingDelegate);
        FactoryProduct(changshaDelegate);
    }
}
