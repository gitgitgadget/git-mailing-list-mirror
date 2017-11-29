Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543A320A40
	for <e@80x24.org>; Wed, 29 Nov 2017 12:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbdK2M2D (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 07:28:03 -0500
Received: from mout.gmx.net ([212.227.15.15]:49334 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbdK2M2B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 07:28:01 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwrPM-1fCwPn3v0i-016PJJ; Wed, 29
 Nov 2017 13:28:00 +0100
Date:   Wed, 29 Nov 2017 13:27:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
cc:     git@vger.kernel.org
Subject: Re: Antw: Re: bug deleting "unmerged" branch (2.12.3)
In-Reply-To: <5A1E6B27020000A10002916B@gwsmtp1.uni-regensburg.de>
Message-ID: <alpine.DEB.2.21.1.1711291302370.6482@virtualbox>
References: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de> <alpine.DEB.2.21.1.1711281542400.6482@virtualbox> <5A1E6B27020000A10002916B@gwsmtp1.uni-regensburg.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Gn9y+q35F5WFAEXT0qfNziBF/IIpYphBtlV73zmw6huOKQqKZnp
 FSv+/0UiKVvtHj2Cbtglb4Ueft1MFtLKpPBMddn7KFeWxGFEdrv5IZc//pvJh0ifmo5s4VH
 uOwjgYEqzAJrTLTW6NMFh/0xxcRat4Q8zrR3rRUYCiqMP5QAZw7qGu62P0wU4PmJQNmlwQV
 rGJYKYSZUluKAyt+Jcr0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DIRUg6Lsfqg=:WKhtnBOCiwEgik6eeoZJ98
 pbk94pYpLRIMT8L5XjPe7Kl1/lUeDuLM0YBIz2vsHbTi/QCdxmPFoIq3sGg/tS6nUBkhK2ULq
 PwoQ0OouRUWEt3uph/4Sd0ai+r+dO48u5nRtqdccMLaqy/h0cbZgWwX/EQ2uu6coBut2Z2IJY
 8MM1OH+G3cuecdUf1oGZI3jZSxqgFCJjHBUm4yhniA1a3bfhxP1tRwzn6/8NIz7CCXZ4W04oz
 ON0yjrU0k9tF2yIgZJS1b7WGccUA/p5CMhiP9zLn4W1o8sV5QqDuMtz1pWgyro60ZAdeq6nYM
 EO3CGmWPa/gekujF6txMkc0Oq1hMU/TXAvvAtadeBrDfeNROQ80ZblK9QYWuZwpI0St0It4HR
 SU7Z6B2C1sI4w7s+crdszH3f0CZiwB8MPDAVDvSfntdt6Qo6y2eAoMy4y2t//ffbI+Xzz0EQ6
 DVt66LyXDXmrG7mKS5iumD+crZWemVd6QwhjLhnl19Wd7sQT/DiqXSxfHEjMHBrekBreURkvD
 wA0bl2s10MelUU9nA/9p85IJ2KQLQSouUjjMlQtXFgFdOaFInCx0HFMsxfS29wO/CY7+R5ITI
 A5j/O3kJW+N0A6NS338+CW0qd2AjMh7OZEw0FcJ+0c+Q0PccbECYa14WJXeZ0YAKQpULvMXLK
 vd1P6mnrkk6rVsAJeQXlwhbbKbyWg+1KfA1frqa07g9XRzLfPHovnerYZm+/QysMyHHdVS84y
 VWutmleP26/yXv9xshSzMLxuRChiZyODJtnR8xuivzZGsURtAX1t+zhczORKNrXY+jTgfplKV
 vqK1VyABS43dL8or9IwOlEiHcWswGpWQeNkX3Dn8P/edbZVvjU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ulrich,

On Wed, 29 Nov 2017, Ulrich Windl wrote:

> > On Tue, 28 Nov 2017, Ulrich Windl wrote:
> > 
> >> During a rebase that turned out to be heavier than expected 8-( I
> >> decided to keep the old branch by creating a temporary branch name to
> >> the commit of the branch to rebase (which was still the old commit ID
> >> at that time).
> >>
> >> When done rebasing, I attached a new name to the new (rebased)
> >> branch, deleted the old name (pointing at the same rebase commit),
> >> then recreated the old branch from the temporary branch name (created
> >> to remember the commit id).
> >>
> >> When I wanted to delete the temporary branch (which is of no use
> >> now), I got a message that the branch is unmerged.
> > 
> > This is actually as designed, at least for performance reasons (it is
> > not exactly cheap to figure out whether a given commit is contained in
> > any other branch).
> > 
> >> I think if more than one branches are pointing to the same commit,
> >> one should be allowed to delete all but the last one without warning.
> >> Do you agree?
> > 
> > No, respectfully disagree, because I have found myself with branches
> > pointing to the same commit, even if the branches served different
> > purposes. I really like the current behavior where you can delete a
> > branch with `git branch -d` as long as it is contained in its upstream
> > branch.
> 
> I'm not talking about the intention of a branch, but of the state of a
> branch: If multiple branches point (not "contain") the same commit, they
> are equivalent (besides the name) at that moment.

I did a poor job of explaining myself, please let me try again. I'll give
you one concrete example:

Recently, while working on some topic, I stumbled over a bug and committed
a bug fix, then committed that and branched off a new branch to remind
myself to rebase the bug fix and contribute it.

At that point, those branches were at the same revision, but distinctly
not equivalent (except in just one, very narrow sense of the word, which I
would argue is the wrong interpretation in this context).

Sadly, I was called away at that moment to take care of something
completely different. Even if I had not been, the worktree with the first
branch would still have been at that revision for a longer time, as I had
to try out a couple of changes before I could commit.

This is just one example where the idea backfires that you can safely
delete one of two branches that happen to point at the same commit at the
same time.

I am sure that you possess vivid enough of an imagination to come up with
plenty more examples where that is the case.

> As no program can predict the future or the intentions of the user, it
> should be safe to delete the branch, because it can easily be recreated
> (from the remaining branches pointing to the same commit).

Yes, no program can predict the future (at least *accurately*).

No, it is not safe to delete that branch. Especially if you take the
current paradigm of "it is safe to delete a branch if it is up-to-date
with, or at least fast-forwardable to, its upstream branch" into account.

And no, a branch cannot easily be recreated from the remaining branches in
the future, as branches can have different reflogs (and they are lost when
deleting the branch).

> It shouldn't need a lot of computational power to find out when multiple
> branches point to the same commit.

Sure, that test can even be scripted easily by using the `git for-each-ref
--points-at=<revision>` command.

By the way, if you are still convinced that my argument is flawed and that
it should be considered safe to delete a branch if any other branch points
to the same revision, I encourage you to work on a patch to make it so.

For maximum chance of getting included, you would want to guard this
behind a new config setting, say, branch.deleteRedundantIsSafe, parse it
here:

https://github.com/git/git/blob/v2.15.1/config.c#L1260-L1288

or here:

https://github.com/git/git/blob/v2.15.1/builtin/branch.c#L78-L97

document it here:

https://github.com/git/git/blob/v2.15.1/Documentation/git-branch.txt

and here:

https://github.com/git/git/blob/v2.15.1/Documentation/config.txt#L969

and handle it here:

https://github.com/git/git/blob/v2.15.1/builtin/branch.c#L185-L288

(look for the places where `force` is used, likely just before the call to
`check_branch_commit()`).

The way you'd want it to handle is most lilkely by imitating the
`--points-at` code here:
https://github.com/git/git/blob/v2.15.1/builtin/for-each-ref.c#L42

Ciao,
Johannes
