# flutter_multi_theme_getx_and_normal

## Scenario 1: Simple App (95% of use cases) ⭐ RECOMMENDED

static ThemeData get lightTheme {
  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF6750A4), // Your brand color
    brightness: Brightness.light,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    // Let Material 3 handle everything else ✅
  );
}

static ThemeData get darkTheme {
  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF6750A4),
    brightness: Brightness.dark,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
  );
}


## Scenario 2: Branded App (with specific colors)

static ThemeData get lightTheme {
  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF1976D2), // Brand blue
    brightness: Brightness.light,
    
    // Override only key brand colors
    primary: const Color(0xFF1976D2),        // Brand blue
    secondary: const Color(0xFFFF9800),      // Brand orange
    tertiary: const Color(0xFF4CAF50),       // Brand green
    
    // Keep rest auto-generated ✅
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
  );
}
Override: 3-5 colors
Auto-generate: Rest (~35 colors)

## Scenario 3: Enterprise Design System (full control)

static ThemeData get lightTheme {
  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF1976D2),
    brightness: Brightness.light,
    
    // Primary colors
    primary: const Color(0xFF1976D2),
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFFBBDEFB),
    onPrimaryContainer: const Color(0xFF0D47A1),
    
    // Secondary colors
    secondary: const Color(0xFFFF9800),
    onSecondary: Colors.white,
    secondaryContainer: const Color(0xFFFFE0B2),
    onSecondaryContainer: const Color(0xFFE65100),
    
    // Surface colors
    surface: Colors.white,
    surfaceContainer: const Color(0xFFF5F5F5),
    onSurface: const Color(0xFF212121),
    onSurfaceVariant: const Color(0xFF616161),
    
    // Outline
    outline: const Color(0xFFBDBDBD),
    
    // Error
    error: const Color(0xFFD32F2F),
    onError: Colors.white,
    
    // Keep rest auto-generated or override as needed
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
  );
}
```

**Override:** 15-20 colors  
**Auto-generate:** Rest (~25 colors)

---

## **📊 Color Hierarchy Chart**
```
┌─────────────────────────────────────────────────────────────┐
│                    OVERRIDE PRIORITY                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  🔴 MUST OVERRIDE (Brand Identity)                         │
│  ├─ seedColor          ← Start here!                       │
│  ├─ brightness         ← Light or dark                     │
│  └─ primary (optional) ← If you have exact brand color     │
│                                                             │
│  🟡 SOMETIMES OVERRIDE (Refinement)                        │
│  ├─ secondary          ← If you have accent color          │
│  ├─ tertiary           ← If you have 3rd color             │
│  ├─ surface            ← Custom background                 │
│  ├─ onPrimary          ← If contrast issues                │
│  ├─ onSurface          ← If text color issues              │
│  └─ outline            ← If border color issues            │
│                                                             │
│  ⚪ RARELY OVERRIDE (Pixel-Perfect Control)                │
│  ├─ primaryContainer   ← Design system requirement         │
│  ├─ surfaceVariants    ← Specific surface tones            │
│  ├─ Fixed colors       ← Advanced use cases                │
│  └─ inverse colors     ← Special scenarios                 │
│                                                             │
│  ✅ NEVER OVERRIDE (Let Material 3 Handle)                 │
│  ├─ shadow             ← Always black                      │
│  └─ Other computed     ← Auto-harmonized                   │
│                                                             │
└─────────────────────────────────────────────────────────────┘

# 📋 COMPLETE COLOR PROPERTY CHECKLIST

## Format:
Property Name
├─ Component Example 1
├─ Component Example 2
└─ Component Example 3

## 1. PRIMARY COLORS 🔵
primary

✅ FilledButton background (normal state)
✅ FloatingActionButton background
✅ Checkbox (checked state)
✅ Radio button (selected state)
✅ Switch (enabled state thumb)
✅ Slider (active track and thumb)
✅ ProgressIndicator (CircularProgressIndicator, LinearProgressIndicator)
✅ TabBar (selected tab indicator)
✅ TextButton text color
✅ OutlinedButton text color
✅ TextField (focused border color)
✅ TextField (cursor color)
✅ IconButton (when primary color applied)
✅ BottomNavigationBar (selected icon)
✅ NavigationRail (selected icon background)
✅ ListTile (selected background tint)

onPrimary

✅ FilledButton text color
✅ FloatingActionButton icon color
✅ Badge text (on primary background)
✅ Chip text (when background is primary)

primaryContainer

✅ FilterChip background (selected state)
✅ ChoiceChip background (selected state)
✅ InputChip background (selected state)
✅ NavigationBar (selected item background)
✅ NavigationDrawer (selected item background)
✅ NavigationRail (selected item background)
✅ FloatingActionButton (secondary variant background)
✅ SegmentedButton (selected segment background)
✅ DatePicker (selected date background)
✅ TimePicker (selected time background)

