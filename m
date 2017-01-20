Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8377120756
	for <e@80x24.org>; Fri, 20 Jan 2017 15:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbdATPVQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 10:21:16 -0500
Received: from mout.gmx.net ([212.227.17.21]:62848 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751962AbdATPVO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 10:21:14 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPlMc-1cYSbs1glG-00548R; Fri, 20
 Jan 2017 16:21:02 +0100
Date:   Fri, 20 Jan 2017 16:21:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/TOY] Shortcuts to quickly refer to a commit name with
 keyboard
In-Reply-To: <CACsJy8C0SFsTNTB=R8zLLvnqkPofP0VQWPUR9pguT-n2Y+Tp1w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701201501190.3469@virtualbox>
References: <20170120102249.15572-1-pclouds@gmail.com> <alpine.DEB.2.20.1701201138520.3469@virtualbox> <CACsJy8C0SFsTNTB=R8zLLvnqkPofP0VQWPUR9pguT-n2Y+Tp1w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.20.1701201526441.3469@virtualbox>
X-Provags-ID: V03:K0:kYNKEV7cD6yKiyLSMtzijJjYXp2+RqdD+xiUdSn/cEZXe0ilpJd
 tagg5BCmr0LQzM8WsW0i3r7xN89i9UdPoxuGnpMqCScbRXfXs3VbkbCuQ04gQxyup2rEnZV
 CBNv4aTMK69SGW/eMv+gnjmpqtersvlDCYq8iDorpeIHtOqPLkZdrd4jgwbQyjjwLS6VHwk
 pZxc2HbFIe5ADReQcZ3Yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wLJkgxxeb+A=:XyGWkVOpavCEB51/GnPkn8
 zxbtmD5MyNIZJkK1K+l3HuDyfx/XShywosm23/3AbtLb6/iMhKlZ71wOyGSOr7kwxSh6Orjis
 Wnybi1m0iChM4gRpcgplGXoHbCLf+C4nh/f5nHwcNvyAVb7sS7Em1njA85V7kcHQf5z8YCD+W
 3lvjPLEPSNkF46p96ONUCMDyxuemUpQLVwsfxXdUqvbBniIvqvnPCsC1rB4b/whgKjVvQaU4y
 H7h3EE1sNFYi/SLDUki3f8Mx7/BVsPEQWcr7U3XCKbu2+H/Xqe4qMDb/Iff9/UezlQItFxj2q
 1uOMjX3o2HMfkOEMJ15lzaaOuTXM1wY65J3qWFYd2UIaDNmBXmPwzMGolp3zCCOrfInCpbcpo
 1QLs3OmqP1rdChWyXClGMNsPeyxmnX5X/1+BM48/gcd/CAWNHky53ONY2ap9Rj2rPJ/C0ARs7
 2MlLHs9fotzMB+mD+2fugou1jkCkhcoJiSI6XdYKqdMoAckUPG4qa4yo98U0RJpI8eatilKEL
 KCaSxavOEEfAYKfukT41/+NqS1cl98XPgz4DnsiG/Jl2qVu0DU6kbRa44vL0Vbhu74fQPUY+F
 CCvT7F72KB2je8A6XeMHUlbxqZIF8VW4zPJOSdGzgK1e3W4/l7rcH3UIB4G0UAnLPrztmWm3s
 Lu+MBInBQlnEtebCZkvmqwxxQJFqjX99toCQU+6ii6LVPLcewc0ZOhNQe5EomfhmAFIAAcf5D
 pJkoUdSEvlpKrAQZjYVFLKgWltoPxSEQQsglN9tfLcfyrlZjFuPoYeM6vv9fS+jaavux46qcd
 n6cv9U9nqQLckabRX3OpKLKTQkZ2U74UBO8xy8OWz8tuevuyM+aF3iAbSlHhEPuwWqI8rYPKu
 +wojt77aM+DbYJmmY0Cfuj5H2UYFRoPFnZmgkJk8pIR0KUt/As5QgwbEcbPGdoXK93aThD5tS
 WgmrGDvdhuDPmIUPh8popsn4YB87Pqz9lOSoFaiugdw8ySVNEaZK9/RvquHlFD87J/9R1MhTt
 45klXd0wQrFzvjnGOdRo0fI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Fri, 20 Jan 2017, Duy Nguyen wrote:

> On Fri, Jan 20, 2017 at 5:46 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Why not introduce a flag to "git log" that shows a keyboard-friendly name
> > similar to what `git name-rev` would have said, except that the name would
> > be generated using the name(s) specified on the command-line?
> >
> > Example:
> >
> >         git log 8923d2d0 upstream/pu
> >
> >         commit 8923d2d00192ceb1107078484cccf537cb51c1b5 (8923d2d0)
> >         ...
> >         commit 9f500d6cf5eaa49391d6deca85fc864e5bd23415 (8923d2d0^)
> >         ...
> >         commit f79c24a291a58845b08cfec7573e22cc153693e1 (8923d2d0~2)
> >         ...
> >         commit c921c5bb63baaa16dc760de9549da55c8c89dc9c (upstream/pu)
> >         ...
> >         commit 16793ba6b6333ba0cdee1adb53d979c3fbdb17bc (upstream/pu^)
> >         ...
> >
> > Granted, this is still a little more cumbersome to type than @h1, but
> > then, you can skip those round-robin games as well as the possibly
> > backwards-incompatible extension of the rev syntax.
> 
> I mentioned name-rev a few paragraphs down.

