//
//  ThemeProvider.swift
//  walleeDemo
//
//  Created by Ira Paliy on 12.05.23.
//

import Foundation

class ThemeProvider {
    
    func getNewLightTheme() -> NSMutableDictionary{
        let lightTheme = NSMutableDictionary()
        lightTheme.setValue("#FFFFFF", forKey: "colorPrimary")
        lightTheme.setValue("#FFF5FF", forKey: "colorBackground")
        lightTheme.setValue("#FFE8F7", forKey: "colorText")
        lightTheme.setValue("#FFDFCA", forKey: "colorSecondaryText")
        lightTheme.setValue("#FFE694", forKey: "colorHeadingText")
        lightTheme.setValue("#F9F871", forKey: "colorError")
        
        let component = NSMutableDictionary()
        component.setValue("#FFFFFF", forKey: "colorBackground")
        component.setValue("#DADDE2", forKey: "colorBorder")
        component.setValue("#B1BDC5", forKey: "colorText")
        component.setValue("#889FA5", forKey: "colorPlaceholderText")
        component.setValue("#628281", forKey: "colorFocus")
        component.setValue("#43655A", forKey: "colorSelectedText")
        component.setValue("#fc0303", forKey: "colorSelectedBackground")
        component.setValue("#fc0303", forKey: "colorSelectedBorder")
        component.setValue("#fc0303", forKey: "colorDisabledBackground")
        
        lightTheme.setValue(component, forKey: "component")
        
        let buttonPrimary = NSMutableDictionary()
        buttonPrimary.setValue("#fc0303", forKey: "colorBackground")
        buttonPrimary.setValue("#fc0303", forKey: "colorText")
        buttonPrimary.setValue("#fc0303", forKey: "colorHover")
        
        lightTheme.setValue(buttonPrimary, forKey: "buttonPrimary")
        
        let buttonSecondary = NSMutableDictionary()
        buttonSecondary.setValue("#fc0303", forKey: "colorBackground")
        buttonSecondary.setValue("#fc0303", forKey: "colorText")
        buttonSecondary.setValue("#fc0303", forKey: "colorHover")
        
        lightTheme.setValue(buttonSecondary, forKey: "buttonSecondary")
        
        let buttonText = NSMutableDictionary()
        buttonText.setValue("#fc0303", forKey: "colorText")
        buttonText.setValue("#fc0303", forKey: "colorHover")
        
        lightTheme.setValue(buttonText, forKey: "buttonText")
        
        let buttonIcon = NSMutableDictionary()
        buttonIcon.setValue("#fc0303", forKey: "colorText")
        buttonIcon.setValue("#fc0303", forKey: "colorHover")
        
        lightTheme.setValue(buttonIcon, forKey: "buttonIcon")

        return lightTheme
    }
    
    func getNewDarkTheme() -> NSMutableDictionary{

        let darkTheme = NSMutableDictionary()
        darkTheme.setValue("#833232", forKey: "colorPrimary")
        darkTheme.setValue("#7B334C", forKey: "colorBackground")
        darkTheme.setValue("#00BFFF", forKey: "colorText")
        darkTheme.setValue("#4E4266", forKey: "colorSecondaryText")
        darkTheme.setValue("#384763", forKey: "colorHeadingText")
        darkTheme.setValue("#2F4858", forKey: "colorError")
        
        let component = NSMutableDictionary()
        component.setValue("#833232", forKey: "colorBackground")
        component.setValue("#9A3D5F", forKey: "colorBorder")
        component.setValue("#00BFFF", forKey: "colorText")
        component.setValue("#8873C6", forKey: "colorPlaceholderText")
        component.setValue("#4894EC", forKey: "colorFocus")
        component.setValue("#00B3FE", forKey: "colorSelectedText")
        component.setValue("#0bfc03", forKey: "colorSelectedBackground")
        component.setValue("#0bfc03", forKey: "colorSelectedBorder")
        component.setValue("#0bfc03", forKey: "colorDisabledBackground")
        
        darkTheme.setValue(component, forKey: "component")
        
        let buttonPrimary = NSMutableDictionary()
        buttonPrimary.setValue("#0bfc03", forKey: "colorBackground")
        buttonPrimary.setValue("#00BFFF", forKey: "colorText")
        buttonPrimary.setValue("#0bfc03", forKey: "colorHover")
        
        darkTheme.setValue(buttonPrimary, forKey: "buttonPrimary")
        
        let buttonSecondary = NSMutableDictionary()
        buttonSecondary.setValue("#0bfc03", forKey: "colorBackground")
        buttonSecondary.setValue("#00BFFF", forKey: "colorText")
        buttonSecondary.setValue("#0bfc03", forKey: "colorHover")
        
        darkTheme.setValue(buttonSecondary, forKey: "buttonSecondary")
        
        let buttonText = NSMutableDictionary()
        buttonText.setValue("#00BFFF", forKey: "colorText")
        buttonText.setValue("#0bfc03", forKey: "colorHover")
        
        darkTheme.setValue(buttonText, forKey: "buttonText")
        
        let buttonIcon = NSMutableDictionary()
        buttonIcon.setValue("#00BFFF", forKey: "colorText")
        buttonIcon.setValue("#0bfc03", forKey: "colorHover")
        
        darkTheme.setValue(buttonIcon, forKey: "buttonIcon")

        return darkTheme
        
        
    }
    