onPrimaryContainer

✅ FilterChip text (selected state)
✅ ChoiceChip text (selected state)
✅ NavigationBar (selected item text/icon)
✅ NavigationDrawer (selected item text/icon)
✅ SegmentedButton (selected segment text)

## 2. SECONDARY COLORS 🟢

secondary

✅ FilledButton.tonal background
✅ FloatingActionButton.extended background (secondary variant)
✅ Slider (inactive track)
✅ TabBar (unselected tab indicator alternative)
✅ Badge background (default)
✅ Custom accent buttons

onSecondary

✅ FilledButton.tonal text color
✅ Badge text color (on secondary background)

secondaryContainer

✅ FilterChip background (default/unselected)
✅ ChoiceChip background (default/unselected)
✅ InputChip background
✅ ActionChip background
✅ Snackbar action button background
✅ Tooltip background (alternative style)
✅ Info banner background
✅ SearchBar background (alternative style)

onSecondaryContainer

✅ FilterChip text (default/unselected)
✅ ChoiceChip text (default/unselected)
✅ InputChip text
✅ ActionChip text
✅ Info banner text

## 3. TERTIARY COLORS 🟡

tertiary

✅ Custom accent elements
✅ Alternative FloatingActionButton
✅ Badge background (alternative style)
✅ Special status indicators
✅ Calendar today circle

onTertiary

✅ Text on tertiary background
✅ Icons on tertiary background

tertiaryContainer

✅ Info cards background
✅ Promotional banner background
✅ Feature highlight background
✅ Alternative chip background
✅ Calendar selected date background

onTertiaryContainer

✅ Info cards text
✅ Promotional banner text
✅ Feature highlight text

## 4. ERROR COLORS 🔴

error

✅ TextField error border
✅ TextFormField error border
✅ Error icon color
✅ Delete/destructive button background
✅ Checkbox error state
✅ Radio button error state
✅ Form validation error icon

onError

✅ Text on error button
✅ Icon on error button
✅ Delete button text

errorContainer

✅ TextField error helper text background
✅ Error banner background
✅ Error alert background
✅ Error snackbar background
✅ Form error message background
✅ Validation error card background

onErrorContainer

✅ TextField error text
✅ Error banner text
✅ Error alert text
✅ Form error message text

## 5. SURFACE COLORS ⬜

surface

✅ Scaffold background
✅ AppBar background (default)
✅ BottomAppBar background
✅ BottomNavigationBar background
✅ NavigationBar background
✅ NavigationDrawer background
✅ NavigationRail background
✅ TabBar background
✅ Dialog background
✅ BottomSheet background
✅ ModalBottomSheet background
✅ Menu background (DropdownMenu, PopupMenu)
✅ DatePickerDialog background
✅ TimePickerDialog background
✅ AlertDialog background
✅ SimpleDialog background
✅ Drawer background
✅ ExpansionPanel background

onSurface

✅ Body text color (default)
✅ AppBar title text
✅ ListTile title text
✅ Card title text
✅ Dialog title text
✅ TextField text color
✅ DropdownButton text
✅ Icon color (default)
✅ Checkbox border (unchecked)
✅ Radio button border (unselected)
✅ Switch track (disabled)

onSurfaceVariant

✅ ListTile subtitle text
✅ Card subtitle text
✅ Dialog content text
✅ Caption text
✅ Helper text
✅ Hint text
✅ Label text (secondary)
✅ TextField label text (unfocused)
✅ Disabled text
✅ Placeholder text

surfaceDim

✅ Dimmed background overlay
✅ Modal barrier background (dialog backdrop)
✅ Drawer barrier background
✅ Alternative dark surface

surfaceBright

✅ Elevated surface (highest elevation)
✅ Popup surface
✅ Floating elements background

surfaceContainerLowest

✅ Card background (elevation level 1)
✅ Slightly elevated surface
✅ SearchBar background

surfaceContainerLow

✅ Card background (elevation level 2)
✅ Dialog background (alternative)
✅ Menu item hover background

surfaceContainer

✅ Card background (default)
✅ Container background (default)
✅ ListTile background (default)
✅ ExpansionTile background
✅ DataTable background
✅ Stepper background

surfaceContainerHigh

✅ Card background (elevation level 3)
✅ BottomSheet background
✅ Menu background
✅ Popup background

surfaceContainerHighest

✅ TextField fill color
✅ TextFormField fill color
✅ SearchBar fill color
✅ DropdownButton background
✅ Autocomplete background
✅ Input decoration fill color
✅ Disabled button background
✅ Chip background (default unselected)

