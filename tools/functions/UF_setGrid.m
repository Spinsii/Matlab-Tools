function UF_setGrid(handle, arg)

    UF_iterate(handle.Axes, 'XGrid', arg.XGrid);
    UF_iterate(handle.Axes, 'YGrid', arg.YGrid);
    UF_iterate(handle.Axes, 'ZGrid', arg.ZGrid);
    UF_iterate(handle.Axes, 'Box', arg.AxesBox)
   
end