Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2D421F404
	for <e@80x24.org>; Wed, 29 Aug 2018 14:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeH2Srv (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 14:47:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:60467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbeH2Srv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 14:47:51 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M54fe-1fiIs03cgo-00zHRl; Wed, 29
 Aug 2018 16:50:26 +0200
Date:   Wed, 29 Aug 2018 16:50:20 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, git-for-windows@googlegroups.com,
        git-packagers@googlegroups.com
Subject: Git for Windows v2.19.0-rc1, was Re: [ANNOUNCE] Git v2.19.0-rc1
In-Reply-To: <xmqqftyyfecy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808291647490.71@tvgsbejvaqbjf.bet>
References: <xmqqftyyfecy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2063497472-1535554226=:71"
X-Provags-ID: V03:K1:ePaRfRgrFaBkcNe6iPmPihE8Ey7cV4lLiMcWUQs4MFI7RVbHP4T
 5WRLtMTCbkdsmEiuZF8eCIWoNMu8CN3joXtm4w5XjWTqqktTEssNgPhLFxX1bqslAYhdWpX
 z1PfRlVsXKY0pMVwax6tBLkpD4ER6QS4OOk+3KpG+NoooA5k4OSma99SUWctynjeV3In5W8
 vGj23c5iQ8iRFzbZA3Jjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/eqUQdC0xOM=:w7piP+k0UDKaoQW3CR9chw
 jpGYICw6GGjSjDd83RcU0QWWKAUWksBCyOS61sxHzF5EN+IbV2aZgOJOs627+cTZwXjrQiXxt
 +mtLMUYIfUNP6/VsrI4qJcfQXIoDoXa+F8Rfg1my9RnUK+YFOyiy/IitEbaMuesOf33fsVPTO
 8PtvtkbArO7c2pFlk1W5274rLXEBKcyb/t2QP4lQTM1gPc7QdeOwCe3huJ236hpLcu/3owmAi
 szfE6hbILPol0LQqr7tBuEDazOmN3EZOHKHHVUn18u+yWFgQsDFV698AzWOiafao8Swnw2OAA
 RgcK+l06aPWZUGs4c0ZHfEcupP2iO4FctmzPDoLqGaQY+v/nomhgOo0hLukE9Bgpcr+erRxLp
 pbTXipvkh9vASg7eTPCJlCB2FwZuuWOdx9/UaqKJwKa9Vgr02G81JgPztcaZUqGXqsFAkra0X
 3BKbTm3AMCe6t80vygF6eJkDNUuhIy/y0yX54wD96eukBnJ4JARvhlNUiy18twfGNvU2NiZNH
 ZGHokbaZXrG3l5Am/sVdWKfhwZoqi7pF5w+rommciYKgQyvsDWFKmVkB8J/5+VTUh/E9G6Qww
 kl9LMNWX432aPwJ023qEamIZK/bDkWz7lj7kM4vsYGKDbQ4GmkUSN2AziOqDKjXIJA1hoNF+w
 yBz6D3922Z1idCWv+Ye2nfs7TVi/uP0ewjyDqb9eh8vLCiewsrUPyawXc6rGpomfB0shgteB/
 zJrETx4a3ja9CbA9OdVT5PRxn0utOSR5Cw4GIySnlppInKlv4lpFFZZHtGYsNDWiBKj9szPIC
 Lz4pmWp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2063497472-1535554226=:71
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Team,

the corresponding Git for Windows v2.19.0-rc1 (most notably with the
Experimental Options page in the installer letting you opt into using the
built-in `stash` and `rebase`) was built by Jameson Miller (and me) last
night and can be found here:

https://github.com/git-for-windows/git/releases/v2.19.0-rc1.windows.1

Ciao,
Johannes

On Tue, 28 Aug 2018, Junio C Hamano wrote:

> A release candidate Git v2.19.0-rc1 is now available for testing
> at the usual places.  It is comprised of 735 non-merge commits
> since v2.18.0, contributed by 64 people, 15 of which are new faces.
>=20
> The tarballs are found at:
>=20
>     https://www.kernel.org/pub/software/scm/git/testing/
>=20
> The following public repositories all have a copy of the
> 'v2.19.0-rc1' tag and the 'master' branch that the tag points at:
>=20
>   url =3D https://kernel.googlesource.com/pub/scm/git/git
>   url =3D git://repo.or.cz/alt-git.git
>   url =3D https://github.com/gitster/git
>=20
> New contributors whose contributions weren't in v2.18.0 are as follows.
> Welcome to the Git development community!
>=20
>   Aleksandr Makarov, Andrei Rybak, Chen Bin, Henning Schild,
>   Isabella Stephens, Josh Steadmon, Jules Maselbas, Kana Natsuno,
>   Marc Strapetz, Masaya Suzuki, Nicholas Guriev, Samuel Maftoul,
>   Sebastian Kisela, Vladimir Parfinenko, and William Chargin.
>=20
> Returning contributors who helped this release are as follows.
> Thanks for your continued support.
>=20
>   Aaron Schrab, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alban Gruin, Alej=
andro
>   R. Sede=C3=B1o, Anthony Sottile, Antonio Ospite, Beat Bolli, Ben
>   Peart, Brandon Williams, brian m. carlson, Christian Couder,
>   Derrick Stolee, Elia Pinto, Elijah Newren, Eric Sunshine,
>   Han-Wen Nienhuys, Jameson Miller, Jean-No=C3=ABl Avila, Jeff
>   Hostetler, Jeff King, Johannes Schindelin, Johannes Sixt,
>   Jonathan Nieder, Jonathan Tan, Junio C Hamano, Kim Gybels,
>   Kirill Smelkov, Kyle Meyer, Luis Marsano, =C5=81ukasz Stelmach,
>   Luke Diamand, Martin =C3=85gren, Max Kirillov, Michael Barabanov,
>   Mike Hommey, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy, Olga Telezhnaya=
,
>   Phillip Wood, Prathamesh Chavan, Ramsay Jones, Ren=C3=A9 Scharfe,
>   Stefan Beller, SZEDER G=C3=A1bor, Taylor Blau, Thomas Rast, Tobias
>   Klauser, Todd Zullinger, Ville Skytt=C3=A4, and Xiaolong Ye.
>=20
> ----------------------------------------------------------------
>=20
> Git 2.19 Release Notes (draft)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20
> Updates since v2.18
> -------------------
>=20
> UI, Workflows & Features
>=20
>  * "git diff" compares the index and the working tree.  For paths
>    added with intent-to-add bit, the command shows the full contents
>    of them as added, but the paths themselves were not marked as new
>    files.  They are now shown as new by default.
>=20
>    "git apply" learned the "--intent-to-add" option so that an
>    otherwise working-tree-only application of a patch will add new
>    paths to the index marked with the "intent-to-add" bit.
>=20
>  * "git grep" learned the "--column" option that gives not just the
>    line number but the column number of the hit.
>=20
>  * The "-l" option in "git branch -l" is an unfortunate short-hand for
>    "--create-reflog", but many users, both old and new, somehow expect
>    it to be something else, perhaps "--list".  This step warns when "-l"
>    is used as a short-hand for "--create-reflog" and warns about the
>    future repurposing of the it when it is used.
>=20
>  * The userdiff pattern for .php has been updated.
>=20
>  * The content-transfer-encoding of the message "git send-email" sends
>    out by default was 8bit, which can cause trouble when there is an
>    overlong line to bust RFC 5322/2822 limit.  A new option 'auto' to
>    automatically switch to quoted-printable when there is such a line
>    in the payload has been introduced and is made the default.
>=20
>  * "git checkout" and "git worktree add" learned to honor
>    checkout.defaultRemote when auto-vivifying a local branch out of a
>    remote tracking branch in a repository with multiple remotes that
>    have tracking branches that share the same names.
>    (merge 8d7b558bae ab/checkout-default-remote later to maint).
>=20
>  * "git grep" learned the "--only-matching" option.
>=20
>  * "git rebase --rebase-merges" mode now handles octopus merges as
>    well.
>=20
>  * Add a server-side knob to skip commits in exponential/fibbonacci
>    stride in an attempt to cover wider swath of history with a smaller
>    number of iterations, potentially accepting a larger packfile
>    transfer, instead of going back one commit a time during common
>    ancestor discovery during the "git fetch" transaction.
>    (merge 42cc7485a2 jt/fetch-negotiator-skipping later to maint).
>=20
>  * A new configuration variable core.usereplacerefs has been added,
>    primarily to help server installations that want to ignore the
>    replace mechanism altogether.
>=20
>  * Teach "git tag -s" etc. a few configuration variables (gpg.format
>    that can be set to "openpgp" or "x509", and gpg.<format>.program
>    that is used to specify what program to use to deal with the format)
>    to allow x.509 certs with CMS via "gpgsm" to be used instead of
>    openpgp via "gnupg".
>=20
>  * Many more strings are prepared for l10n.
>=20
>  * "git p4 submit" learns to ask its own pre-submit hook if it should
>    continue with submitting.
>=20
>  * The test performed at the receiving end of "git push" to prevent
>    bad objects from entering repository can be customized via
>    receive.fsck.* configuration variables; we now have gained a
>    counterpart to do the same on the "git fetch" side, with
>    fetch.fsck.* configuration variables.
>=20
>  * "git pull --rebase=3Dinteractive" learned "i" as a short-hand for
>    "interactive".
>=20
>  * "git instaweb" has been adjusted to run better with newer Apache on
>    RedHat based distros.
>=20
>  * "git range-diff" is a reimplementation of "git tbdiff" that lets us
>    compare individual patches in two iterations of a topic.
>=20
>  * The sideband code learned to optionally paint selected keywords at
>    the beginning of incoming lines on the receiving end.
>=20
>  * "git branch --list" learned to take the default sort order from the
>    'branch.sort' configuration variable, just like "git tag --list"
>    pays attention to 'tag.sort'.
>=20
>  * "git worktree" command learned "--quiet" option to make it less
>    verbose.
>=20
>=20
> Performance, Internal Implementation, Development Support etc.
>=20
>  * The bulk of "git submodule foreach" has been rewritten in C.
>=20
>  * The in-core "commit" object had an all-purpose "void *util" field,
>    which was tricky to use especially in library-ish part of the
>    code.  All of the existing uses of the field has been migrated to a
>    more dedicated "commit-slab" mechanism and the field is eliminated.
>=20
>  * A less often used command "git show-index" has been modernized.
>    (merge fb3010c31f jk/show-index later to maint).
>=20
>  * The conversion to pass "the_repository" and then "a_repository"
>    throughout the object access API continues.
>=20
>  * Continuing with the idea to programatically enumerate various
>    pieces of data required for command line completion, teach the
>    codebase to report the list of configuration variables
>    subcommands care about to help complete them.
>=20
>  * Separate "rebase -p" codepath out of "rebase -i" implementation to
>    slim down the latter and make it easier to manage.
>=20
>  * Make refspec parsing codepath more robust.
>=20
>  * Some flaky tests have been fixed.
>=20
>  * Continuing with the idea to programmatically enumerate various
>    pieces of data required for command line completion, the codebase
>    has been taught to enumerate options prefixed with "--no-" to
>    negate them.
>=20
>  * Build and test procedure for netrc credential helper (in contrib/)
>    has been updated.
>=20
>  * The conversion to pass "the_repository" and then "a_repository"
>    throughout the object access API continues.
>=20
>  * Remove unused function definitions and declarations from ewah
>    bitmap subsystem.
>=20
>  * Code preparation to make "git p4" closer to be usable with Python 3.
>=20
>  * Tighten the API to make it harder to misuse in-tree .gitmodules
>    file, even though it shares the same syntax with configuration
>    files, to read random configuration items from it.
>=20
>  * "git fast-import" has been updated to avoid attempting to create
>    delta against a zero-byte-long string, which is pointless.
>=20
>  * The codebase has been updated to compile cleanly with -pedantic
>    option.
>    (merge 2b647a05d7 bb/pedantic later to maint).
>=20
>  * The character display width table has been updated to match the
>    latest Unicode standard.
>    (merge 570951eea2 bb/unicode-11-width later to maint).
>=20
>  * test-lint now looks for broken use of "VAR=3DVAL shell_func" in test
>    scripts.
>=20
>  * Conversion from uchar[40] to struct object_id continues.
>=20
>  * Recent "security fix" to pay attention to contents of ".gitmodules"
>    while accepting "git push" was a bit overly strict than necessary,
>    which has been adjusted.
>=20
>  * "git fsck" learns to make sure the optional commit-graph file is in
>    a sane state.
>=20
>  * "git diff --color-moved" feature has further been tweaked.
>=20
>  * Code restructuring and a small fix to transport protocol v2 during
>    fetching.
>=20
>  * Parsing of -L[<N>][,[<M>]] parameters "git blame" and "git log"
>    take has been tweaked.
>=20
>  * lookup_commit_reference() and friends have been updated to find
>    in-core object for a specific in-core repository instance.
>=20
>  * Various glitches in the heuristics of merge-recursive strategy have
>    been documented in new tests.
>=20
>  * "git fetch" learned a new option "--negotiation-tip" to limit the
>    set of commits it tells the other end as "have", to reduce wasted
>    bandwidth and cycles, which would be helpful when the receiving
>    repository has a lot of refs that have little to do with the
>    history at the remote it is fetching from.
>=20
>  * For a large tree, the index needs to hold many cache entries
>    allocated on heap.  These cache entries are now allocated out of a
>    dedicated memory pool to amortize malloc(3) overhead.
>=20
>  * Tests to cover various conflicting cases have been added for
>    merge-recursive.
>=20
>  * Tests to cover conflict cases that involve submodules have been
>    added for merge-recursive.
>=20
>  * Look for broken "&&" chains that are hidden in subshell, many of
>    which have been found and corrected.
>=20
>  * The singleton commit-graph in-core instance is made per in-core
>    repository instance.
>=20
>  * "make DEVELOPER=3D1 DEVOPTS=3Dpedantic" allows developers to compile
>    with -pedantic option, which may catch more problematic program
>    constructs and potential bugs.
>=20
>  * Preparatory code to later add json output for telemetry data has
>    been added.
>=20
>  * Update the way we use Coccinelle to find out-of-style code that
>    need to be modernised.
>=20
>  * It is too easy to misuse system API functions such as strcat();
>    these selected functions are now forbidden in this codebase and
>    will cause a compilation failure.
>=20
>  * Add a script (in contrib/) to help users of VSCode work better with
>    our codebase.
>=20
>  * The Travis CI scripts were taught to ship back the test data from
>    failed tests.
>    (merge aea8879a6a sg/travis-retrieve-trash-upon-failure later to maint=
).
>=20
>  * The parse-options machinery learned to refrain from enclosing
>    placeholder string inside a "<bra" and "ket>" pair automatically
>    without PARSE_OPT_LITERAL_ARGHELP.  Existing help text for option
>    arguments that are not formatted correctly have been identified and
>    fixed.
>    (merge 5f0df44cd7 rs/parse-opt-lithelp later to maint).
>=20
>  * Noiseword "extern" has been removed from function decls in the
>    header files.
>=20
>  * A few atoms like %(objecttype) and %(objectsize) in the format
>    specifier of "for-each-ref --format=3D<format>" can be filled without
>    getting the full contents of the object, but just with the object
>    header.  These cases have been optimized by calling
>    oid_object_info() API (instead of reading and inspecting the data).
>=20
>  * The end result of documentation update has been made to be
>    inspected more easily to help developers.
>=20
>  * The API to iterate over all objects learned to optionally list
>    objects in the order they appear in packfiles, which helps locality
>    of access if the caller accesses these objects while as objects are
>    enumerated.
>=20
>  * Improve built-in facility to catch broken &&-chain in the tests.
>=20
>  * The more library-ish parts of the codebase learned to work on the
>    in-core index-state instance that is passed in by their callers,
>    instead of always working on the singleton "the_index" instance.
>=20
>  * A test prerequisite defined by various test scripts with slightly
>    different semantics has been consolidated into a single copy and
>    made into a lazily defined one.
>    (merge 6ec633059a wc/make-funnynames-shared-lazy-prereq later to maint=
).
>=20
>  * After a partial clone, repeated fetches from promisor remote would
>    have accumulated many packfiles marked with .promisor bit without
>    getting them coalesced into fewer packfiles, hurting performance.
>    "git repack" now learned to repack them.
>=20
>  * Partially revert the support for multiple hash functions to regain
>    hash comparison performance; we'd think of a way to do this better
>    in the next cycle.
>=20
>  * "git help --config" (which is used in command line completion)
>    missed the configuration variables not described in the main
>    config.txt file but are described in another file that is included
>    by it, which has been corrected.
>=20
> Fixes since v2.18
> -----------------
>=20
>  * "git remote update" can take both a single remote nickname and a
>    nickname for remote groups, and the completion script (in contrib/)
>    has been taught about it.
>    (merge 9cd4382ad5 ls/complete-remote-update-names later to maint).
>=20
>  * "git fetch --shallow-since=3D<cutoff>" that specifies the cut-off
>    point that is newer than the existing history used to end up
>    grabbing the entire history.  Such a request now errors out.
>    (merge e34de73c56 nd/reject-empty-shallow-request later to maint).
>=20
>  * Fix for 2.17-era regression around `core.safecrlf`.
>    (merge 6cb09125be as/safecrlf-quiet-fix later to maint).
>=20
>  * The recent addition of "partial clone" experimental feature kicked
>    in when it shouldn't, namely, when there is no partial-clone filter
>    defined even if extensions.partialclone is set.
>    (merge cac1137dc4 jh/partial-clone later to maint).
>=20
>  * "git send-pack --signed" (hence "git push --signed" over the http
>    transport) did not read user ident from the config mechanism to
>    determine whom to sign the push certificate as, which has been
>    corrected.
>    (merge d067d98887 ms/send-pack-honor-config later to maint).
>=20
>  * "git fetch-pack --all" used to unnecessarily fail upon seeing an
>    annotated tag that points at an object other than a commit.
>    (merge c12c9df527 jk/fetch-all-peeled-fix later to maint).
>=20
>  * When user edits the patch in "git add -p" and the user's editor is
>    set to strip trailing whitespaces indiscriminately, an empty line
>    that is unchanged in the patch would become completely empty
>    (instead of a line with a sole SP on it).  The code introduced in
>    Git 2.17 timeframe failed to parse such a patch, but now it learned
>    to notice the situation and cope with it.
>    (merge f4d35a6b49 pw/add-p-recount later to maint).
>=20
>  * The code to try seeing if a fetch is necessary in a submodule
>    during a fetch with --recurse-submodules got confused when the path
>    to the submodule was changed in the range of commits in the
>    superproject, sometimes showing "(null)".  This has been corrected.
>=20
>  * "git submodule" did not correctly adjust core.worktree setting that
>    indicates whether/where a submodule repository has its associated
>    working tree across various state transitions, which has been
>    corrected.
>=20
>  * Bugfix for "rebase -i" corner case regression.
>    (merge a9279c6785 pw/rebase-i-keep-reword-after-conflict later to main=
t).
>=20
>  * Recently added "--base" option to "git format-patch" command did
>    not correctly generate prereq patch ids.
>    (merge 15b76c1fb3 xy/format-patch-prereq-patch-id-fix later to maint).
>=20
>  * POSIX portability fix in Makefile to fix a glitch introduced a few
>    releases ago.
>    (merge 6600054e9b dj/runtime-prefix later to maint).
>=20
>  * "git filter-branch" when used with the "--state-branch" option
>    still attempted to rewrite the commits whose filtered result is
>    known from the previous attempt (which is recorded on the state
>    branch); the command has been corrected not to waste cycles doing
>    so.
>    (merge 709cfe848a mb/filter-branch-optim later to maint).
>=20
>  * Clarify that setting core.ignoreCase to deviate from reality would
>    not turn a case-incapable filesystem into a case-capable one.
>    (merge 48294b512a ms/core-icase-doc later to maint).
>=20
>  * "fsck.skipList" did not prevent a blob object listed there from
>    being inspected for is contents (e.g. we recently started to
>    inspect the contents of ".gitmodules" for certain malicious
>    patterns), which has been corrected.
>    (merge fb16287719 rj/submodule-fsck-skip later to maint).
>=20
>  * "git checkout --recurse-submodules another-branch" did not report
>    in which submodule it failed to update the working tree, which
>    resulted in an unhelpful error message.
>    (merge ba95d4e4bd sb/submodule-move-head-error-msg later to maint).
>=20
>  * "git rebase" behaved slightly differently depending on which one of
>    the three backends gets used; this has been documented and an
>    effort to make them more uniform has begun.
>    (merge b00bf1c9a8 en/rebase-consistency later to maint).
>=20
>  * The "--ignore-case" option of "git for-each-ref" (and its friends)
>    did not work correctly, which has been fixed.
>    (merge e674eb2528 jk/for-each-ref-icase later to maint).
>=20
>  * "git fetch" failed to correctly validate the set of objects it
>    received when making a shallow history deeper, which has been
>    corrected.
>    (merge cf1e7c0770 jt/connectivity-check-after-unshallow later to maint=
).
>=20
>  * Partial clone support of "git clone" has been updated to correctly
>    validate the objects it receives from the other side.  The server
>    side has been corrected to send objects that are directly
>    requested, even if they may match the filtering criteria (e.g. when
>    doing a "lazy blob" partial clone).
>    (merge a7e67c11b8 jt/partial-clone-fsck-connectivity later to maint).
>=20
>  * Handling of an empty range by "git cherry-pick" was inconsistent
>    depending on how the range ended up to be empty, which has been
>    corrected.
>    (merge c5e358d073 jk/empty-pick-fix later to maint).
>=20
>  * "git reset --merge" (hence "git merge ---abort") and "git reset --hard=
"
>    had trouble working correctly in a sparsely checked out working
>    tree after a conflict, which has been corrected.
>    (merge b33fdfc34c mk/merge-in-sparse-checkout later to maint).
>=20
>  * Correct a broken use of "VAR=3DVAL shell_func" in a test.
>    (merge 650161a277 jc/t3404-one-shot-export-fix later to maint).
>=20
>  * "git rev-parse ':/substring'" did not consider the history leading
>    only to HEAD when looking for a commit with the given substring,
>    when the HEAD is detached.  This has been fixed.
>    (merge 6b3351e799 wc/find-commit-with-pattern-on-detached-head later t=
o maint).
>=20
>  * Build doc update for Windows.
>    (merge ede8d89bb1 nd/command-list later to maint).
>=20
>  * core.commentchar is now honored when preparing the list of commits
>    to replay in "rebase -i".
>=20
>  * "git pull --rebase" on a corrupt HEAD caused a segfault.  In
>    general we substitute an empty tree object when running the in-core
>    equivalent of the diff-index command, and the codepath has been
>    corrected to do so as well to fix this issue.
>    (merge 3506dc9445 jk/has-uncommitted-changes-fix later to maint).
>=20
>  * httpd tests saw occasional breakage due to the way its access log
>    gets inspected by the tests, which has been updated to make them
>    less flaky.
>    (merge e8b3b2e275 sg/httpd-test-unflake later to maint).
>=20
>  * Tests to cover more D/F conflict cases have been added for
>    merge-recursive.
>=20
>  * "git gc --auto" opens file descriptors for the packfiles before
>    spawning "git repack/prune", which would upset Windows that does
>    not want a process to work on a file that is open by another
>    process.  The issue has been worked around.
>    (merge 12e73a3ce4 kg/gc-auto-windows-workaround later to maint).
>=20
>  * The recursive merge strategy did not properly ensure there was no
>    change between HEAD and the index before performing its operation,
>    which has been corrected.
>    (merge 55f39cf755 en/dirty-merge-fixes later to maint).
>=20
>  * "git rebase" started exporting GIT_DIR environment variable and
>    exposing it to hook scripts when part of it got rewritten in C.
>    Instead of matching the old scripted Porcelains' behaviour,
>    compensate by also exporting GIT_WORK_TREE environment as well to
>    lessen the damage.  This can harm existing hooks that want to
>    operate on different repository, but the current behaviour is
>    already broken for them anyway.
>    (merge ab5e67d751 bc/sequencer-export-work-tree-as-well later to maint=
).
>=20
>  * "git send-email" when using in a batched mode that limits the
>    number of messages sent in a single SMTP session lost the contents
>    of the variable used to choose between tls/ssl, unable to send the
>    second and later batches, which has been fixed.
>    (merge 636f3d7ac5 jm/send-email-tls-auth-on-batch later to maint).
>=20
>  * The lazy clone support had a few places where missing but promised
>    objects were not correctly tolerated, which have been fixed.
>=20
>  * One of the "diff --color-moved" mode "dimmed_zebra" that was named
>    in an unusual way has been deprecated and replaced by
>    "dimmed-zebra".
>    (merge e3f2f5f9cd es/diff-color-moved-fix later to maint).
>=20
>  * The wire-protocol v2 relies on the client to send "ref prefixes" to
>    limit the bandwidth spent on the initial ref advertisement.  "git
>    clone" when learned to speak v2 forgot to do so, which has been
>    corrected.
>    (merge 402c47d939 bw/clone-ref-prefixes later to maint).
>=20
>  * "git diff --histogram" had a bad memory usage pattern, which has
>    been rearranged to reduce the peak usage.
>    (merge 79cb2ebb92 sb/histogram-less-memory later to maint).
>=20
>  * Code clean-up to use size_t/ssize_t when they are the right type.
>    (merge 7726d360b5 jk/size-t later to maint).
>=20
>  * The wire-protocol v2 relies on the client to send "ref prefixes" to
>    limit the bandwidth spent on the initial ref advertisement.  "git
>    fetch $remote branch:branch" that asks tags that point into the
>    history leading to the "branch" automatically followed sent to
>    narrow prefix and broke the tag following, which has been fixed.
>    (merge 2b554353a5 jt/tag-following-with-proto-v2-fix later to maint).
>=20
>  * When the sparse checkout feature is in use, "git cherry-pick" and
>    other mergy operations lost the skip_worktree bit when a path that
>    is excluded from checkout requires content level merge, which is
>    resolved as the same as the HEAD version, without materializing the
>    merge result in the working tree, which made the path appear as
>    deleted.  This has been corrected by preserving the skip_worktree
>    bit (and not materializing the file in the working tree).
>    (merge 2b75fb601c en/merge-recursive-skip-fix later to maint).
>=20
>  * The "author-script" file "git rebase -i" creates got broken when
>    we started to move the command away from shell script, which is
>    getting fixed now.
>    (merge 5522bbac20 es/rebase-i-author-script-fix later to maint).
>=20
>  * The automatic tree-matching in "git merge -s subtree" was broken 5
>    years ago and nobody has noticed since then, which is now fixed.
>    (merge 2ec4150713 jk/merge-subtree-heuristics later to maint).
>=20
>  * "git fetch $there refs/heads/s" ought to fetch the tip of the
>    branch 's', but when "refs/heads/refs/heads/s", i.e. a branch whose
>    name is "refs/heads/s" exists at the same time, fetched that one
>    instead by mistake.  This has been corrected to honor the usual
>    disambiguation rules for abbreviated refnames.
>    (merge 60650a48c0 jt/refspec-dwim-precedence-fix later to maint).
>=20
>  * Futureproofing a helper function that can easily be misused.
>    (merge 65bb21e77e es/want-color-fd-defensive later to maint).
>=20
>  * The http-backend (used for smart-http transport) used to slurp the
>    whole input until EOF, without paying attention to CONTENT_LENGTH
>    that is supplied in the environment and instead expecting the Web
>    server to close the input stream.  This has been fixed.
>    (merge eebfe40962 mk/http-backend-content-length later to maint).
>=20
>  * "git merge --abort" etc. did not clean things up properly when
>    there were conflicted entries in the index in certain order that
>    are involved in D/F conflicts.  This has been corrected.
>    (merge ad3762042a en/abort-df-conflict-fixes later to maint).
>=20
>  * "git diff --indent-heuristic" had a bad corner case performance.
>    (merge 301ef85401 sb/indent-heuristic-optim later to maint).
>=20
>  * The "--exec" option to "git rebase --rebase-merges" placed the exec
>    commands at wrong places, which has been corrected.
>=20
>  * "git verify-tag" and "git verify-commit" have been taught to use
>    the exit status of underlying "gpg --verify" to signal bad or
>    untrusted signature they found.
>    (merge 4e5dc9ca17 jc/gpg-status later to maint).
>=20
>  * "git mergetool" stopped and gave an extra prompt to continue after
>    the last path has been handled, which did not make much sense.
>    (merge d651a54b8a ng/mergetool-lose-final-prompt later to maint).
>=20
>  * Among the three codepaths we use O_APPEND to open a file for
>    appending, one used for writing GIT_TRACE output requires O_APPEND
>    implementation that behaves sensibly when multiple processes are
>    writing to the same file.  POSIX emulation used in the Windows port
>    has been updated to improve in this area.
>    (merge d641097589 js/mingw-o-append later to maint).
>=20
>  * "git pull --rebase -v" in a repository with a submodule barfed as
>    an intermediate process did not understand what "-v(erbose)" flag
>    meant, which has been fixed.
>    (merge e84c3cf3dc sb/pull-rebase-submodule later to maint).
>=20
>  * Recent update to "git config" broke updating variable in a
>    subsection, which has been corrected.
>    (merge bff7df7a87 sb/config-write-fix later to maint).
>=20
>  * When "git rebase -i" is told to squash two or more commits into
>    one, it labeled the log message for each commit with its number.
>    It correctly called the first one "1st commit", but the next one
>    was "commit #1", which was off-by-one.  This has been corrected.
>    (merge dd2e36ebac pw/rebase-i-squash-number-fix later to maint).
>=20
>  * "git rebase -i", when a 'merge <branch>' insn in its todo list
>    fails, segfaulted, which has been (minimally) corrected.
>    (merge bc9238bb09 pw/rebase-i-merge-segv-fix later to maint).
>=20
>  * "git cherry-pick --quit" failed to remove CHERRY_PICK_HEAD even
>    though we won't be in a cherry-pick session after it returns, which
>    has been corrected.
>    (merge 3e7dd99208 nd/cherry-pick-quit-fix later to maint).
>=20
>  * In a recent update in 2.18 era, "git pack-objects" started
>    producing a larger than necessary packfiles by missing
>    opportunities to use large deltas.  This has been corrected.
>=20
>  * The meaning of the possible values the "core.checkStat"
>    configuration variable can take were not adequately documented,
>    which has been fixed.
>    (merge 9bf5d4c4e2 nd/config-core-checkstat-doc later to maint).
>=20
>  * Code cleanup, docfix, build fix, etc.
>    (merge aee9be2ebe sg/update-ref-stdin-cleanup later to maint).
>    (merge 037714252f jc/clean-after-sanity-tests later to maint).
>    (merge 5b26c3c941 en/merge-recursive-cleanup later to maint).
>    (merge 0dcbc0392e bw/config-refer-to-gitsubmodules-doc later to maint)=
=2E
>    (merge bb4d000e87 bw/protocol-v2 later to maint).
>    (merge 928f0ab4ba vs/typofixes later to maint).
>    (merge d7f590be84 en/rebase-i-microfixes later to maint).
>    (merge 81d395cc85 js/rebase-recreate-merge later to maint).
>    (merge 51d1863168 tz/exclude-doc-smallfixes later to maint).
>    (merge a9aa3c0927 ds/commit-graph later to maint).
>    (merge 5cf8e06474 js/enhanced-version-info later to maint).
>    (merge 6aaded5509 tb/config-default later to maint).
>    (merge 022d2ac1f3 sb/blame-color later to maint).
>    (merge 5a06a20e0c bp/test-drop-caches-for-windows later to maint).
>    (merge dd61cc1c2e jk/ui-color-always-to-auto later to maint).
>    (merge 1e83b9bfdd sb/trailers-docfix later to maint).
>    (merge ab29f1b329 sg/fast-import-dump-refs-on-checkpoint-fix later to =
maint).
>    (merge 6a8ad880f0 jn/subtree-test-fixes later to maint).
>    (merge ffbd51cc60 nd/pack-objects-threading-doc later to maint).
>    (merge e9dac7be60 es/mw-to-git-chain-fix later to maint).
>    (merge fe583c6c7a rs/remote-mv-leakfix later to maint).
>    (merge 69885ab015 en/t3031-title-fix later to maint).
>    (merge 8578037bed nd/config-blame-sort later to maint).
>    (merge 8ad169c4ba hn/config-in-code-comment later to maint).
>    (merge b7446fcfdf ar/t4150-am-scissors-test-fix later to maint).
>    (merge a8132410ee js/typofixes later to maint).
>    (merge 388d0ff6e5 en/update-index-doc later to maint).
>    (merge e05aa688dd jc/update-index-doc later to maint).
>    (merge 10c600172c sg/t5310-empty-input-fix later to maint).
>    (merge 5641eb9465 jh/partial-clone-doc later to maint).
>    (merge 2711b1ad5e ab/submodule-relative-url-tests later to maint).
>    (merge ce528de023 ab/unconditional-free-and-null later to maint).
>    (merge bbc072f5d8 rs/opt-updates later to maint).
>    (merge 69d846f053 jk/use-compat-util-in-test-tool later to maint).
>    (merge 1820703045 js/larger-timestamps later to maint).
>    (merge c8b35b95e1 sg/t4051-fix later to maint).
>    (merge 30612cb670 sg/t0020-conversion-fix later to maint).
>    (merge 15da753709 sg/t7501-thinkofix later to maint).
>    (merge 79b04f9b60 sg/t3903-missing-fix later to maint).
>    (merge 2745817028 sg/t3420-autostash-fix later to maint).
>    (merge 7afb0d6777 sg/test-rebase-editor-fix later to maint).
>=20
> --=20
> You received this message because you are subscribed to the Google Groups=
 "git-packagers" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to git-packagers+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/git-packagers/xmqqftyyfecy.fsf%40gitster-ct.c.googlers.com.
> For more options, visit https://groups.google.com/d/optout.
>=20
--8323328-2063497472-1535554226=:71--