surfaceTint

✅ Card elevation tint
✅ AppBar elevation tint
✅ Elevated surface tint overlay
✅ Shadow tint color

## 6. OUTLINE COLORS ⬛

outline

✅ TextField border (enabled state)
✅ TextFormField border (enabled state)
✅ OutlinedButton border
✅ Divider color
✅ VerticalDivider color
✅ Card border (when outlined)
✅ Checkbox border (unchecked)
✅ Radio button border (unselected)
✅ Switch track border
✅ Dropdown border
✅ DataTable border
✅ ListTile divider
✅ ExpansionPanel border
✅ SegmentedButton divider

outlineVariant

✅ Subtle divider
✅ TextField border (disabled state)
✅ Secondary borders
✅ Grid lines
✅ Table cell borders
✅ Card separator lines
✅ List separator lines

## 7. SHADOW 🌑

shadow

✅ Card shadow
✅ AppBar shadow
✅ ElevatedButton shadow
✅ FloatingActionButton shadow
✅ Dialog shadow
✅ BottomSheet shadow
✅ Menu shadow
✅ Popup shadow
✅ Tooltip shadow
✅ Any elevated widget shadow

## 8. INVERSE COLORS 🔄

inverseSurface

✅ Snackbar background
✅ Tooltip background
✅ Dark overlay (on light theme)
✅ Light overlay (on dark theme)

onInverseSurface

✅ Snackbar text
✅ Tooltip text
✅ Text on inverse surface

inversePrimary

✅ Snackbar action button color
✅ Link color on inverse surface
✅ Icon color on inverse surface

## 9. FIXED COLORS 📌

(These stay consistent across light/dark themes)
primaryFixed

✅ Brand logo background
✅ Fixed brand elements
✅ Consistent badge background

primaryFixedDim

✅ Dimmed brand elements
✅ Secondary brand background

onPrimaryFixed

✅ Text on primaryFixed
✅ Icons on primaryFixed

onPrimaryFixedVariant

✅ Alternative text on primaryFixed
✅ Secondary text on brand elements

secondaryFixed

✅ Fixed secondary brand elements
✅ Consistent accent background

secondaryFixedDim

✅ Dimmed secondary elements

onSecondaryFixed

✅ Text on secondaryFixed

onSecondaryFixedVariant

✅ Alternative text on secondaryFixed

tertiaryFixed

✅ Fixed tertiary elements
✅ Status indicators

tertiaryFixedDim

✅ Dimmed tertiary elements

onTertiaryFixed

✅ Text on tertiaryFixed

onTertiaryFixedVariant

✅ Alternative text on tertiaryFixed

# 📸 SCREENSHOT CHECKLIST - Organized by Component

BUTTONS (8 screenshots)

FilledButton normal → primary background, onPrimary text
FilledButton.tonal → secondaryContainer background, onSecondaryContainer text
ElevatedButton → surfaceContainer background, primary text, shadow
OutlinedButton → outline border, primary text
TextButton → primary text
IconButton → onSurface icon (default), primary (when colored)
FloatingActionButton → primaryContainer background, onPrimaryContainer icon
Button (disabled) → surfaceContainerHighest background, onSurface (faded)

TEXT FIELDS (6 screenshots)

TextField normal → surfaceContainerHighest fill, outline border, onSurface text
TextField focused → primary border, cursor
TextField with label → onSurfaceVariant label
TextField with error → error border, errorContainer helper background, onErrorContainer text
TextField disabled → outlineVariant border, onSurface (faded)
TextField with hint → onSurfaceVariant hint text

CARDS & CONTAINERS (5 screenshots)

Card → surfaceContainer background, onSurface text, shadow
Card elevated → surfaceContainerHigh background
ListTile in Card → onSurface title, onSurfaceVariant subtitle
Divider in Card → outline or outlineVariant
Container with border → outline border

CHIPS (4 screenshots)

ChoiceChip selected → primaryContainer background, onPrimaryContainer text
ChoiceChip unselected → secondaryContainer background, onSecondaryContainer text
FilterChip selected → primaryContainer background
InputChip → secondaryContainer background

NAVIGATION (6 screenshots)

AppBar → surface background, onSurface title, surfaceTint (elevation)
BottomNavigationBar → surface background, primary (selected), onSurface (unselected)
NavigationBar → surface background, primaryContainer (selected item background)
NavigationDrawer → surface background, primaryContainer (selected item)
TabBar → surface background, primary indicator
NavigationRail → surface background, primaryContainer (selected)

DIALOGS & SHEETS (4 screenshots)

