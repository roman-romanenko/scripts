# Authentication is required to create a color managed device

Edit the file `/usr/share/polkit-1/actions/org.freedesktop.color.policy`

Go to the defaults sections and modify `<allow_inactive>no</allow_inactive>` to `<allow_inactive>yes</allow_inactive>`
```
<defaults>
    <allow_any>auth_admin</allow_any>
    <allow_inactive>yes</allow_inactive>
    <allow_active>yes</allow_active>
</defaults>
```