    func getNewCustomTheme() -> NSMutableDictionary{

        let customTheme = NSMutableDictionary()
        customTheme.setValue("#845EC2", forKey: "colorPrimary")
        customTheme.setValue("#D65DB1", forKey: "colorBackground")
        customTheme.setValue("#FBEAFF", forKey: "colorText")
        customTheme.setValue("#FF9671", forKey: "colorSecondaryText")
        customTheme.setValue("#FFC75F", forKey: "colorHeadingText")
        customTheme.setValue("#F9F871", forKey: "colorError")
        
        let component = NSMutableDictionary()
        component.setValue("#845EC2", forKey: "colorBackground")
        component.setValue("#2C73D2", forKey: "colorBorder")
        component.setValue("#FBEAFF", forKey: "colorText")
        component.setValue("#0089BA", forKey: "colorPlaceholderText")
        component.setValue("#008E9B", forKey: "colorFocus")
        component.setValue("#008F7A", forKey: "colorSelectedText")
        component.setValue("#032cfc", forKey: "colorSelectedBackground")
        component.setValue("#032cfc", forKey: "colorSelectedBorder")
        component.setValue("#032cfc", forKey: "colorDisabledBackground")
        
        customTheme.setValue(component, forKey: "component")
        
        let buttonPrimary = NSMutableDictionary()
        buttonPrimary.setValue("#0089BA", forKey: "colorBackground")
        buttonPrimary.setValue("#FBEAFF", forKey: "colorText")
        buttonPrimary.setValue("#032cfc", forKey: "colorHover")
        
        customTheme.setValue(buttonPrimary, forKey: "buttonPrimary")
        
        let buttonSecondary = NSMutableDictionary()
        buttonSecondary.setValue("#0089BA", forKey: "colorBackground")
        buttonSecondary.setValue("#FBEAFF", forKey: "colorText")
        buttonSecondary.setValue("#032cfc", forKey: "colorHover")
        
        customTheme.setValue(buttonSecondary, forKey: "buttonSecondary")
        
        let buttonText = NSMutableDictionary()
        buttonText.setValue("#0089BA", forKey: "colorText")
        buttonText.setValue("#FBEAFF", forKey: "colorHover")
        
        customTheme.setValue(buttonText, forKey: "buttonText")
        
        let buttonIcon = NSMutableDictionary()
        buttonIcon.setValue("#0089BA", forKey: "colorText")
        buttonIcon.setValue("#FBEAFF", forKey: "colorHover")
        
        customTheme.setValue(buttonIcon, forKey: "buttonIcon")

        return customTheme
    }
    
    func getIncompleteCustomTheme() -> NSMutableDictionary{
        let incompleteCustomTheme = NSMutableDictionary()
        incompleteCustomTheme.setValue("#0800FC", forKey: "colorBackground")
        incompleteCustomTheme.setValue("#EA00B6", forKey: "colorText")
        incompleteCustomTheme.setValue("#FF0071", forKey: "colorHeadingText")
        incompleteCustomTheme.setValue("#FF693E", forKey: "colorError")

        return incompleteCustomTheme
    }
    
    func getIncompleteDarkTheme() -> NSMutableDictionary{
        let incompleteDarkTheme = NSMutableDictionary()
        incompleteDarkTheme.setValue("#ABA2A2", forKey: "colorBackground")
        incompleteDarkTheme.setValue("#2F4858", forKey: "colorText")
        incompleteDarkTheme.setValue("#4F5769", forKey: "colorHeadingText")
        incompleteDarkTheme.setValue("#998D91", forKey: "colorError")

        return incompleteDarkTheme
    }
    
    func getIncompleteLightTheme() -> NSMutableDictionary{
        let incompleteLightTheme = NSMutableDictionary()
        incompleteLightTheme.setValue("#BCFF00", forKey: "colorBackground")
        incompleteLightTheme.setValue("#37E366", forKey: "colorText")
        incompleteLightTheme.setValue("#00BF8F", forKey: "colorHeadingText")
        incompleteLightTheme.setValue("#2F4858", forKey: "colorError")

        return incompleteLightTheme
    }
    
}