AlertDialog → surface background, onSurface title, onSurfaceVariant content
BottomSheet → surface background, shadow
Menu/Popup → surfaceContainerHigh background, onSurface text
Modal barrier → surfaceDim backdrop

FORM CONTROLS (8 screenshots)

Checkbox unchecked → outline border
Checkbox checked → primary background, onPrimary check
Radio button unselected → outline border
Radio button selected → primary fill
Switch off → outline track, onSurface thumb
Switch on → primary track, onPrimary thumb
Slider → primary active track/thumb, secondary inactive track
ProgressIndicator → primary

MISCELLANEOUS (7 screenshots)

Snackbar → inverseSurface background, onInverseSurface text, inversePrimary action
Tooltip → inverseSurface background, onInverseSurface text
Badge → secondary or error background, onSecondary/onError text
Error banner → errorContainer background, onErrorContainer text
Icon (default) → onSurface
Scaffold background → surface
Text body → onSurface (primary), onSurfaceVariant (secondary)

# 🎯 QUICK CAPTURE GUIDE

// Example for TextField with error
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'Enter your email',
    errorText: 'Invalid email address',
    filled: true,
    // Colors used:
    // - fillColor: surfaceContainerHighest
    // - border: outline
    // - errorBorder: error
    // - errorText: onErrorContainer
  ),
)
```

### **Screenshot naming convention:**
```
01_filled_button_primary.png
02_filled_button_tonal_secondary.png
03_elevated_button.png
04_outlined_button_outline.png
05_text_button_primary.png
...
48_text_body_onSurface.png
```

---

## **📋 MASTER CHECKLIST**

Copy this and check off as you capture:
```
[ ] 01 - FilledButton (primary + onPrimary)
[ ] 02 - FilledButton.tonal (secondaryContainer + onSecondaryContainer)
[ ] 03 - ElevatedButton (surfaceContainer + primary + shadow)
[ ] 04 - OutlinedButton (outline + primary)
[ ] 05 - TextButton (primary)
[ ] 06 - IconButton (onSurface / primary)
[ ] 07 - FloatingActionButton (primaryContainer + onPrimaryContainer)
[ ] 08 - Disabled Button (surfaceContainerHighest)
[ ] 09 - TextField normal (surfaceContainerHighest + outline + onSurface)
[ ] 10 - TextField focused (primary border)
[ ] 11 - TextField label (onSurfaceVariant)
[ ] 12 - TextField error (error + errorContainer + onErrorContainer)
[ ] 13 - TextField disabled (outlineVariant)
[ ] 14 - TextField hint (onSurfaceVariant)
[ ] 15 - Card (surfaceContainer + shadow)
[ ] 16 - Card elevated (surfaceContainerHigh)
[ ] 17 - ListTile (onSurface + onSurfaceVariant)
[ ] 18 - Divider (outline / outlineVariant)
[ ] 19 - Container with border (outline)
[ ] 20 - ChoiceChip selected (primaryContainer + onPrimaryContainer)
[ ] 21 - ChoiceChip unselected (secondaryContainer + onSecondaryContainer)
[ ] 22 - FilterChip selected (primaryContainer)
[ ] 23 - InputChip (secondaryContainer)
[ ] 24 - AppBar (surface + onSurface + surfaceTint)
[ ] 25 - BottomNavigationBar (surface + primary + onSurface)
[ ] 26 - NavigationBar (surface + primaryContainer)
[ ] 27 - NavigationDrawer (surface + primaryContainer)
[ ] 28 - TabBar (surface + primary)
[ ] 29 - NavigationRail (surface + primaryContainer)
[ ] 30 - AlertDialog (surface + onSurface + onSurfaceVariant)
[ ] 31 - BottomSheet (surface + shadow)
[ ] 32 - Menu/Popup (surfaceContainerHigh)
[ ] 33 - Modal barrier (surfaceDim)
[ ] 34 - Checkbox unchecked (outline)
[ ] 35 - Checkbox checked (primary + onPrimary)
[ ] 36 - Radio unselected (outline)
[ ] 37 - Radio selected (primary)
[ ] 38 - Switch off (outline + onSurface)
[ ] 39 - Switch on (primary + onPrimary)
[ ] 40 - Slider (primary + secondary)
[ ] 41 - ProgressIndicator (primary)
[ ] 42 - Snackbar (inverseSurface + onInverseSurface + inversePrimary)
[ ] 43 - Tooltip (inverseSurface + onInverseSurface)
[ ] 44 - Badge (secondary / error)
[ ] 45 - Error banner (errorContainer + onErrorContainer)
[ ] 46 - Icon default (onSurface)
[ ] 47 - Scaffold (surface)
[ ] 48 - Text body (onSurface + onSurfaceVariant)
