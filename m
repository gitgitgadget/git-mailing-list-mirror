Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3481F404
	for <e@80x24.org>; Wed, 21 Mar 2018 12:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCUMcq (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 08:32:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:50025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751688AbeCUMco (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 08:32:44 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mgc0l-1fCZXZ1aaN-00O25Z; Wed, 21
 Mar 2018 13:32:42 +0100
Date:   Wed, 21 Mar 2018 13:32:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [GSoC] Regarding "Convert scripts to builtins"
In-Reply-To: <CADzBBBb0KDVJiX2WSNW=vC6b6paWoK=5XrnZNAY+pwpcu-t9JA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803211242190.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CADzBBBb0KDVJiX2WSNW=vC6b6paWoK=5XrnZNAY+pwpcu-t9JA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NTo6jFIQmDtrmbiU8yKcOJrlDqy5SaSR4S/GmCUpqNzwibPHRmh
 S/NKvlhAu+1LX6xJxKB/NAx3iDDM3ZSzlfPHu6IUkHZ2ww29e7Wnpqmx8k62CBzTla0LAoG
 eYHBiFrSkuJJPyM98Y174BBLKmh5RLXlCB0bZdkHapsv1D7QSbuIB0MQJrQgKHsOGCxhFAc
 m3InLB7dZSZxg1l5KtNJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:942N4R+spqU=:gocFVDhPVCnh0aD2DcGmRT
 gpP38eTUg4wmMfliJp/XTje7nmQzFypIqL5fbkP/a0aLsSjrYmd/nhIirNYxaDBy2RR24oLBo
 HOXqma1ACMZKyVS+TVxCSxTj7TvM+tjXuIAqtJKG8OxzQyCgW7Tm4qfsdKmboBJkzN/n6tSAC
 9fZjXnVoLAHQ2RoBPlJGv3x38FCY6nMXI3jfAviAQgn5iXe7S1uB2JyjULSds3/qXDA7cq84V
 i5Foej8TfkGVNknDw7sjHfOPav98oS3QeCC7cBH6zmVk++cSTCNbUYVNCdeQTLXXBSEuRjTVd
 3ASug/cRGgWAZJvfrme3yf5aR51otTwG9p7WzRSIBF/lHCeZO9efGHjQYCwzWCCVuqGPmPcw4
 UGTOQ216sbhjNJdkmyUUpcJa9Mv18Y8X1gJU0Kf/W5jhEcNdZYQWVZ1fd5dGwbWAOYkQfpISU
 Lr7XHiaVrVC2PALTGr0c9jAYH8nxLM1YNU+W0J6W69+XF+0YwuWSX1Xl/pddtFKRqcdq5RzTt
 KqgTIfxyU1lZ0sfEUVz8Ga8rqKkdXwVpHVMlQgVrAA9KJbpXOKP3jRwqsg4l71EZGBfWcpImZ
 zolQxU2HCeINGjNzNfdxRoQHaa1B5rjEP9/T9BdWYgJJ0LM1Q2Y5J/zX2/CmeALmK7xq0pST0
 or/6lhpFowM41hk9m8UM34bv1QxHpflp5xQazqBrJtbWgPpituA1dmwINbFRdO+lS7M5in7ga
 zDYt7qvUnTCJzLIF/+be2PAs4XjBj1+Tla6u9rhQLU/q3WPjca90jMT0tyYxAw2H0E0x5Mcin
 iPo/mHWAkT3Pg3IcuJzi4Zbe5QGSsD0xXdtWomKAu9iIF+x7qQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Mon, 19 Mar 2018, Paul Sebastian Ungureanu wrote:

> I am interested in the "Convert scripts to builtins" project. I have
> recently started to analyze it better and see exactly what it entails
> and a few questions came to my mind.

Great!

> First of all, I find it difficult to pick which scripts would benefit
> the most by being rewritten.

Which ones do you use, personally? I'd go by that measure if I were you.

Oh, and if you are not really familiar with Perl, you may want to stay
away from those scripts. Perl was jokingly labeled a "write-only"
programming language in my presence, and when I see some of my own Perl
code, I would agree at least partially.

> I am thinking of git bisect, git stash and git rebase since these are
> maybe some of the most popular commands of Git. However, on the other
> side, scripts like git-rebase--interactive.sh and git-bisect.sh are also
> subject of other GSoC projects. Should I steer away from these projects
> or can I consider them?

I second Christian's suggestion: just apply for a couple projects you
would like to work on. If there really should be a conflict with another
strong proposal, we can always work something out.

> Secondly, what is too little or too much?

Judging by past GSoC's, even a moderately-sized script like git-bisect.sh
is too much in one go. Break it down into smaller pieces, start by adding
a --helper builtin (or continue by using one like git-bisect--helper), add
things incrementally.

If you get the proposed part done faster, I am sure you'll find tons of
other things to do ;-)

Now to your list of scripts. I reordered them so that I could group the
list into logical chunks, and then ordered them by what would be my
personal priority (most important scripts first).

>  * git/git-rebase--am.sh
>  * git/git-rebase--merge.sh

These are pretty interesting, and also pretty small. They would be *prime*
candidates for turning into builtins, methinks.

As we already have a builtin rebase--helper, that would be a natural way
to go: if you can analyze those scripts and figure out a natural
progression of incremental steps to convert them (see e.g.
https://github.com/git/git/compare/4e7524e012f...c44a4c650c which is how I
moved some parts of git-rebase--interactive.sh into the rebase--helper:
starting with the code generating the todo list, continuing with
transform_todo_ids, then check_commit_sha, skip_unnecessary_picks and
finally rearrange_squash), a very smooth timeline should fall right out of
that analysis.

One slight complication might be the fact that rebase--helper is really
only catering to rebase -i so far. So `rebase--helper --continue` assumes
that it should continue an interactive rebase. This assumption would
have to be shunned, by adding a function that determines which type of
rebase (if any) is currently in progress, and using that to figure out
what function to call to handle the --continue.

>  * git/git-rebase.sh

This script is a bit larger than rebase--am and rebase--merge combined,
but the biggest reason *not* to start with it is: git-rebase.sh is just an
orchestrator of the git-rebase--* scripts, doing little more than
command-line parsing and then handing off to the respective "backends".

Consequently, I would consider it to make most sense to convert the
rebase--* scripts *first*, and only when that is done, convert git-rebase
(renaming rebase--helper to rebase).

Note! There is one exception, and it is not even a full script. As
everybody knows who follows my patch series on this here mailing list, I
consider --preserve-merges one of my stupidest design mistakes ever. To
undo this (or at least to alleviate the damage I caused), I already
submitted a patch series to introduce a superseding option:
--recreate-merges. This patch series is on hold due to the -rc phase of
v2.17 and will be kicked back into action after v2.17.0 final is out. As
it is my hope that --preserve-merges can be deprecated in favor of
--recreate-merges (and eventually even phased out of Git), I would be
totally cool with git-rebase--preserve-merges.sh being factored out of
git-rebase--interactive.sh before converting the latter to pure C, and
leaving the --preserve-merges script alone until the time when it is put
to rest.

(While I was sleeping, leaving this mail unfinished, to be completed and
sent today, a patch series was sent to the mailing list that seems to
perform this refactoring of --preserve-merges into its own script.)

>  * git/git-add--interactive.perl

I personally would *love* to see this converted. But it is a huge task,
likely too big for a single GSoC project. But if you look at the code and
figure out a natural way to break this project down into smaller,
incremental conversions, that would be a way to go.

>  * git/git-bisect.sh -- there is a project about this
>  * git/git-rebase--interactive.sh -- there is a project about this
>  * git/git-submodule.sh -- there was a project about this

Indeed, there are projects about this, although the rebase -i effort is
pushed forward by non-GSoC developers, while the bisect/submodule effort
is/was mainly backed by GSoC students.

As Christian suggested: either propose something else, or talk to the
people who touched these projects last, to coordinate.

>  * git/git-stash.sh

There have been two efforts about this:

https://github.com/git-for-windows/git/pull/508

and

https://public-inbox.org/git/20171110231314.30711-1-joel@teichroeb.net/

Both have died down, and I feel really bad about that because I wanted to
make time to help, and failed.

Nevertheless, they provide a huge head start into converting stash into a
builtin.

Having said that, I feel that there are still current developments going
on that would possibly interfere with the project to convert stash to C.

>  * git/git-merge-octopus.sh
>  * git/git-merge-resolve.sh

These merge strategies seem to be used not all that much, at least I never
heard about speed issues on Windows ;-)

