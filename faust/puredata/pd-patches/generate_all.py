"""Generate all Faust projects for PureData.

Usage: ``python generate_all.py [--output-dir DIRECTORY] [--faust EXECUTABLE]
[--check]``. The catalog and its order come from common.faust.PROJECTS.
pd_helpers.main delegates to the same CLI used by individual generators.
Without --check, existing .pd, .svg, and .dsp exports are replaced. --check compares
temporary outputs and exits with a nonzero status on the first mismatch.
The Faust compiler and backend dependencies must be available.
"""

from pd_helpers import main

if __name__ == "__main__":
    main()
