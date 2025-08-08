#!/bin/csh

# test.sh: Run all test examples under visual/tests, output to output/ subdir

set testdirs = ( `find tests -mindepth 1 -maxdepth 1 -type d` )

foreach tdir ($testdirs)
    echo "Processing test directory: $tdir"
    
    # Create output directory if it doesn't exist
    if (! -d $tdir/output) mkdir -p $tdir/output
    
    # First, convert any MLIR files to JSON
    set mlirs = ( `find $tdir -maxdepth 1 -name '*.mlir'` )
    foreach m ($mlirs)
        echo "Converting MLIR to JSON: $m"
        python mlir_to_json.py $m
    end
    
    # Now process all JSON files
    set jsons = ( `find $tdir -maxdepth 1 -name '*.json'` )
    foreach j ($jsons)
        set base = $j:t:r
        echo "Processing JSON: $j"
        python test_appviz.py $j >& $tdir/output/${base}_test_output.log
        
        # Move all generated files to output directory
        # Files are created in the same directory as the JSON file
        set json_dir = $j:h
        if (-f ${json_dir}/${base}_test_output.svg) mv ${json_dir}/${base}_test_output.svg $tdir/output/
        if (-f ${json_dir}/${base}_test_output_report.txt) mv ${json_dir}/${base}_test_output_report.txt $tdir/output/
        
        # Also move the JSON file if it was generated from MLIR
        set json_name = $j:t
        if ($json_name != "vector_add_example.json") then
            if (-f $j) mv $j $tdir/output/
        endif
    end
    
    echo "Completed: $tdir"
    echo ""
end

echo "All tests completed. Check tests/*/output/ directories for results."