Therefore it is my impression that the effort to convert scripts to
portable C is probably better spent elsewhere.

On the other hand, they are really small, and should be really quick to
convert.

>  * git/git-merge-one-file.sh

Having this as a builtin would not really matter right now, because there
is a design problem in the only two callers: both `git merge-octopus` and
`git merge-resolve` call `git-merge-one-file` in the *dashed* form, i.e.
not as a subcommand of `git`.

The reason is that the `git merge-index` command expects a *merge program*
as command-line argument, not a Git builtin.

On the other hand, this script could be converted into pure C (say, as
merge-one-file.c in libgit.a), then used in merge-index *directly* (i.e.
without spawning anything) when the command-line argument is
`git-merge-one-file`. And then that function could be also used in a new
builtin merge-one-file. A nice three-commit progression.

While t7605-merge-resolve.sh is not super-extensive, I would wager a bet
that it is extensive enough to help this project.

>  * git/git-filter-branch.sh

The `filter-branch` script is not used all that often, as far as I can
tell. If there is ever interest in a faster/more robust version of that
command (by converting it to C), I highly recommend looking at the
rewrite-commits patch series posted a long time ago:

https://public-inbox.org/git/11842671631744-git-send-email-skimo@liacs.nl/

It should be relatively straight-forward to rebase that patch series, and
then to modify it to be command-line compatible to filter-branch.

