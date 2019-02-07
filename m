Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 015081F453
	for <e@80x24.org>; Thu,  7 Feb 2019 19:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfBGTrp (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 14:47:45 -0500
Received: from mout.gmx.net ([212.227.17.22]:51691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfBGTrn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 14:47:43 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MI9n0-1gp4l01MRq-003ulS; Thu, 07
 Feb 2019 20:47:32 +0100
Date:   Thu, 7 Feb 2019 20:47:31 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        git-for-windows@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.21.0-rc0
In-Reply-To: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902072045590.41@tvgsbejvaqbjf.bet>
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-873276717-1549568853=:41"
X-Provags-ID: V03:K1:vVTBcsyVMehNlXOCzTZkzCTP2PTNxZXlESBtPaMXyKY1DKpZ0BR
 b5A38Nv9BowBTr/e/F7Zd8OJjt3M/qo895cpatCcMWi0klJnFqaqj1EDzslbPDLPPO3vdnx
 STA92nXOFsgJfvZGqPhHZ6V3EomYYS7TpBT/BKa3KlPr34kAQHphqF5bDHW6F4GK6EOBJjM
 3yWsu/7utSnmsd5gvHDLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2zqSSSgMNJ0=:ORVOJoKUkzCbRI+iFQuV3B
 yyYxfwSAVwnge/cOdvK7b+KYkBzaLG4+2FuleHDG0KUEfDjrn+I6ueuuaF0vD5FDqvt6Dnb0q
 oG5HiQEGL3+J+gRbcwKSrA84VAAu7LDwtuHkbz/pKUDdzhjBiGoUVV4ESMfo7jydVZctrRIux
 FQAwgtlbG72yUzLn05DiRtyegWsHaXu7byEogJUaMb6lFG2ZIObUcJXlp9W8XPrmZo8BFwfK+
 tmFt4kr3hiruRX9rJFrX3wfP7GotbmVJgEq90rRZdC9YlBkXJs5WegOKFE7edWYQIWK4rENIO
 mq5uMBJXVeCsIb1ib/Z5nJcOTsGlMVLWGgIr7jaeRduyQ4WkVWfdzriKun1c4bTkmk0ZYn5AK
 5qGWwHaVLcMxB5/scx7RfB4DjGNZ8pv/2m6gaVTw3GP5OKFrySx2TbyGTzG+j5lvkkT0oxS9u
 gXjs6k9A7qr8RpolBZcdd7m2cyZFGqLqsO4EYgHRnu5Ryn0dGTGjNod6C9xIUctHnu0dcnzVp
 RSrObzo/bmPXCyOHqzsXm4lQpMaF2qgDbnWj5hwndIvsCzCOeg/Sy+88aVmqkTaj6BbbBWB54
 TPIVifSv5b8t2QCVNXfcA5JhC+5Eo3KAvqq78o6oEXhq0nYFeJhbs+8Un6vpezQOzQUbggKiy
 QvhoES/S7Ih9h0o9ijixJh8Kut1le3mT90kfrXrlvakusQ79aEGwTJ2xEXCBsNYwn1B49vT+Q
 XYXpCIGZEcDFBuPojwtu3Va0qU0/B9GKgdzcbgJJPJTmUVVG1ZWVXqUorzDyKkQnkzxWmbfog
 Jp+2uvb0MLXvpgCuMC/0AZVpf/wbG46GSyhJWYnxQ09M8oqfqIK7gumJe+GT05FLI01wPBTTG
 0aXwCADWE5NNX6VKbQg9XQMUoGcNUC850F0NEMyvrhf1oZtshhq8zLoUb+/gW0vu2Lpmb0uyT
 tFBPEsjcmeg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-873276717-1549568853=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Team,

the Windows version of v2.21.0-rc0 can be found here:

https://github.com/git-for-windows/git/releases/tag/v2.21.0-rc0.windows.1

Thanks for testing!
Johannes

On Wed, 6 Feb 2019, Junio C Hamano wrote:

> An early preview release Git v2.21.0-rc0 is now available for
> testing at the usual places.  It is comprised of 426 non-merge
> commits since v2.20.0, contributed by 57 people, 13 of which are
> new faces.
> 
> The tarballs are found at:
> 
>     https://www.kernel.org/pub/software/scm/git/testing/
> 
> The following public repositories all have a copy of the
> 'v2.21.0-rc0' tag and the 'master' branch that the tag points at:
> 
>   url = https://kernel.googlesource.com/pub/scm/git/git
>   url = git://repo.or.cz/alt-git.git
>   url = https://github.com/gitster/git
> 
> New contributors whose contributions weren't in v2.20.0 are as follows.
> Welcome to the Git development community!
> 
>   Arti Zirk, Brandon Richardson, Chayoung You, Denis Ovsienko, Erin
>   Dahlgren, Force Charlie, Frank Dana, Issac Trotts, Laura Abbott,
>   Patrick Hogg, Peter Osterlund, Shahzad Lone, and Slavica Djukic.
> 
> Returning contributors who helped this release are as follows.
> Thanks for your continued support.
> 
>   Ævar Arnfjörð Bjarmason, Ben Peart, Brandon Williams, brian
>   m. carlson, Carlo Marcelo Arenas Belón, Christian Couder,
>   David Turner, Derrick Stolee, Elijah Newren, Eric Sunshine,
>   Eric Wong, Jean-Noël Avila, Jeff King, Johannes Schindelin,
>   Jonathan Nieder, Jonathan Tan, Josh Steadmon, Junio C Hamano, Kim
>   Gybels, Kyle Meyer, Linus Torvalds, Luke Diamand, Martin Ågren,
>   Masaya Suzuki, Matthew DeVore, Matthieu Moy, Max Kirillov,
>   Nguyễn Thái Ngọc Duy, Olga Telezhnaya, Orgad Shaneh,
>   Phillip Wood, Pranit Bauva, Ramsay Jones, Randall S. Becker,
>   René Scharfe, Sebastian Staudt, Sergey Organov, Stefan Beller,
>   Stephen P. Smith, Sven van Haastregt, SZEDER Gábor, Thomas
>   Braun, Thomas Gummerer, and Torsten Bögershausen.
> 
> ----------------------------------------------------------------
> 
> Git 2.21 Release Notes (draft)
> ==============================
> 
> Backward Compatibility Notes
> ----------------------------
> 
>  * Historically, the "-m" (mainline) option can only be used for "git
>    cherry-pick" and "git revert" when working with a merge commit.
>    This version of Git no longer warns or errors out when working with
>    a single-parent commit, as long as the argument to the "-m" option
>    is 1 (i.e. it has only one parent, and the request is to pick or
>    revert relative to that first parent).  Scripts that relied on the
>    behaviour may get broken with this change.
> 
> 
> Updates since v2.20
> -------------------
> 
> UI, Workflows & Features
> 
>  * The "http.version" configuration variable can be used with recent
>    enough versions of cURL library to force the version of HTTP used
>    to talk when fetching and pushing.
> 
>  * Small fixes and features for fast-export and fast-import, mostly on
>    the fast-export side has been made.
> 
>  * "git push $there $src:$dst" rejects when $dst is not a fully
>    qualified refname and not clear what the end user meant.  The
>    codepath has been taught to give a clearer error message, and also
>    guess where the push should go by taking the type of the pushed
>    object into account (e.g. a tag object would want to go under
>    refs/tags/).
> 
>  * "git checkout [<tree-ish>] path..." learned to report the number of
>    paths that have been checked out of the index or the tree-ish,
>    which gives it the same degree of noisy-ness as the case in which
>    the command checks out a branch.
> 
>  * "git quiltimport" learned "--keep-non-patch" option.
> 
>  * "git worktree remove" and "git worktree move" refused to work when
>    there is a submodule involved.  This has been loosened to ignore
>    uninitialized submodules.
> 
>  * "git cherry-pick -m1" was forbidden when picking a non-merge
>    commit, even though there _is_ parent number 1 for such a commit.
>    This was done to avoid mistakes back when "cherry-pick" was about
>    picking a single commit, but is no longer useful with "cherry-pick"
>    that can pick a range of commits.  Now the "-m$num" option is
>    allowed when picking any commit, as long as $num names an existing
>    parent of the commit.
> 
>  * Update "git multimail" from the upstream.
> 
>  * "git p4" update.
> 
>  * The "--format=<placeholder>" option of for-each-ref, branch and tag
>    learned to show a few more traits of objects that can be learned by
>    the object_info API.
> 
>  * "git rebase -i" learned to re-execute a command given with 'exec'
>    to run after it failed the last time.
> 
>  * "git diff --color-moved-ws" updates.
> 
>  * Custom userformat "log --format" learned %S atom that stands for
>    the tip the traversal reached the commit from, i.e. --source.
> 
>  * "git instaweb" learned to drive http.server that comes with
>    "batteries included" Python installation (both Python2 & 3).
> 
>  * A new encoding UTF-16LE-BOM has been invented to force encoding to
>    UTF-16 with BOM in little endian byte order, which cannot be directly
>    generated by using iconv.
> 
>  * A new date format "--date=human" that morphs its output depending
>    on how far the time is from the current time has been introduced.
>    "--date=auto" can be used to use this new format when the output is
>    going to the pager or to the terminal and otherwise the default
>    format.
> 
> 
> Performance, Internal Implementation, Development Support etc.
> 
>  * Code clean-up with optimization for the codepath that checks
>    (non-)existence of loose objects.
> 
>  * More codepaths have become aware of working with in-core repository
>    instance other than the default "the_repository".
> 
>  * The "strncat()" function is now among the banned functions.
> 
>  * Portability updates for the HPE NonStop platform.
> 
>  * Earlier we added "-Wformat-security" to developer builds, assuming
>    that "-Wall" (which includes "-Wformat" which in turn is required
>    to use "-Wformat-security") is always in effect.  This is not true
>    when config.mak.autogen is in use, unfortunately.  This has been
>    fixed by unconditionally adding "-Wall" to developer builds.
> 
>  * The loose object cache used to optimize existence look-up has been
>    updated.
> 
>  * Flaky tests can now be repeatedly run under load with the
>    "--stress" option.
> 
>  * Documentation/Makefile is getting prepared for manpage
>    localization.
> 
>  * "git fetch-pack" now can talk the version 2 protocol.
> 
>  * sha-256 hash has been added and plumbed through the code to allow
>    building Git with the "NewHash".
> 
>  * Debugging help for http transport.
> 
>  * "git fetch --deepen=<more>" has been corrected to work over v2
>    protocol.
> 
>  * The code to walk tree objects has been taught that we may be
>    working with object names that are not computed with SHA-1.
> 
>  * The in-core repository instances are passed through more codepaths.
> 
>  * Update the protocol message specification to allow only the limited
>    use of scaled quantities.  This is ensure potential compatibility
>    issues will not go out of hand.
> 
>  * Micro-optimize the code that prepares commit objects to be walked
>    by "git rev-list" when the commit-graph is available.
> 
>  * "git fetch" and "git upload-pack" learned to send all exchange over
>    the sideband channel while talking the v2 protocol.
> 
>  * The codepath to write out commit-graph has been optimized by
>    following the usual pattern of visiting objects in in-pack order.
> 
>  * The codepath to show progress meter while writing out commit-graph
>    file has been improved.
> 
>  * Cocci rules have been updated to encourage use of strbuf_addbuf().
> 
>  * "git rebase --merge" has been reimplemented by reusing the internal
>    machinery used for "git rebase -i".
> 
>  * More code in "git bisect" has been rewritten in C.
> 
>  * Instead of going through "git-rebase--am" scriptlet to use the "am"
>    backend, the built-in version of "git rebase" learned to drive the
>    "am" backend directly.
> 
>  * The assumption to work on the single "in-core index" instance has
>    been reduced from the library-ish part of the codebase.
> 
>  * The test lint learned to catch non-portable "sed" options.
> 
>  * "git pack-objects" learned another algorithm to compute the set of
>    objects to send, that trades the resulting packfile off to save
>    traversal cost to favor small pushes.
> 
>  * The travis CI scripts have been corrected to build Git with the
>    compiler(s) of our choice.
> 
>  * "git submodule update" learned to abort early when core.worktree
>    for the submodule is not set correctly to prevent spreading damage.
> 
>  * Test suite has been adjusted to run on Azure Pipeline.
> 
>  * Running "Documentation/doc-diff x" from anywhere other than the
>    top-level of the working tree did not show the usage string
>    correctly, which has been fixed.
> 
>  * Use of the sparse tool got easier to customize from the command
>    line to help developers.
> 
> 
> Fixes since v2.20
> -----------------
> 
>  * Updates for corner cases in merge-recursive.
>    (merge cc4cb0902c en/merge-path-collision later to maint).
> 
>  * "git checkout frotz" (without any double-dash) avoids ambiguity by
>    making sure 'frotz' cannot be interpreted as a revision and as a
>    path at the same time.  This safety has been updated to check also
>    a unique remote-tracking branch 'frotz' in a remote, when dwimming
>    to create a local branch 'frotz' out of a remote-tracking branch
>    'frotz' from a remote.
>    (merge be4908f103 nd/checkout-dwim-fix later to maint).
> 
>  * Refspecs configured with "git -c var=val clone" did not propagate
>    to the resulting repository, which has been corrected.
>    (merge 7eae4a3ac4 sg/clone-initial-fetch-configuration later to maint).
> 
>  * A properly configured username/email is required under
>    user.useConfigOnly in order to create commits; now "git stash"
>    (even though it creates commit objects to represent stash entries)
>    command is exempt from the requirement.
>    (merge 3bc2111fc2 sd/stash-wo-user-name later to maint).
> 
>  * The http-backend CGI process did not correctly clean up the child
>    processes it spawns to run upload-pack etc. when it dies itself,
>    which has been corrected.
>    (merge 02818a98d7 mk/http-backend-kill-children-before-exit later to maint).
> 
>  * "git rev-list --exclude-promisor-objects" had to take an object
>    that does not exist locally (and is lazily available) from the
>    command line without barfing, but the code dereferenced NULL.
>    (merge 4cf67869b2 md/list-lazy-objects-fix later to maint).
> 
>  * The traversal over tree objects has learned to honor
>    ":(attr:label)" pathspec match, which has been implemented only for
>    enumerating paths on the filesystem.
>    (merge 5a0b97b34c nd/attr-pathspec-in-tree-walk later to maint).
> 
>  * BSD port updates.
>    (merge 4e3ecbd439 cb/openbsd-allows-reading-directory later to maint).
>    (merge b6bdc2a0f5 cb/t5004-empty-tar-archive-fix later to maint).
>    (merge 82cbc8cde2 cb/test-lint-cp-a later to maint).
> 
>  * Lines that begin with a certain keyword that come over the wire, as
>    well as lines that consist only of one of these keywords, ought to
>    be painted in color for easier eyeballing, but the latter was
>    broken ever since the feature was introduced in 2.19, which has
>    been corrected.
>    (merge 1f67290450 hn/highlight-sideband-keywords later to maint).
> 
>  * "git log -G<regex>" looked for a hunk in the "git log -p" patch
>    output that contained a string that matches the given pattern.
>    Optimize this code to ignore binary files, which by default will
>    not show any hunk that would match any pattern (unless textconv or
>    the --text option is in effect, that is).
>    (merge e0e7cb8080 tb/log-G-binary later to maint).
> 
>  * "git submodule update" ought to use a single job unless asked, but
>    by mistake used multiple jobs, which has been fixed.
>    (merge e3a9d1aca9 sb/submodule-fetchjobs-default-to-one later to maint).
> 
>  * "git stripspace" should be usable outside a git repository, but
>    under the "-s" or "-c" mode, it didn't.
>    (merge 957da75802 jn/stripspace-wo-repository later to maint).
> 
>  * Some of the documentation pages formatted incorrectly with
>    Asciidoctor, which have been fixed.
>    (merge b62eb1d2f4 ma/asciidoctor later to maint).
> 
>  * The core.worktree setting in a submodule repository should not be
>    pointing at a directory when the submodule loses its working tree
>    (e.g. getting deinit'ed), but the code did not properly maintain
>    this invariant.
> 
>  * With zsh, "git cmd path<TAB>" was completed to "git cmd path name"
>    when the completed path has a special character like SP in it,
>    without any attempt to keep "path name" a single filename.  This
>    has been fixed to complete it to "git cmd path\ name" just like
>    Bash completion does.
> 
>  * The test suite tried to see if it is run under bash, but the check
>    itself failed under some other implementations of shell (notably
>    under NetBSD).  This has been corrected.
>    (merge 54ea72f09c sg/test-bash-version-fix later to maint).
> 
>  * "git gc" and "git repack" did not close the open packfiles that
>    they found unneeded before removing them, which didn't work on a
>    platform incapable of removing an open file.  This has been
>    corrected.
>    (merge 5bdece0d70 js/gc-repack-close-before-remove later to maint).
> 
>  * The code to drive GIT_EXTERNAL_DIFF command relied on the string
>    returned from getenv() to be non-volatile, which is not true, that
>    has been corrected.
>    (merge 6776a84dae kg/external-diff-save-env later to maint).
> 
>  * There were many places the code relied on the string returned from
>    getenv() to be non-volatile, which is not true, that have been
>    corrected.
>    (merge 0da0e9268b jk/save-getenv-result later to maint).
> 
>  * The v2 upload-pack protocol implementation failed to honor
>    hidden-ref configuration, which has been corrected.
>    (merge e20b4192a3 jk/proto-v2-hidden-refs-fix later to maint).
> 
>  * "git fetch --recurse-submodules" may not fetch the necessary commit
>    that is bound to the superproject, which is getting corrected.
>    (merge be76c21282 sb/submodule-recursive-fetch-gets-the-tip later to maint).
> 
>  * "git rebase" internally runs "checkout" to switch between branches,
>    and the command used to call the post-checkout hook, but the
>    reimplementation stopped doing so, which is getting fixed.
> 
>  * "git add -e" got confused when the change it wants to let the user
>    edit is smaller than the previous change that was left over in a
>    temporary file.
>    (merge fa6f225e01 js/add-e-clear-patch-before-stating later to maint).
> 
>  * "git p4" failed to update a shelved change when there were moved
>    files, which has been corrected.
>    (merge 7a10946ab9 ld/git-p4-shelve-update-fix later to maint).
> 
>  * The codepath to read from the commit-graph file attempted to read
>    past the end of it when the file's table-of-contents was corrupt.
> 
>  * The compat/obstack code had casts that -Wcast-function-type
>    compilation option found questionable.
>    (merge 764473d257 sg/obstack-cast-function-type-fix later to maint).
> 
>  * An obvious typo in an assertion error message has been fixed.
>    (merge 3c27e2e059 cc/test-ref-store-typofix later to maint).
> 
>  * In Git for Windows, "git clone \\server\share\path" etc. that uses
>    UNC paths from command line had bad interaction with its shell
>    emulation.
> 
>  * "git add --ignore-errors" did not work as advertised and instead
>    worked as an unintended synonym for "git add --renormalize", which
>    has been fixed.
>    (merge e2c2a37545 jk/add-ignore-errors-bit-assignment-fix later to maint).
> 
>  * On a case-insensitive filesystem, we failed to compare the part of
>    the path that is above the worktree directory in an absolute
>    pathname, which has been corrected.
> 
>  * Asking "git check-attr" about a macro (e.g. "binary") on a specific
>    path did not work correctly, even though "git check-attr -a" listed
>    such a macro correctly.  This has been corrected.
>    (merge 7b95849be4 jk/attr-macro-fix later to maint).
> 
>  * "git pack-objects" incorrectly used uninitialized mutex, which has
>    been corrected.
>    (merge edb673cf10 ph/pack-objects-mutex-fix later to maint).
> 
>  * "git checkout -b <new> [HEAD]" to create a new branch from the
>    current commit and check it out ought to be a no-op in the index
>    and the working tree in normal cases, but there are corner cases
>    that do require updates to the index and the working tree.  Running
>    it immediately after "git clone --no-checkout" is one of these
>    cases that an earlier optimization kicked in incorrectly, which has
>    been fixed.
>    (merge 8424bfd45b bp/checkout-new-branch-optim later to maint).
> 
>  * "git diff --color-moved --cc --stat -p" did not work well due to
>    funny interaction between a bug in color-moved and the rest, which
>    has been fixed.
>    (merge dac03b5518 jk/diff-cc-stat-fixes later to maint).
> 
>  * When GIT_SEQUENCE_EDITOR is set, the command was incorrectly
>    started when modes of "git rebase" that implicitly uses the
>    machinery for the interactive rebase are run, which has been
>    corrected.
>    (merge 891d4a0313 pw/no-editor-in-rebase-i-implicit later to maint).
> 
>  * The commit-graph facility did not work when in-core objects that
>    are promoted from unknown type to commit (e.g. a commit that is
>    accessed via a tag that refers to it) were involved, which has been
>    corrected.
>    (merge 4468d4435c sg/object-as-type-commit-graph-fix later to maint).
> 
>  * "git fetch" output cleanup.
>    (merge dc40b24df4 nd/fetch-compact-update later to maint).
> 
>  * "git cat-file --batch" reported a dangling symbolic link by
>    mistake, when it wanted to report that a given name is ambiguous.
> 
>  * Documentation around core.crlf has been updated.
>    (merge c9446f0504 jk/autocrlf-overrides-eol-doc later to maint).
> 
>  * The documentation of "git commit-tree" said that the command
>    understands "--gpg-sign" in addition to "-S", but the command line
>    parser did not know about the longhand, which has been corrected.
> 
>  * "git rebase -x $cmd" did not reject multi-line command, even though
>    the command is incapable of handling such a command.  It now is
>    rejected upfront.
>    (merge c762aada1a pw/rebase-x-sanity-check later to maint).
> 
>  * Output from "git help" was not correctly aligned, which has been
>    fixed.
>    (merge 6195a76da4 nd/help-align-command-desc later to maint).
> 
>  * The "git submodule summary" subcommand showed shortened commit
>    object names by mechanically truncating them at 7-hexdigit, which
>    has been improved to let "rev-parse --short" scale the length of
>    the abbreviation with the size of the repository.
>    (merge 0586a438f6 sh/submodule-summary-abbrev-fix later to maint).
> 
>  * The way the OSX build jobs updates its build environment used the
>    "--quiet" option to "brew update" command, but it wasn't all that
>    quiet to be useful.  The use of the option has been replaced with
>    an explicit redirection to the /dev/null (which incidentally would
>    have worked around a breakage by recent updates to homebrew, which
>    has fixed itself already).
>    (merge a1ccaedd62 sg/travis-osx-brew-breakage-workaround later to maint).
> 
>  * "git --work-tree=$there --git-dir=$here describe --dirty" did not
>    work correctly as it did not pay attention to the location of the
>    worktree specified by the user by mistake, which has been
>    corrected.
>    (merge c801170b0c ss/describe-dirty-in-the-right-directory later to maint).
> 
>  * "git fetch" over protocol v2 that needs to make a second connection
>    to backfill tags did not clear a variable that holds shallow
>    repository information correctly, leading to an access of freed
>    piece of memory.
> 
>  * Code cleanup, docfix, build fix, etc.
>    (merge 89ba9a79ae hb/t0061-dot-in-path-fix later to maint).
>    (merge d173e799ea sb/diff-color-moved-config-option-fixup later to maint).
>    (merge a8f5a59067 en/directory-renames-nothanks-doc-update later to maint).
>    (merge ec36c42a63 nd/indentation-fix later to maint).
>    (merge f116ee21cd do/gitweb-strict-export-conf-doc later to maint).
>    (merge 112ea42663 fd/gitweb-snapshot-conf-doc-fix later to maint).
>    (merge 1cadad6f65 tb/use-common-win32-pathfuncs-on-cygwin later to maint).
>    (merge 57e9dcaa65 km/rebase-doc-typofix later to maint).
>    (merge b8b4cb27e6 ds/gc-doc-typofix later to maint).
>    (merge 3b3357626e nd/style-opening-brace later to maint).
>    (merge b4583d5595 es/doc-worktree-guessremote-config later to maint).
>    (merge cce99cd8c6 ds/commit-graph-assert-missing-parents later to maint).
>    (merge 0650614982 cy/completion-typofix later to maint).
>    (merge 6881925ef5 rs/sha1-file-close-mapped-file-on-error later to maint).
>    (merge bd8d6f0def en/show-ref-doc-fix later to maint).
>    (merge 1747125e2c cc/partial-clone-doc-typofix later to maint).
>    (merge e01378753d cc/fetch-error-message-fix later to maint).
>    (merge 54e8c11215 jk/remote-insteadof-cleanup later to maint).
>    (merge d609615f48 js/test-git-installed later to maint).
>    (merge ba170517be ja/doc-style-fix later to maint).
>    (merge 86fb1c4e77 km/init-doc-typofix later to maint).
>    (merge 5cfd4a9d10 nd/commit-doc later to maint).
>    (merge 9fce19a431 ab/diff-tree-doc-fix later to maint).
> 
> ----------------------------------------------------------------
> 
> Changes since v2.20.0 are as follows:
> 
> Arti Zirk (1):
>       git-instaweb: add Python builtin http.server support
> 
> Ben Peart (2):
>       checkout: add test demonstrating regression with checkout -b on initial commit
>       checkout: fix regression in checkout -b on intitial checkout
> 
> Brandon Richardson (1):
>       commit-tree: add missing --gpg-sign flag
> 
> Brandon Williams (1):
>       mailmap: update brandon williams's email address
> 
> Carlo Marcelo Arenas Belón (4):
>       t6036: avoid non-portable "cp -a"
>       tests: add lint for non portable cp -a
>       t5004: avoid using tar for empty packages
>       config.mak.uname: OpenBSD uses BSD semantics with fread for directories
> 
> Chayoung You (3):
>       zsh: complete unquoted paths with spaces correctly
>       completion: treat results of git ls-tree as file paths
>       completion: fix typo in git-completion.bash
> 
> Christian Couder (3):
>       fetch: fix extensions.partialclone name in error message
>       partial-clone: add missing 'is' in doc
>       helper/test-ref-store: fix "new-sha1" vs "old-sha1" typo
> 
> David Turner (1):
>       Do not print 'dangling' for cat-file in case of ambiguity
> 
> Denis Ovsienko (1):
>       docs: fix $strict_export text in gitweb.conf.txt
> 
> Derrick Stolee (9):
>       merge-recursive: combine error handling
>       .gitattributes: ensure t/oid-info/* has eol=lf
>       commit-graph: writing missing parents is a BUG
>       git-gc.txt: fix typo about gc.writeCommitGraph
>       revision: add mark_tree_uninteresting_sparse
>       list-objects: consume sparse tree walk
>       revision: implement sparse algorithm
>       pack-objects: create pack.useSparse setting
>       pack-objects: create GIT_TEST_PACK_SPARSE
> 
> Elijah Newren (30):
>       t6042: add tests for consistency in file collision conflict handling
>       t6036, t6042: testcases for rename collision of already conflicting files
>       merge-recursive: increase marker length with depth of recursion
>       merge-recursive: new function for better colliding conflict resolutions
>       merge-recursive: fix rename/add conflict handling
>       merge-recursive: improve handling for rename/rename(2to1) conflicts
>       merge-recursive: use handle_file_collision for add/add conflicts
>       merge-recursive: improve rename/rename(1to2)/add[/add] handling
>       t6036, t6043: increase code coverage for file collision handling
>       fast-export: convert sha1 to oid
>       git-fast-import.txt: fix documentation for --quiet option
>       git-fast-export.txt: clarify misleading documentation about rev-list args
>       fast-export: use value from correct enum
>       fast-export: avoid dying when filtering by paths and old tags exist
>       fast-export: move commit rewriting logic into a function for reuse
>       fast-export: when using paths, avoid corrupt stream with non-existent mark
>       fast-export: ensure we export requested refs
>       fast-export: add --reference-excluded-parents option
>       fast-import: remove unmaintained duplicate documentation
>       fast-export: add a --show-original-ids option to show original names
>       git-rebase.txt: update note about directory rename detection and am
>       rebase: make builtin and legacy script error messages the same
>       rebase: fix incompatible options error message
>       t5407: add a test demonstrating how interactive handles --skip differently
>       am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
>       git-rebase, sequencer: extend --quiet option for the interactive machinery
>       git-legacy-rebase: simplify unnecessary triply-nested if
>       rebase: define linearization ordering and enforce it
>       rebase: implement --merge via the interactive machinery
>       git-show-ref.txt: fix order of flags
> 
> Eric Sunshine (1):
>       doc/config: do a better job of introducing 'worktree.guessRemote'
> 
> Eric Wong (2):
>       banned.h: mark strncat() as banned
>       t1512: test ambiguous cat-file --batch and --batch-output
> 
> Erin Dahlgren (1):
>       Simplify handling of setup_git_directory_gently() failure cases.
> 
> Force Charlie (1):
>       http: add support selecting http version
> 
> Frank Dana (1):
>       docs/gitweb.conf: config variable typo
> 
> Issac Trotts (1):
>       log: add %S option (like --source) to log --format
> 
> Jean-Noël Avila (2):
>       Documentation/Makefile add optional targets for l10n
>       doc: tidy asciidoc style
> 
> Jeff King (50):
>       fsck: do not reuse child_process structs
>       submodule--helper: prefer strip_suffix() to ends_with()
>       rename "alternate_object_database" to "object_directory"
>       sha1_file_name(): overwrite buffer instead of appending
>       handle alternates paths the same as the main object dir
>       sha1-file: use an object_directory for the main object dir
>       object-store: provide helpers for loose_objects_cache
>       sha1-file: use loose object cache for quick existence check
>       fetch-pack: drop custom loose object cache
>       odb_load_loose_cache: fix strbuf leak
>       transport-helper: drop read/write errno checks
>       sha1-file: fix outdated sha1 comment references
>       update comment references to sha1_object_info()
>       http: use struct object_id instead of bare sha1
>       sha1-file: modernize loose object file functions
>       sha1-file: modernize loose header/stream functions
>       sha1-file: convert pass-through functions to object_id
>       convert has_sha1_file() callers to has_object_file()
>       sha1-file: drop has_sha1_file()
>       sha1-file: prefer "loose object file" to "sha1 file" in messages
>       sha1-file: avoid "sha1 file" for generic use in messages
>       prefer "hash mismatch" to "sha1 mismatch"
>       upload-pack: support hidden refs with protocol v2
>       remote: check config validity before creating rewrite struct
>       get_super_prefix(): copy getenv() result
>       commit: copy saved getenv() result
>       config: make a copy of $GIT_CONFIG string
>       init: make a copy of $GIT_DIR string
>       merge-recursive: copy $GITHEAD strings
>       builtin_diff(): read $GIT_DIFF_OPTS closer to use
>       add: use separate ADD_CACHE_RENORMALIZE flag
>       attr: do not mark queried macros as unset
>       t4006: resurrect commented-out tests
>       diff: clear emitted_symbols flag after use
>       combine-diff: factor out stat-format mask
>       combine-diff: treat --shortstat like --stat
>       combine-diff: treat --summary like --stat
>       combine-diff: treat --dirstat like --stat
>       match-trees: drop unused path parameter from score functions
>       apply: drop unused "def" parameter from find_name_gnu()
>       create_bundle(): drop unused "header" parameter
>       column: drop unused "opts" parameter in item_length()
>       show_date_relative(): drop unused "tz" parameter
>       config: drop unused parameter from maybe_remove_section()
>       convert: drop len parameter from conversion checks
>       convert: drop path parameter from actual conversion functions
>       doc/gitattributes: clarify "autocrlf overrides eol"
>       docs/config: clarify "text property" in core.eol
>       test-date: drop unused parameter to getnanos()
>       add_to_index(): convert forgotten HASH_RENORMALIZE check
> 
> Johannes Schindelin (39):
>       rebase: introduce --reschedule-failed-exec
>       rebase: add a config option to default to --reschedule-failed-exec
>       rebase: introduce a shortcut for --reschedule-failed-exec
>       help.h: fix coding style
>       help -a: handle aliases with long names gracefully
>       t4256: mark support files as LF-only
>       t9902: 'send-email' test case requires PERL
>       gc/repack: release packs when needed
>       add --edit: truncate the patch file
>       t6042: work around speed optimization on Windows
>       abspath_part_inside_repo: respect core.ignoreCase
>       rebase: move `reset_head()` into a better spot
>       rebase: avoid double reflog entry when switching branches
>       rebase: teach `reset_head()` to optionally skip the worktree
>       built-in rebase: call `git am` directly
>       mingw (t5580): document bug when cloning from backslashed UNC paths
>       mingw: special-case arguments to `sh`
>       tests: explicitly use `test-tool.exe` on Windows
>       travis: fix skipping tagged releases
>       ci: rename the library of common functions
>       ci/lib.sh: encapsulate Travis-specific things
>       ci: inherit --jobs via MAKEFLAGS in run-build-and-tests
>       ci: use a junction on Windows instead of a symlink
>       test-date: add a subcommand to measure times in shell scripts
>       tests: optionally write results as JUnit-style .xml
>       ci/lib.sh: add support for Azure Pipelines
>       Add a build definition for Azure DevOps
>       ci: add a Windows job to the Azure Pipelines definition
>       ci: use git-sdk-64-minimal build artifact
>       mingw: be more generous when wrapping up the setitimer() emulation
>       README: add a build badge (status of the Azure Pipelines build)
>       tests: avoid calling Perl just to determine file sizes
>       tests: include detailed trace logs with --write-junit-xml upon failure
>       mingw: try to work around issues with the test cleanup
>       tests: add t/helper/ to the PATH with --with-dashes
>       t0061: workaround issues with --with-dashes and RUNTIME_PREFIX
>       tests: optionally skip bin-wrappers/
>       ci: speed up Windows phase
>       ci: parallelize testing on Windows
> 
> Jonathan Nieder (1):
>       stripspace: allow -s/-c outside git repository
> 
> Jonathan Tan (9):
>       revision: use commit graph in get_reference()
>       fetch-pack: support protocol version 2
>       fetch-pack: do not take shallow lock unnecessarily
>       upload-pack: teach deepen-relative in protocol v2
>       pkt-line: introduce struct packet_writer
>       sideband: reverse its dependency on pkt-line
>       {fetch,upload}-pack: sideband v2 fetch response
>       tests: define GIT_TEST_SIDEBAND_ALL
>       ls-refs: filter refs using namespace-stripped name
> 
> Josh Steadmon (4):
>       filter-options: expand scaled numbers
>       commit-graph, fuzz: add fuzzer for commit-graph
>       commit-graph: fix buffer read-overflow
>       Makefile: correct example fuzz build
> 
> Junio C Hamano (13):
>       t0027: squelch checkout path run outside test_expect_* block
>       t0061: do not fail test if '.' is part of $PATH
>       run-command: report exec failure
>       submodule update: run at most one fetch job unless otherwise set
>       Git 2.20.1
>       Prepare for 2.21 cycle to start soonish
>       First batch after 2.20.1
>       ref-filter: give uintmax_t to format with %PRIuMAX
>       Second batch after 2.20
>       Third batch after 2.20
>       Fourth batch after 2.20
>       Fifth batch for 2.21
>       Git 2.21-rc0
> 
> Kim Gybels (1):
>       diff: ensure correct lifetime of external_diff_cmd
> 
> Kyle Meyer (2):
>       rebase docs: drop stray word in merge command description
>       init docs: correct a punctuation typo
> 
> Laura Abbott (1):
>       git-quiltimport: add --keep-non-patch option
> 
> Linus Torvalds (1):
>       Add 'human' date format
> 
> Luke Diamand (2):
>       git-p4: add failing test for shelved CL update involving move/copy
>       git-p4: handle update of moved/copied files when updating a shelve
> 
> Martin Ågren (5):
>       git-column.txt: fix section header
>       Documentation: do not nest open blocks
>       git-status.txt: render tables correctly under Asciidoctor
>       t7510: invoke git as part of &&-chain
>       doc-diff: don't `cd_to_toplevel`
> 
> Masaya Suzuki (7):
>       Use packet_reader instead of packet_read_line
>       pack-protocol.txt: accept error packets in any context
>       http: support file handles for HTTP_KEEP_ERROR
>       http: enable keep_error for HTTP requests
>       remote-curl: define struct for CURLOPT_WRITEFUNCTION
>       remote-curl: unset CURLOPT_FAILONERROR
>       test: test GIT_CURL_VERBOSE=1 shows an error
> 
> Matthew DeVore (4):
>       list-objects.c: don't segfault for missing cmdline objects
>       revision.c: put promisor option in specialized struct
>       list-objects-filter: teach tree:# how to handle >0
>       tree:<depth>: skip some trees even when collecting omits
> 
> Matthieu Moy (1):
>       git-multimail: update to release 1.5.0
> 
> Max Kirillov (1):
>       http-backend: enable cleaning up forked upload/receive-pack on exit
> 
> Nguyễn Thái Ngọc Duy (63):
>       git.c: mark more strings for translation
>       alias.c: mark split_cmdline_strerror() strings for translation
>       archive.c: mark more strings for translation
>       attr.c: mark more string for translation
>       read-cache.c: turn die("internal error") to BUG()
>       read-cache.c: mark more strings for translation
>       read-cache.c: add missing colon separators
>       reflog: mark strings for translation
>       remote.c: turn some error() or die() to BUG()
>       remote.c: mark messages for translation
>       repack: mark more strings for translation
>       parse-options: replace opterror() with optname()
>       parse-options.c: turn some die() to BUG()
>       parse-options.c: mark more strings for translation
>       fsck: reduce word legos to help i18n
>       fsck: mark strings for translation
>       wt-status.c: remove implicit dependency on the_index
>       wt-status.c: remove implicit dependency the_repository
>       list-objects-filter.c: remove implicit dependency on the_index
>       list-objects.c: reduce the_repository references
>       notes-merge.c: remove implicit dependency on the_index
>       notes-merge.c: remove implicit dependency the_repository
>       transport.c: remove implicit dependency on the_index
>       sequencer.c: remove implicit dependency on the_index
>       sequencer.c: remove implicit dependency on the_repository
>       blame.c: remove implicit dependency the_repository
>       bisect.c: remove the_repository reference
>       branch.c: remove the_repository reference
>       bundle.c: remove the_repository references
>       cache-tree.c: remove the_repository references
>       delta-islands.c: remove the_repository references
>       diff-lib.c: remove the_repository references
>       line-log.c: remove the_repository reference
>       notes-cache.c: remove the_repository references
>       pack-check.c: remove the_repository references
>       pack-*.c: remove the_repository references
>       rerere.c: remove the_repository references
>       rebase-interactive.c: remove the_repository references
>       checkout: disambiguate dwim tracking branches and local files
>       checkout: print something when checking out paths
>       tree.c: make read_tree*() take 'struct repository *'
>       tree-walk.c: make tree_entry_interesting() take an index
>       pathspec.h: clean up "extern" in function declarations
>       dir.c: move, rename and export match_attrs()
>       tree-walk: support :(attr) matching
>       Indent code with TABs
>       style: the opening '{' of a function is in a separate line
>       parse-options: fix SunCC compiler warning
>       worktree: allow to (re)move worktrees with uninitialized submodules
>       grep: use grep_opt->repo instead of explict repo argument
>       notes-utils.c: remove the_repository references
>       repository.c: replace hold_locked_index() with repo_hold_locked_index()
>       checkout: avoid the_index when possible
>       read-cache.c: kill read_index()
>       read-cache.c: replace update_index_if_able with repo_&
>       sha1-name.c: remove implicit dependency on the_index
>       merge-recursive.c: remove implicit dependency on the_index
>       merge-recursive.c: remove implicit dependency on the_repository
>       read-cache.c: remove the_* from index_has_changes()
>       cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch
>       fetch: prefer suffix substitution in compact fetch.output
>       help: align the longest command in the command listing
>       git-commit.txt: better description what it does
> 
> Olga Telezhnaya (6):
>       ref-filter: add objectsize:disk option
>       ref-filter: add check for negative file size
>       ref-filter: add tests for objectsize:disk
>       ref-filter: add deltabase option
>       ref-filter: add tests for deltabase
>       ref-filter: add docs for new options
> 
> Orgad Shaneh (2):
>       t5403: simplify by using a single repository
>       rebase: run post-checkout hook on checkout
> 
> Patrick Hogg (2):
>       pack-objects: move read mutex to packing_data struct
>       pack-objects: merge read_lock and lock in packing_data struct
> 
> Peter Osterlund (1):
>       git-p4: fix problem when p4 login is not necessary
> 
> Phillip Wood (11):
>       diff: document --no-color-moved
>       Use "whitespace" consistently
>       diff: allow --no-color-moved-ws
>       diff --color-moved-ws: demonstrate false positives
>       diff --color-moved-ws: fix false positives
>       diff --color-moved=zebra: be stricter with color alternation
>       diff --color-moved-ws: optimize allow-indentation-change
>       diff --color-moved-ws: modify allow-indentation-change
>       diff --color-moved-ws: handle blank lines
>       implicit interactive rebase: don't run sequence editor
>       rebase -x: sanity check command
> 
> Pranit Bauva (7):
>       bisect--helper: `bisect_reset` shell function in C
>       bisect--helper: `bisect_write` shell function in C
>       wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
>       bisect--helper: `check_and_set_terms` shell function in C
>       bisect--helper: `bisect_next_check` shell function in C
>       bisect--helper: `get_terms` & `bisect_terms` shell function in C
>       bisect--helper: `bisect_start` shell function partially in C
> 
> Ramsay Jones (2):
>       config.mak.uname: remove obsolete SPARSE_FLAGS setting
>       Makefile: improve SPARSE_FLAGS customisation
> 
> Randall S. Becker (4):
>       transport-helper: use xread instead of read
>       config.mak.uname: support for modern HPE NonStop config.
>       git-compat-util.h: add FLOSS headers for HPE NonStop
>       compat/regex/regcomp.c: define intptr_t and uintptr_t on NonStop
> 
> René Scharfe (5):
>       sha1-file: close fd of empty file in map_sha1_file_1()
>       object-store: factor out odb_loose_cache()
>       object-store: factor out odb_clear_loose_cache()
>       object-store: use one oid_array per subdirectory for loose cache
>       object-store: retire odb_load_loose_cache()
> 
> SZEDER Gábor (22):
>       clone: use a more appropriate variable name for the default refspec
>       clone: respect additional configured fetch refspecs during initial fetch
>       Documentation/clone: document ignored configuration variables
>       test-lib: check Bash version for '-x' without using shell arrays
>       test-lib: translate SIGTERM and SIGHUP to an exit
>       test-lib: extract Bash version check for '-x' tracing
>       test-lib: parse options in a for loop to keep $@ intact
>       test-lib: parse command line options earlier
>       test-lib: consolidate naming of test-results paths
>       test-lib: set $TRASH_DIRECTORY earlier
>       test-lib-functions: introduce the 'test_set_port' helper function
>       test-lib: add the '--stress' option to run a test repeatedly under load
>       compat/obstack: fix -Wcast-function-type warnings
>       .gitignore: ignore external debug symbols from GCC on macOS
>       travis-ci: don't be '--quiet' when running the tests
>       travis-ci: switch to Xcode 10.1 macOS image
>       travis-ci: build with the right compiler
>       commit-graph: rename "large edges" to "extra edges"
>       commit-graph: don't call write_graph_chunk_extra_edges() unnecessarily
>       strbuf.cocci: suggest strbuf_addbuf() to add one strbuf to an other
>       object_as_type: initialize commit-graph-related fields of 'struct commit'
>       travis-ci: make the OSX build jobs' 'brew update' more quiet
> 
> Sebastian Staudt (2):
>       describe: setup working tree for --dirty
>       t6120: test for describe with a bare repository
> 
> Sergey Organov (4):
>       t3510: stop using '-m 1' to force failure mid-sequence of cherry-picks
>       cherry-pick: do not error on non-merge commits when '-m 1' is specified
>       t3502: validate '-m 1' argument is now accepted for non-merge commits
>       t3506: validate '-m 1 -ff' is now accepted for non-merge commits
> 
> Shahzad Lone (1):
>       various: tighten constness of some local variables
> 
> Slavica Djukic (1):
>       stash: tolerate missing user identity
> 
> Stefan Beller (39):
>       sha1_file: allow read_object to read objects in arbitrary repositories
>       packfile: allow has_packed_and_bad to handle arbitrary repositories
>       diff: align move detection error handling with other options
>       object-store: allow read_object_file_extended to read from any repo
>       object-store: prepare read_object_file to deal with any repo
>       object-store: prepare has_{sha1, object}_file to handle any repo
>       object: parse_object to honor its repository argument
>       commit: allow parse_commit* to handle any repo
>       commit-reach.c: allow paint_down_to_common to handle any repo
>       commit-reach.c: allow merge_bases_many to handle any repo
>       commit-reach.c: allow remove_redundant to handle any repo
>       commit-reach.c: allow get_merge_bases_many_0 to handle any repo
>       commit-reach: prepare get_merge_bases to handle any repo
>       commit-reach: prepare in_merge_bases[_many] to handle any repo
>       commit: prepare get_commit_buffer to handle any repo
>       commit: prepare repo_unuse_commit_buffer to handle any repo
>       commit: prepare logmsg_reencode to handle arbitrary repositories
>       pretty: prepare format_commit_message to handle arbitrary repositories
>       sideband: color lines with keyword only
>       sha1-array: provide oid_array_filter
>       submodule.c: fix indentation
>       submodule.c: sort changed_submodule_names before searching it
>       submodule.c: tighten scope of changed_submodule_names struct
>       submodule: store OIDs in changed_submodule_names
>       repository: repo_submodule_init to take a submodule struct
>       submodule: migrate get_next_submodule to use repository structs
>       submodule.c: fetch in submodules git directory instead of in worktree
>       fetch: ensure submodule objects fetched
>       submodule update: add regression test with old style setups
>       submodule: unset core.worktree if no working tree is present
>       submodule--helper: fix BUG message in ensure_core_worktree
>       submodule deinit: unset core.worktree
>       submodule: use submodule repos for object lookup
>       submodule: don't add submodule as odb for push
>       commit-graph: convert remaining functions to handle any repo
>       commit: prepare free_commit_buffer and release_commit_memory for any repo
>       path.h: make REPO_GIT_PATH_FUNC repository agnostic
>       t/helper/test-repository: celebrate independence from the_repository
>       git-submodule: abort if core.worktree could not be set correctly
> 
> Stephen P. Smith (4):
>       Replace the proposed 'auto' mode with 'auto:'
>       Add 'human' date format documentation
>       Add `human` format to test-tool
>       Add `human` date format tests.
> 
> Sven van Haastregt (1):
>       git-submodule.sh: shorten submodule SHA-1s using rev-parse
> 
> Thomas Braun (1):
>       log -G: ignore binary files
> 
> Thomas Gummerer (3):
>       t5570: drop racy test
>       Revert "t/lib-git-daemon: record daemon log"
>       config.mak.dev: add -Wall, primarily for -Wformat, to help autoconf users
> 
> Torsten Bögershausen (3):
>       git clone <url> C:\cygwin\home\USER\repo' is working (again)
>       test-lint: only use only sed [-n] [-e command] [-f command_file]
>       Support working-tree-encoding "UTF-16LE-BOM"
> 
> brian m. carlson (19):
>       sha1-file: rename algorithm to "sha1"
>       sha1-file: provide functions to look up hash algorithms
>       hex: introduce functions to print arbitrary hashes
>       cache: make hashcmp and hasheq work with larger hashes
>       t: add basic tests for our SHA-1 implementation
>       t: make the sha1 test-tool helper generic
>       sha1-file: add a constant for hash block size
>       t/helper: add a test helper to compute hash speed
>       commit-graph: convert to using the_hash_algo
>       Add a base implementation of SHA-256 support
>       sha256: add an SHA-256 implementation using libgcrypt
>       hash: add an SHA-256 implementation using OpenSSL
>       tree-walk: copy object ID before use
>       match-trees: compute buffer offset correctly when splicing
>       match-trees: use hashcpy to splice trees
>       tree-walk: store object_id in a separate member
>       cache: make oidcpy always copy GIT_MAX_RAWSZ bytes
>       fetch-pack: clear alternate shallow when complete
>       fetch-pack: clear alternate shallow in one more place
> 
> Ævar Arnfjörð Bjarmason (17):
>       remote.c: add braces in anticipation of a follow-up change
>       i18n: remote.c: mark error(...) messages for translation
>       push: improve the error shown on unqualified <dst> push
>       push: move unqualified refname error into a function
>       push: add an advice on unqualified <dst> push
>       push: test that <src> doesn't DWYM if <dst> is unqualified
>       push doc: document the DWYM behavior pushing to unqualified <dst>
>       commit-graph: split up close_reachable() progress output
>       commit-graph write: use pack order when finding commits
>       commit-graph write: add "Writing out" progress output
>       commit-graph write: more descriptive "writing out" output
>       commit-graph write: show progress for object search
>       commit-graph write: add more descriptive progress output
>       commit-graph write: remove empty line for readability
>       commit-graph write: add itermediate progress
>       commit-graph write: emit a percentage for all progress
>       diff-tree doc: correct & remove wrong documentation
> 
> 
--8323328-873276717-1549568853=:41--
