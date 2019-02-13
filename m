Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0647D1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 16:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392666AbfBMQZk (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 11:25:40 -0500
Received: from mout.gmx.net ([212.227.15.19]:60289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729502AbfBMQZk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 11:25:40 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWTfu-1gahUz055m-00XcfZ; Wed, 13
 Feb 2019 17:25:27 +0100
Date:   Wed, 13 Feb 2019 17:25:10 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase: remove the rebase.useBuiltin setting
In-Reply-To: <20190213142209.8226-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902131724570.41@tvgsbejvaqbjf.bet>
References: <87ftsrke6r.fsf@evledraar.gmail.com> <20190213142209.8226-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-329677449-1550075127=:41"
X-Provags-ID: V03:K1:Ry946B5FQ5bQ3GbjhANzVA4Yhm5j5uG8VM3JrdoapvpnGUHE+4X
 s1QIeQ3Yl+KFz+psojVE47Ajt+3vlEiq1VbzEGelwNzm6cGN0sriJobcZnvxTbDz/Upj51V
 9GgMVDc7mUiEoFyGz4P534Wd6lDjCNNJM0WCUB00+N+4RBo395cz5Qq2pNYUGbWVJ4ggRj6
 THnSRRkghH9V7sN/oZ6BQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k1y8nCF5k3Y=:uKqvOgTzLTqPtt8KaBMLDm
 SRUwjfdV8YNMChRvxVAqRch1x7rplvN3g/YsYfsDHKPbaM01JNtqBVg2fuND3fKqJ8TCKaYhu
 QwiPWR3m3vpvxZCM3IMui1/WSQ+E0KMYJlBh8p5XNUBFLAsykIsD6mQjigSbFvWmhPC5eZSr2
 Ven02f7Wu3vBh4ZrzYdPdjz2HWb5lhLTKF61e2lDdUV1KHMTMUD0sumDq1NWpk1hvH7oVTVjq
 fQqZxVqh6ugjTpKd/PyHPGKS8WuZo47E8G73pjLctYhIC5CHjeTE0/5Mll9zQrhQVdi4JWB+o
 o+WWI2Aeo+RkEv+Nu3pcxUQ8r7J3FNfJLv6CrYK44DDgw77dklWXVTxlsVPVuuS3YggEclpdc
 JEdddafAzmSPMqVhQL5MjcNaDznsAhKW/nBwfoaB+ODMhHqZA/0DUS4PG+yID/6HIf1LvzgvQ
 R/br/0DTWYz8zvNlwU4IQ82Nf+DHowPQdWRQgODZcluEqfTaHW7glFY9hpZUjXkzJHKNdVt0F
 8Zcjdn9GwWIw9flBVQD5hyYJlyPRBiRangzKzVM4Mxk2zkhPjlfVu9xBszrYAwIbIYDoYLD9q
 8fRKInKTwV0Z8cHt/FK1gZtN6HDU+L6BVMKshashSVBj8kCp6piwq3EMDVGpzvH+FxCWDl2Ql
 SrmzqtAOnpCHRF4+NECjAQLJSElmToOW/9OynjzTNM8pxAlEGdzXIDXoVGYeQZeOqAt2Y1gLV
 SAvwOU6Q30xLL0noY/c85YG9rrzsc3OEQ7eD1b3ujdwLLZaPxJC8T+Lt9VSAVYGAuTn3BAfMh
 k+FBwoTQxCvoBrrOK+XcdiSdhNUtoWXjd2HVXzhIm+NXdnuL3Vi10sWayLsxi3m2sT7BDQ8rW
 HEtq3SKj7AJRwP4brhSWhnBJX/O5KGROlv7RCGVqDpDHArbquXyUI2BDpxr9TnLsqErv/KkkA
 KQcQrVdU7rA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-329677449-1550075127=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Wed, 13 Feb 2019, Ævar Arnfjörð Bjarmason wrote:

> Remove the rebase.useBuiltin setting, which was added as an escape
> hatch to disable the builtin version of rebase first released with Git
> 2.20.

I like it!

Thanks,
Dscho

> 
> See [1] for the initial implementation of rebase.useBuiltin, and [2]
> and [3] for the documentation and corresponding
> GIT_TEST_REBASE_USE_BUILTIN option.
> 
> As noted in [4] the test suite hasn't passed with
> GIT_TEST_REBASE_USE_BUILTIN=false since c762aada1a ("rebase -x: sanity
> check command", 2019-01-29). We could fix this as we did for another
> such bug in 7e097e27d3 ("legacy-rebase: backport -C<n> and
> --whitespace=<option> checks", 2018-11-20), or just decide that the
> built-in version is stable enough, and remove the legacy version. This
> patch implements that removal of the legacy version.
> 
> 1. 55071ea248 ("rebase: start implementing it as a builtin",
>    2018-08-07)
> 2. d8d0a546f0 ("rebase doc: document rebase.useBuiltin", 2018-11-14)
> 3. 62c23938fa ("tests: add a special setup where rebase.useBuiltin is
>    off", 2018-11-14)
> 4. https://public-inbox.org/git/87ftsrke6r.fsf@evledraar.gmail.com/
> ---
> 
> On Wed, Feb 13 2019, Ævar Arnfjörð Bjarmason wrote:
> > On Tue, Jan 29 2019, Phillip Wood wrote:
> >> [...]
> >>  test_expect_success 'rebase -i with exec of inexistent command' '
> >>      git checkout master &&
> >>      test_when_finished "git rebase --abort" &&
> >
> > This patch breaks the test suite (with these two new tests) under
> > GIT_TEST_REBASE_USE_BUILTIN=false. So a 2.21.0-rc0 regression.
> >
> > It would have been better to raise this before the rc period, but I just
> > noticed this now, but we can now:
> >
> >  1. Skip the test under that mode
> >  2. Fix the shell code to do the same thing
> >  3. Just remove the shell code & GIT_TEST_REBASE_USE_BUILTIN=false mode
> >
> > Maybe we should just do #3. The reason for the escape hatch was in case
> > we had bugs, and now we've had a full release cycle, but maybe that's
> > too early...
> 
> Here is approach #3, intended for 2.21, but I'll defer to Junio on
> whether we should take that approach.
> 
>  Documentation/config/rebase.txt |  17 +-
>  Makefile                        |   1 -
>  builtin/rebase.c                |  17 +-
>  git-legacy-rebase.sh            | 770 --------------------------------
>  t/README                        |   4 -
>  t/t3400-rebase.sh               |   6 +
>  6 files changed, 13 insertions(+), 802 deletions(-)
>  delete mode 100755 git-legacy-rebase.sh
> 
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
> index 331d250e04..c747452983 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -1,16 +1,9 @@
>  rebase.useBuiltin::
> -	Set to `false` to use the legacy shellscript implementation of
> -	linkgit:git-rebase[1]. Is `true` by default, which means use
> -	the built-in rewrite of it in C.
> -+
> -The C rewrite is first included with Git version 2.20. This option
> -serves an an escape hatch to re-enable the legacy version in case any
> -bugs are found in the rewrite. This option and the shellscript version
> -of linkgit:git-rebase[1] will be removed in some future release.
> -+
> -If you find some reason to set this option to `false` other than
> -one-off testing you should report the behavior difference as a bug in
> -git.
> +	Unused configuration variable. Used between Git version 2.20
> +	and 2.21 as an escape hatch to enable the legacy shellscript
> +	implementation of rebase. Now the built-in rewrite of it in C
> +	is always used. Setting this will emit a warning, to alert any
> +	remaining users that setting this now does nothing.
>  
>  rebase.stat::
>  	Whether to show a diffstat of what changed upstream since the last
> diff --git a/Makefile b/Makefile
> index 0e13a5b469..58dceccd8a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -626,7 +626,6 @@ SCRIPT_SH += git-merge-one-file.sh
>  SCRIPT_SH += git-merge-resolve.sh
>  SCRIPT_SH += git-mergetool.sh
>  SCRIPT_SH += git-quiltimport.sh
> -SCRIPT_SH += git-legacy-rebase.sh
>  SCRIPT_SH += git-remote-testgit.sh
>  SCRIPT_SH += git-request-pull.sh
>  SCRIPT_SH += git-stash.sh
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 7c7bc13e91..37a036933d 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1135,21 +1135,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	};
>  	int i;
>  
> -	/*
> -	 * NEEDSWORK: Once the builtin rebase has been tested enough
> -	 * and git-legacy-rebase.sh is retired to contrib/, this preamble
> -	 * can be removed.
> -	 */
> -
> -	if (!use_builtin_rebase()) {
> -		const char *path = mkpath("%s/git-legacy-rebase",
> -					  git_exec_path());
> -
> -		if (sane_execvp(path, (char **)argv) < 0)
> -			die_errno(_("could not exec %s"), path);
> -		else
> -			BUG("sane_execvp() returned???");
> -	}
> +	if (!use_builtin_rebase())
> +		warning(_("The rebase.useBuiltin support has been removed!"));
>  
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage_with_options(builtin_rebase_usage,
> diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
> deleted file mode 100755
> index 5c2c4e5276..0000000000
> --- a/git-legacy-rebase.sh
> +++ /dev/null
> @@ -1,770 +0,0 @@
> -#!/bin/sh
> -#
> -# Copyright (c) 2005 Junio C Hamano.
> -#
> -
> -SUBDIRECTORY_OK=Yes
> -OPTIONS_KEEPDASHDASH=
> -OPTIONS_STUCKLONG=t
> -OPTIONS_SPEC="\
> -git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
> -git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
> -git rebase --continue | --abort | --skip | --edit-todo
> ---
> - Available options are
> -v,verbose!         display a diffstat of what changed upstream
> -q,quiet!           be quiet. implies --no-stat
> -autostash          automatically stash/stash pop before and after
> -fork-point         use 'merge-base --fork-point' to refine upstream
> -onto=!             rebase onto given branch instead of upstream
> -r,rebase-merges?   try to rebase merges instead of skipping them
> -p,preserve-merges! try to recreate merges instead of ignoring them
> -s,strategy=!       use the given merge strategy
> -X,strategy-option=! pass the argument through to the merge strategy
> -no-ff!             cherry-pick all commits, even if unchanged
> -f,force-rebase!    cherry-pick all commits, even if unchanged
> -m,merge!           use merging strategies to rebase
> -i,interactive!     let the user edit the list of commits to rebase
> -x,exec=!           add exec lines after each commit of the editable list
> -k,keep-empty	   preserve empty commits during rebase
> -allow-empty-message allow rebasing commits with empty messages
> -stat!              display a diffstat of what changed upstream
> -n,no-stat!         do not show diffstat of what changed upstream
> -verify             allow pre-rebase hook to run
> -rerere-autoupdate  allow rerere to update index with resolved conflicts
> -root!              rebase all reachable commits up to the root(s)
> -autosquash         move commits that begin with squash!/fixup! under -i
> -signoff            add a Signed-off-by: line to each commit
> -committer-date-is-author-date! passed to 'git am'
> -ignore-date!       passed to 'git am'
> -whitespace=!       passed to 'git apply'
> -ignore-whitespace! passed to 'git apply'
> -C=!                passed to 'git apply'
> -S,gpg-sign?        GPG-sign commits
> - Actions:
> -continue!          continue
> -abort!             abort and check out the original branch
> -skip!              skip current patch and continue
> -edit-todo!         edit the todo list during an interactive rebase
> -quit!              abort but keep HEAD where it is
> -show-current-patch! show the patch file being applied or merged
> -reschedule-failed-exec automatically reschedule failed exec commands
> -"
> -. git-sh-setup
> -set_reflog_action rebase
> -require_work_tree_exists
> -cd_to_toplevel
> -
> -LF='
> -'
> -ok_to_skip_pre_rebase=
> -
> -squash_onto=
> -unset onto
> -unset restrict_revision
> -cmd=
> -strategy=
> -strategy_opts=
> -do_merge=
> -merge_dir="$GIT_DIR"/rebase-merge
> -apply_dir="$GIT_DIR"/rebase-apply
> -verbose=
> -diffstat=
> -test "$(git config --bool rebase.stat)" = true && diffstat=t
> -autostash="$(git config --bool rebase.autostash || echo false)"
> -fork_point=auto
> -git_am_opt=
> -git_format_patch_opt=
> -rebase_root=
> -force_rebase=
> -allow_rerere_autoupdate=
> -# Non-empty if a rebase was in progress when 'git rebase' was invoked
> -in_progress=
> -# One of {am, merge, interactive}
> -type=
> -# One of {"$GIT_DIR"/rebase-apply, "$GIT_DIR"/rebase-merge}
> -state_dir=
> -# One of {'', continue, skip, abort}, as parsed from command line
> -action=
> -rebase_merges=
> -rebase_cousins=
> -preserve_merges=
> -autosquash=
> -keep_empty=
> -allow_empty_message=--allow-empty-message
> -signoff=
> -reschedule_failed_exec=
> -test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
> -case "$(git config --bool commit.gpgsign)" in
> -true)	gpg_sign_opt=-S ;;
> -*)	gpg_sign_opt= ;;
> -esac
> -test "$(git config --bool rebase.reschedulefailedexec)" = "true" &&
> -reschedule_failed_exec=--reschedule-failed-exec
> -. git-rebase--common
> -
> -read_basic_state () {
> -	test -f "$state_dir/head-name" &&
> -	test -f "$state_dir/onto" &&
> -	head_name=$(cat "$state_dir"/head-name) &&
> -	onto=$(cat "$state_dir"/onto) &&
> -	# We always write to orig-head, but interactive rebase used to write to
> -	# head. Fall back to reading from head to cover for the case that the
> -	# user upgraded git with an ongoing interactive rebase.
> -	if test -f "$state_dir"/orig-head
> -	then
> -		orig_head=$(cat "$state_dir"/orig-head)
> -	else
> -		orig_head=$(cat "$state_dir"/head)
> -	fi &&
> -	test -f "$state_dir"/quiet && GIT_QUIET=t
> -	test -f "$state_dir"/verbose && verbose=t
> -	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
> -	test -f "$state_dir"/strategy_opts &&
> -		strategy_opts="$(cat "$state_dir"/strategy_opts)"
> -	test -f "$state_dir"/allow_rerere_autoupdate &&
> -		allow_rerere_autoupdate="$(cat "$state_dir"/allow_rerere_autoupdate)"
> -	test -f "$state_dir"/gpg_sign_opt &&
> -		gpg_sign_opt="$(cat "$state_dir"/gpg_sign_opt)"
> -	test -f "$state_dir"/signoff && {
> -		signoff="$(cat "$state_dir"/signoff)"
> -		force_rebase=t
> -	}
> -	test -f "$state_dir"/reschedule-failed-exec &&
> -		reschedule_failed_exec=t
> -}
> -
> -finish_rebase () {
> -	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
> -	apply_autostash &&
> -	{ git gc --auto || true; } &&
> -	rm -rf "$state_dir"
> -}
> -
> -run_interactive () {
> -	GIT_CHERRY_PICK_HELP="$resolvemsg"
> -	export GIT_CHERRY_PICK_HELP
> -
> -	test -n "$keep_empty" && keep_empty="--keep-empty"
> -	test -n "$rebase_merges" && rebase_merges="--rebase-merges"
> -	test -n "$rebase_cousins" && rebase_cousins="--rebase-cousins"
> -	test -n "$autosquash" && autosquash="--autosquash"
> -	test -n "$verbose" && verbose="--verbose"
> -	test -n "$force_rebase" && force_rebase="--no-ff"
> -	test -n "$restrict_revision" && \
> -		restrict_revision="--restrict-revision=^$restrict_revision"
> -	test -n "$upstream" && upstream="--upstream=$upstream"
> -	test -n "$onto" && onto="--onto=$onto"
> -	test -n "$squash_onto" && squash_onto="--squash-onto=$squash_onto"
> -	test -n "$onto_name" && onto_name="--onto-name=$onto_name"
> -	test -n "$head_name" && head_name="--head-name=$head_name"
> -	test -n "$strategy" && strategy="--strategy=$strategy"
> -	test -n "$strategy_opts" && strategy_opts="--strategy-opts=$strategy_opts"
> -	test -n "$switch_to" && switch_to="--switch-to=$switch_to"
> -	test -n "$cmd" && cmd="--cmd=$cmd"
> -	test -n "$action" && action="--$action"
> -
> -	exec git rebase--interactive "$action" "$keep_empty" "$rebase_merges" "$rebase_cousins" \
> -		"$upstream" "$onto" "$squash_onto" "$restrict_revision" \
> -		"$allow_empty_message" "$autosquash" "$verbose" \
> -		"$force_rebase" "$onto_name" "$head_name" "$strategy" \
> -		"$strategy_opts" "$cmd" "$switch_to" \
> -		"$allow_rerere_autoupdate" "$gpg_sign_opt" "$signoff" \
> -		"$reschedule_failed_exec"
> -}
> -
> -run_specific_rebase () {
> -	if [ "$interactive_rebase" = implied ]; then
> -		GIT_SEQUENCE_EDITOR=:
> -		export GIT_SEQUENCE_EDITOR
> -		autosquash=
> -	fi
> -
> -	if test -n "$interactive_rebase" -a -z "$preserve_merges"
> -	then
> -		run_interactive
> -	else
> -		. git-rebase--$type
> -
> -		if test -z "$preserve_merges"
> -		then
> -			git_rebase__$type
> -		else
> -			git_rebase__preserve_merges
> -		fi
> -	fi
> -
> -	ret=$?
> -	if test $ret -eq 0
> -	then
> -		finish_rebase
> -	elif test $ret -eq 2 # special exit status for rebase -p
> -	then
> -		apply_autostash &&
> -		rm -rf "$state_dir" &&
> -		die "Nothing to do"
> -	fi
> -	exit $ret
> -}
> -
> -run_pre_rebase_hook () {
> -	if test -z "$ok_to_skip_pre_rebase" &&
> -	   test -x "$(git rev-parse --git-path hooks/pre-rebase)"
> -	then
> -		"$(git rev-parse --git-path hooks/pre-rebase)" ${1+"$@"} ||
> -		die "$(gettext "The pre-rebase hook refused to rebase.")"
> -	fi
> -}
> -
> -test -f "$apply_dir"/applying &&
> -	die "$(gettext "It looks like 'git am' is in progress. Cannot rebase.")"
> -
> -if test -d "$apply_dir"
> -then
> -	type=am
> -	state_dir="$apply_dir"
> -elif test -d "$merge_dir"
> -then
> -	type=interactive
> -	if test -d "$merge_dir"/rewritten
> -	then
> -		type=preserve-merges
> -		interactive_rebase=explicit
> -		preserve_merges=t
> -	elif test -f "$merge_dir"/interactive
> -	then
> -		interactive_rebase=explicit
> -	fi
> -	state_dir="$merge_dir"
> -fi
> -test -n "$type" && in_progress=t
> -
> -total_argc=$#
> -while test $# != 0
> -do
> -	case "$1" in
> -	--no-verify)
> -		ok_to_skip_pre_rebase=yes
> -		;;
> -	--verify)
> -		ok_to_skip_pre_rebase=
> -		;;
> -	--continue|--skip|--abort|--quit|--edit-todo|--show-current-patch)
> -		test $total_argc -eq 2 || usage
> -		action=${1##--}
> -		;;
> -	--onto=*)
> -		onto="${1#--onto=}"
> -		;;
> -	--exec=*)
> -		cmd="${cmd}exec ${1#--exec=}${LF}"
> -		test -z "$interactive_rebase" && interactive_rebase=implied
> -		;;
> -	--interactive)
> -		interactive_rebase=explicit
> -		;;
> -	--keep-empty)
> -		keep_empty=yes
> -		;;
> -	--allow-empty-message)
> -		allow_empty_message=--allow-empty-message
> -		;;
> -	--no-keep-empty)
> -		keep_empty=
> -		;;
> -	--rebase-merges)
> -		rebase_merges=t
> -		test -z "$interactive_rebase" && interactive_rebase=implied
> -		;;
> -	--rebase-merges=*)
> -		rebase_merges=t
> -		case "${1#*=}" in
> -		rebase-cousins) rebase_cousins=t;;
> -		no-rebase-cousins) rebase_cousins=;;
> -		*) die "Unknown mode: $1";;
> -		esac
> -		test -z "$interactive_rebase" && interactive_rebase=implied
> -		;;
> -	--preserve-merges)
> -		preserve_merges=t
> -		test -z "$interactive_rebase" && interactive_rebase=implied
> -		;;
> -	--autosquash)
> -		autosquash=t
> -		;;
> -	--no-autosquash)
> -		autosquash=
> -		;;
> -	--fork-point)
> -		fork_point=t
> -		;;
> -	--no-fork-point)
> -		fork_point=
> -		;;
> -	--merge)
> -		do_merge=t
> -		;;
> -	--strategy-option=*)
> -		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--${1#--strategy-option=}" | sed -e s/^.//)"
> -		do_merge=t
> -		test -z "$strategy" && strategy=recursive
> -		;;
> -	--strategy=*)
> -		strategy="${1#--strategy=}"
> -		do_merge=t
> -		;;
> -	--no-stat)
> -		diffstat=
> -		;;
> -	--stat)
> -		diffstat=t
> -		;;
> -	--autostash)
> -		autostash=true
> -		;;
> -	--no-autostash)
> -		autostash=false
> -		;;
> -	--verbose)
> -		verbose=t
> -		diffstat=t
> -		GIT_QUIET=
> -		;;
> -	--quiet)
> -		GIT_QUIET=t
> -		git_am_opt="$git_am_opt -q"
> -		verbose=
> -		diffstat=
> -		;;
> -	--whitespace=*)
> -		git_am_opt="$git_am_opt --whitespace=${1#--whitespace=}"
> -		case "${1#--whitespace=}" in
> -		fix|strip)
> -			force_rebase=t
> -			;;
> -		warn|nowarn|error|error-all)
> -			;; # okay, known whitespace option
> -		*)
> -			die "fatal: Invalid whitespace option: '${1#*=}'"
> -			;;
> -		esac
> -		;;
> -	--ignore-whitespace)
> -		git_am_opt="$git_am_opt $1"
> -		;;
> -	--signoff)
> -		signoff=--signoff
> -		;;
> -	--no-signoff)
> -		signoff=
> -		;;
> -	--committer-date-is-author-date|--ignore-date)
> -		git_am_opt="$git_am_opt $1"
> -		force_rebase=t
> -		;;
> -	-C*[!0-9]*)
> -		die "fatal: switch \`C' expects a numerical value"
> -		;;
> -	-C*)
> -		git_am_opt="$git_am_opt $1"
> -		;;
> -	--root)
> -		rebase_root=t
> -		;;
> -	--force-rebase|--no-ff)
> -		force_rebase=t
> -		;;
> -	--rerere-autoupdate|--no-rerere-autoupdate)
> -		allow_rerere_autoupdate="$1"
> -		;;
> -	--gpg-sign)
> -		gpg_sign_opt=-S
> -		;;
> -	--gpg-sign=*)
> -		gpg_sign_opt="-S${1#--gpg-sign=}"
> -		;;
> -	--reschedule-failed-exec)
> -		reschedule_failed_exec=--reschedule-failed-exec
> -		;;
> -	--no-reschedule-failed-exec)
> -		reschedule_failed_exec=
> -		;;
> -	--)
> -		shift
> -		break
> -		;;
> -	*)
> -		usage
> -		;;
> -	esac
> -	shift
> -done
> -test $# -gt 2 && usage
> -
> -if test -n "$action"
> -then
> -	test -z "$in_progress" && die "$(gettext "No rebase in progress?")"
> -	# Only interactive rebase uses detailed reflog messages
> -	if test -n "$interactive_rebase" && test "$GIT_REFLOG_ACTION" = rebase
> -	then
> -		GIT_REFLOG_ACTION="rebase -i ($action)"
> -		export GIT_REFLOG_ACTION
> -	fi
> -fi
> -
> -if test "$action" = "edit-todo" && test -z "$interactive_rebase"
> -then
> -	die "$(gettext "The --edit-todo action can only be used during interactive rebase.")"
> -fi
> -
> -case "$action" in
> -continue)
> -	# Sanity check
> -	git rev-parse --verify HEAD >/dev/null ||
> -		die "$(gettext "Cannot read HEAD")"
> -	git update-index --ignore-submodules --refresh &&
> -	git diff-files --quiet --ignore-submodules || {
> -		echo "$(gettext "You must edit all merge conflicts and then
> -mark them as resolved using git add")"
> -		exit 1
> -	}
> -	read_basic_state
> -	run_specific_rebase
> -	;;
> -skip)
> -	output git reset --hard HEAD || exit $?
> -	read_basic_state
> -	run_specific_rebase
> -	;;
> -abort)
> -	git rerere clear
> -	read_basic_state
> -	case "$head_name" in
> -	refs/*)
> -		git symbolic-ref -m "rebase: aborting" HEAD $head_name ||
> -		die "$(eval_gettext "Could not move back to \$head_name")"
> -		;;
> -	esac
> -	output git reset --hard $orig_head
> -	finish_rebase
> -	exit
> -	;;
> -quit)
> -	exec rm -rf "$state_dir"
> -	;;
> -edit-todo)
> -	run_specific_rebase
> -	;;
> -show-current-patch)
> -	run_specific_rebase
> -	die "BUG: run_specific_rebase is not supposed to return here"
> -	;;
> -esac
> -
> -# Make sure no rebase is in progress
> -if test -n "$in_progress"
> -then
> -	state_dir_base=${state_dir##*/}
> -	cmd_live_rebase="git rebase (--continue | --abort | --skip)"
> -	cmd_clear_stale_rebase="rm -fr \"$state_dir\""
> -	die "
> -$(eval_gettext 'It seems that there is already a $state_dir_base directory, and
> -I wonder if you are in the middle of another rebase.  If that is the
> -case, please try
> -	$cmd_live_rebase
> -If that is not the case, please
> -	$cmd_clear_stale_rebase
> -and run me again.  I am stopping in case you still have something
> -valuable there.')"
> -fi
> -
> -if test -n "$rebase_root" && test -z "$onto"
> -then
> -	test -z "$interactive_rebase" && interactive_rebase=implied
> -fi
> -
> -if test -n "$keep_empty"
> -then
> -	test -z "$interactive_rebase" && interactive_rebase=implied
> -fi
> -
> -actually_interactive=
> -if test -n "$interactive_rebase"
> -then
> -	if test -z "$preserve_merges"
> -	then
> -		type=interactive
> -	else
> -		type=preserve-merges
> -	fi
> -	actually_interactive=t
> -	state_dir="$merge_dir"
> -elif test -n "$do_merge"
> -then
> -	interactive_rebase=implied
> -	type=interactive
> -	state_dir="$merge_dir"
> -else
> -	type=am
> -	state_dir="$apply_dir"
> -fi
> -
> -if test -t 2 && test -z "$GIT_QUIET"
> -then
> -	git_format_patch_opt="$git_format_patch_opt --progress"
> -fi
> -
> -incompatible_opts=$(echo " $git_am_opt " | \
> -		    sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
> -if test -n "$incompatible_opts"
> -then
> -	if test -n "$actually_interactive" || test "$do_merge"
> -	then
> -		die "$(gettext "fatal: cannot combine am options with either interactive or merge options")"
> -	fi
> -fi
> -
> -if test -n "$signoff"
> -then
> -	test -n "$preserve_merges" &&
> -		die "$(gettext "fatal: cannot combine '--signoff' with '--preserve-merges'")"
> -	git_am_opt="$git_am_opt $signoff"
> -	force_rebase=t
> -fi
> -
> -if test -n "$preserve_merges"
> -then
> -	# Note: incompatibility with --signoff handled in signoff block above
> -	# Note: incompatibility with --interactive is just a strong warning;
> -	#       git-rebase.txt caveats with "unless you know what you are doing"
> -	test -n "$rebase_merges" &&
> -		die "$(gettext "fatal: cannot combine '--preserve-merges' with '--rebase-merges'")"
> -
> -	test -n "$reschedule_failed_exec" &&
> -		die "$(gettext "error: cannot combine '--preserve-merges' with '--reschedule-failed-exec'")"
> -fi
> -
> -if test -n "$rebase_merges"
> -then
> -	test -n "$strategy_opts" &&
> -		die "$(gettext "fatal: cannot combine '--rebase-merges' with '--strategy-option'")"
> -	test -n "$strategy" &&
> -		die "$(gettext "fatal: cannot combine '--rebase-merges' with '--strategy'")"
> -fi
> -
> -if test -z "$rebase_root"
> -then
> -	case "$#" in
> -	0)
> -		if ! upstream_name=$(git rev-parse --symbolic-full-name \
> -			--verify -q @{upstream} 2>/dev/null)
> -		then
> -			. git-parse-remote
> -			error_on_missing_default_upstream "rebase" "rebase" \
> -				"against" "git rebase $(gettext '<branch>')"
> -		fi
> -
> -		test "$fork_point" = auto && fork_point=t
> -		;;
> -	*)	upstream_name="$1"
> -		if test "$upstream_name" = "-"
> -		then
> -			upstream_name="@{-1}"
> -		fi
> -		shift
> -		;;
> -	esac
> -	upstream=$(peel_committish "${upstream_name}") ||
> -	die "$(eval_gettext "invalid upstream '\$upstream_name'")"
> -	upstream_arg="$upstream_name"
> -else
> -	if test -z "$onto"
> -	then
> -		empty_tree=$(git hash-object -t tree /dev/null)
> -		onto=$(git commit-tree $empty_tree </dev/null)
> -		squash_onto="$onto"
> -	fi
> -	unset upstream_name
> -	unset upstream
> -	test $# -gt 1 && usage
> -	upstream_arg=--root
> -fi
> -
> -# Make sure the branch to rebase onto is valid.
> -onto_name=${onto-"$upstream_name"}
> -case "$onto_name" in
> -*...*)
> -	if	left=${onto_name%...*} right=${onto_name#*...} &&
> -		onto=$(git merge-base --all ${left:-HEAD} ${right:-HEAD})
> -	then
> -		case "$onto" in
> -		?*"$LF"?*)
> -			die "$(eval_gettext "\$onto_name: there are more than one merge bases")"
> -			;;
> -		'')
> -			die "$(eval_gettext "\$onto_name: there is no merge base")"
> -			;;
> -		esac
> -	else
> -		die "$(eval_gettext "\$onto_name: there is no merge base")"
> -	fi
> -	;;
> -*)
> -	onto=$(peel_committish "$onto_name") ||
> -	die "$(eval_gettext "Does not point to a valid commit: \$onto_name")"
> -	;;
> -esac
> -
> -# If the branch to rebase is given, that is the branch we will rebase
> -# $branch_name -- branch/commit being rebased, or HEAD (already detached)
> -# $orig_head -- commit object name of tip of the branch before rebasing
> -# $head_name -- refs/heads/<that-branch> or "detached HEAD"
> -switch_to=
> -case "$#" in
> -1)
> -	# Is it "rebase other $branchname" or "rebase other $commit"?
> -	branch_name="$1"
> -	switch_to="$1"
> -
> -	# Is it a local branch?
> -	if git show-ref --verify --quiet -- "refs/heads/$branch_name" &&
> -	   orig_head=$(git rev-parse -q --verify "refs/heads/$branch_name")
> -	then
> -		head_name="refs/heads/$branch_name"
> -	# If not is it a valid ref (branch or commit)?
> -	elif orig_head=$(git rev-parse -q --verify "$branch_name")
> -	then
> -		head_name="detached HEAD"
> -
> -	else
> -		die "$(eval_gettext "fatal: no such branch/commit '\$branch_name'")"
> -	fi
> -	;;
> -0)
> -	# Do not need to switch branches, we are already on it.
> -	if branch_name=$(git symbolic-ref -q HEAD)
> -	then
> -		head_name=$branch_name
> -		branch_name=$(expr "z$branch_name" : 'zrefs/heads/\(.*\)')
> -	else
> -		head_name="detached HEAD"
> -		branch_name=HEAD
> -	fi
> -	orig_head=$(git rev-parse --verify HEAD) || exit
> -	;;
> -*)
> -	die "BUG: unexpected number of arguments left to parse"
> -	;;
> -esac
> -
> -if test "$fork_point" = t
> -then
> -	new_upstream=$(git merge-base --fork-point "$upstream_name" \
> -			"${switch_to:-HEAD}")
> -	if test -n "$new_upstream"
> -	then
> -		restrict_revision=$new_upstream
> -	fi
> -fi
> -
> -if test "$autostash" = true && ! (require_clean_work_tree) 2>/dev/null
> -then
> -	stash_sha1=$(git stash create "autostash") ||
> -	die "$(gettext 'Cannot autostash')"
> -
> -	mkdir -p "$state_dir" &&
> -	echo $stash_sha1 >"$state_dir/autostash" &&
> -	stash_abbrev=$(git rev-parse --short $stash_sha1) &&
> -	echo "$(eval_gettext 'Created autostash: $stash_abbrev')" &&
> -	git reset --hard
> -fi
> -
> -require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
> -
> -# Now we are rebasing commits $upstream..$orig_head (or with --root,
> -# everything leading up to $orig_head) on top of $onto
> -
> -# Check if we are already based on $onto with linear history,
> -# but this should be done only when upstream and onto are the same
> -# and if this is not an interactive rebase.
> -mb=$(git merge-base "$onto" "$orig_head")
> -if test -z "$actually_interactive" && test "$upstream" = "$onto" &&
> -	test "$mb" = "$onto" && test -z "$restrict_revision" &&
> -	# linear history?
> -	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
> -then
> -	if test -z "$force_rebase"
> -	then
> -		# Lazily switch to the target branch if needed...
> -		test -z "$switch_to" ||
> -		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to" \
> -			git checkout -q "$switch_to" --
> -		if test "$branch_name" = "HEAD" &&
> -			 ! git symbolic-ref -q HEAD
> -		then
> -			say "$(eval_gettext "HEAD is up to date.")"
> -		else
> -			say "$(eval_gettext "Current branch \$branch_name is up to date.")"
> -		fi
> -		finish_rebase
> -		exit 0
> -	else
> -		if test "$branch_name" = "HEAD" &&
> -			 ! git symbolic-ref -q HEAD
> -		then
> -			say "$(eval_gettext "HEAD is up to date, rebase forced.")"
> -		else
> -			say "$(eval_gettext "Current branch \$branch_name is up to date, rebase forced.")"
> -		fi
> -	fi
> -fi
> -
> -# If a hook exists, give it a chance to interrupt
> -run_pre_rebase_hook "$upstream_arg" "$@"
> -
> -if test -n "$diffstat"
> -then
> -	if test -n "$verbose"
> -	then
> -		if test -z "$mb"
> -		then
> -			echo "$(eval_gettext "Changes to \$onto:")"
> -		else
> -			echo "$(eval_gettext "Changes from \$mb to \$onto:")"
> -		fi
> -	fi
> -	mb_tree="${mb:-$(git hash-object -t tree /dev/null)}"
> -	# We want color (if set), but no pager
> -	GIT_PAGER='' git diff --stat --summary "$mb_tree" "$onto"
> -fi
> -
> -if test -z "$actually_interactive" && test "$mb" = "$orig_head"
> -then
> -	say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
> -	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name" \
> -		git checkout -q "$onto^0" || die "could not detach HEAD"
> -	# If the $onto is a proper descendant of the tip of the branch, then
> -	# we just fast-forwarded.
> -	git update-ref ORIG_HEAD $orig_head
> -	move_to_original_branch
> -	finish_rebase
> -	exit 0
> -fi
> -
> -test -n "$interactive_rebase" && run_specific_rebase
> -
> -# Detach HEAD and reset the tree
> -say "$(gettext "First, rewinding head to replay your work on top of it...")"
> -
> -GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name" \
> -	git checkout -q "$onto^0" || die "could not detach HEAD"
> -git update-ref ORIG_HEAD $orig_head
> -
> -if test -n "$rebase_root"
> -then
> -	revisions="$onto..$orig_head"
> -else
> -	revisions="${restrict_revision-$upstream}..$orig_head"
> -fi
> -
> -run_specific_rebase
> diff --git a/t/README b/t/README
> index 1326fd7505..decceb8576 100644
> --- a/t/README
> +++ b/t/README
> @@ -374,10 +374,6 @@ the --no-sparse command-line argument.
>  GIT_TEST_PRELOAD_INDEX=<boolean> exercises the preload-index code path
>  by overriding the minimum number of cache entries required per thread.
>  
> -GIT_TEST_REBASE_USE_BUILTIN=<boolean>, when false, disables the
> -builtin version of git-rebase. See 'rebase.useBuiltin' in
> -git-config(1).
> -
>  GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
>  of the index for the whole test suite by bypassing the default number of
>  cache entries and thread minimums. Setting this to 1 will make the
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 3e73f7584c..0a88eed1db 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -311,4 +311,10 @@ test_expect_success 'rebase--merge.sh and --show-current-patch' '
>  	)
>  '
>  
> +test_expect_success 'rebase -c rebase.useBuiltin=false warning' '
> +	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN= \
> +		git -c rebase.useBuiltin=false rebase 2>err &&
> +	test_i18ngrep "rebase.useBuiltin support has been removed" err
> +'
> +
>  test_done
> -- 
> 2.20.1.611.gfbb209baf1
> 
> 
--8323328-329677449-1550075127=:41--