>  * git/git-difftool--helper.sh
>  * git/git-mergetool--lib.sh
>  * git/git-mergetool.sh

IIRC from my difftool work, the difftool--helper is used also from
mergetool, so logically these belong together.

From my experience on the Git mailing list, I would expect a lot of
pushback here because it is really easy to add/modify the mergetool script
in order to add new helpers, and that would be a lot less easy in a
builtin.

We would have to design a flexible-enough config way to add/modify
mergetool backends to increase the chances that this conversion would be
accepted.

>  * git/git-web--browse.sh

Likewise, this one benefits from being easily modified. It *is* annoying,
of course, to wait for a second or two to have a web page opened, in
particular on Windows, where the help format is HTML.

But probably not worth picking a battle over.

>  * git/git-instaweb.sh

This script tries to set up a GitWeb server as quickly and as painlessly
as possible, on a developer's machine. It does have quite a hefty
requirement in that a web server software (such as Apache) needs to be
installed. It does support a couple other web server software, none of
which is typically installed e.g. on a Windows machine.

Plus, this script is even less useful right now because it does not even
offer cloning/pushing via http-backend.

In my mind, this script is not worth converting. If I were maintaining
Git, I would probably deprecate it and remove it in two or four major
versions.

>  * git/git-archimport.perl
>  * git/git-cvsexportcommit.perl
>  * git/git-cvsimport.perl
>  * git/git-cvsserver.perl
>  * git/git-quiltimport.sh
>  * git/git-svn.perl

These are integrations with other SCM software that may not be all that
prevalent anymore. In particular, the CVS business seems to have died
down. I have not heard of any Arch user using archimport, either.

Subversion is still strong, though, but converting git-svn would be a
project that even I would shy away from: it is just too big.

Oh, and I notice you forgot git-p4.py ;-)

>  * git/git-request-pull.sh
>  * git/git-send-email.perl

If I understand correctly, and I am rather certain that I do, these Git
commands are included in Git mainly for the benefit of the Linux project.

The `git send-email` script turned out to be useful *also* when working on
the Git, the Cygwin and the BusyBox mailing lists.

I am not sure that they serve any greater purpose, so in my opinion they
can stay scripts forever. The `send-email` script in particular would be
quite involved to convert due to the many, many idiosyncracies with all of
the possible options you have via (E)SMTP.

>  * git/git-remote-testgit.sh

This one is completely pointless to convert, as it is only intended to be
used in Git's own test suite.

> I look forward to hearing from you. I will also submit a draft of my
> proposal soon enough.

Soon enough ;-)

I look forward to it!

Ciao,
Johannes