Okay, then.

> No, I want the sweet and short @h1 (or something like that). name-rev
> does not qualify.

I am afraid that you have to go back to the drawing board, then, to come
up with a backwards-compatible syntax that is as equally short and sweet
as @h1.

And you will probably also have to come up with a strategy for
implementing "transient refs", because that is exactly what you are doing
here. After all, you need to ensure that @h1 still works correctly (i.e.
without scary warnings) when the corresponding ref has been removed and an
aggressive garbage collection was completed.

And there are other concerns to be considered, not only the
backwards-compatibility. Certainly the current design will need to be
overhauled.

Just from a cursory brain-storming on my side (I even left out the
hand-waving concerns):

- this feature requires write-access. From a user's point of view, this
  should be read-only, or at least also work without write access

- the term "commit mark" is already used for something very different in
  fast-import

- the idea that running "git log --mark-commits master" twice will
  generate *different* marks is surprising (and not in a good way)

- introducing a feature to save keyboard strokes, and then requiring the
  user to type ` --mark-commits`, i.e. 15 key presses, is, uhm, funny

- the fact that these marks are per-worktree makes it a lot less useful
  than if they were per-repository

- related: there is no way to re-use these marks in different
  repositories, e.g. when helping other developers, say, in a chat room

- the fact that the first mark in every repository will be @a1 opens the
  door very wide for using that mark accidentally in the wrong repository.
  At least if I write 8923d in the git-gui repository, it will tell me
  that there is no such revision. Using @a1, it would succeed, and it
  would take me a *long* time to even realize that I am in the wrong
  directory!

And then there are the implementation issues:

- it uses symlinks. I cannot let you do that, Dave.

- using sscanf() to get the value of the first byte of a buffer? What's
  wrong with `*buf*`?

- "asdfghjk"? That is *very* limiting. The opposite of diverse. Just ask
  the French, for starters

- latest_fd is never closed, nor flushed

It sure complicates the implementation side as well as the overall design
a heck of a lot to insist on not using existing rev syntax.

> I don't feel comfortable typing 8923d2d0 without looking at the
> keyboard, and that's a lot of movement on the keyboard.

I mentioned 8923d2d0 only as an example to illustrate the difference to
name-rev.

And when you talk about movement on the keyboard, you *must* realize that
you impose your favorite keyboard layout here. On the German keyboard, for
example, the `@` sign is typed via AltGr+q. That is very cumbersome right
there.

And when you talk about speed advantages of keyboard vs mouse, it seems
that there are studies that show that keyboard is faster than mouse. For
keyboard shortcuts. Not for typing. I actually found no study comparing
the speed of typing with the speed of copy/paste, although I am sure that
they exist, and that they show pretty clearly that copy/paste is faster,
and more accurate, than typing.

But back to minimizing movement on the keyboard.

You would usually type `git log upstream/pu`, tab-completing
`upstream/pu`, right? And then you would want to refer to one particular
entry in that output, say, `upstream/pu~50^2`, right?

Right:

> upstream/pu is a bit better, but still very long (at least for me). Yes
> TAB-ing does help, but not enough. Then you'll get the dreadful "^2~1^3"
> dance.

Yes, exactly. You would use tab-completion there, too, most of the way.
Although I do not find that "^2^^3" [*1*] dreadful, I can see that some
users find it cumbersome. And then it is a little bit over the top to try
to optimize away that "^2^^3".

However, I am starting to feel like you try to use the wrong approach,
bending Git's user interface out of shape just to be able force a workflow
that avoids copy-paste or GUIs, or for that matter, advanced ref notation
such as "upstream/pu^{/worktree.remove}".

Don't get me wrong, I would love to have faster method to go between log
and prompt. But to be honest, what costs me much more of my time is
figuring out which commit and branch any given mail talks about when
reviewing, or addressing reviews. Or for that matter, finding the mail
thread discussing the patch series that the "What's cooking" mail talks
about. I guess I'd spend more time on accelerating that than on avoiding
copy/paste from `git log`'s output.

Ciao,
Johannes

Footnote *1*: Do we really have octopus merges in Git? I do not think so.
*clicketyclick*. Urgh. You are correct. I found a whopping 45 in my
repository, and I certainly did not introduce any. On a sunny note, the
last Octopus seems to be v1.7.10-rc0~9^2~9(Merge branches
zj/decimal-width, zj/term-columns and jc/diff-stat-scaler, 2012-02-24),
i.e. a couple of years old.
