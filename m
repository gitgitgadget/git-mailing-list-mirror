Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B491F803
	for <e@80x24.org>; Wed,  9 Jan 2019 14:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfAIOF4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 09:05:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:56961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbfAIOF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 09:05:56 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiDrv-1h3JVh1six-00nNDr; Wed, 09
 Jan 2019 15:05:54 +0100
Date:   Wed, 9 Jan 2019 15:05:38 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Markus Wiederkehr <markus.wiederkehr@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: git rebase: retain original head?
In-Reply-To: <CA+P7+xq++4W32JT9WcasXn=Oj9W-U1eteFgpLZn8GVqeO0foog@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901091501320.41@tvgsbejvaqbjf.bet>
References: <CA+h-Bnuf6u=hkPBcxhMm06FbfkS+jtrozu+inqqmUY1cNkXrWQ@mail.gmail.com> <87va2zavu1.fsf@igel.home> <CA+h-BnvN7+ETU-vFxAGDvs0gvXUjAAhMkvTPUxoRTt2Gb4b2ow@mail.gmail.com> <CA+P7+xq++4W32JT9WcasXn=Oj9W-U1eteFgpLZn8GVqeO0foog@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YrdRyEGjxnZEa+JSeycstx/LWmX56Lc8zQ1XYrf+0iaJhh4zdJT
 HwCW/dMtiJXV3eg1T5JdjFtT7OamMhyuGawQQkAAdFfSg8bB+BaZVFEwvBWlxxG0LIaRMHU
 JCc4KQdK+TwQvm6BFRKehnkkknwtUZU+wCtohL8pGhDJTihW7+CxH969lbu+B0O1c/N8iHx
 ZbdB2AntKdEpwyTNnfW9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tyVhESyiUNo=:6j/oUqi4hLl+fi8qXAIrYi
 vtv26pbX4YVFcucMKKx53rLVFa6OvllsQAenKS7iKQwWv9kmZsWiorC+OWmlI92A712ukE/0h
 tuxdioAHpVT3z10KSt5jTw34FMGznXr/QRVmjs+J4Sz2aqYaCgRDYWLXVJmqIfVI+yHSoBRxc
 Emzt70Bq2B9z4pLqEL7Z0jNsl6YI1yy7LtQm9g82QHZCwIxcKnRradLdS7HsO/ru3p17gfL/p
 PQ7O/Gomt55g/ZdC8nrFsjQTPBhKcabY8In6wGIyAz5Ofr6Qtd2PbnJnTQ3rfsWW6Z9TKnEpi
 YRPVMONjZsYUHw8kfwYwLudlFLVMd4nphXuNRn4VMgM64UBoLJuMp5QVqZkEgRTVH8nMRmUfq
 TubDb4xK7uB4YPfJteZB0WytRjkHucNPWlL2uAePF7vAymx0TKungWIU67kbHJXDJBXnic2bw
 e2N6Won616h1wEwYp9WMZriAudh2Oe8Pw11Woj5nYeWEfPD0Iptt0Lm3xHQaNliKVqKQCWZmo
 2+j3Z7StCi64MnZuA5CA365ynKpH2XOAx4DjovGpawkN8GNjAuKCn6FgeTSRK/BmVRMnwnxtH
 L7fHNh6kAwMv6zQ2b8mwKymHDZKUZq0plVDmexZGh5c/br2T3FgBxxVuLT//QbSRKT4DXwgXm
 L1EhLyC95aBrHEx6BuCOER/Yo4XEKIS4DCziupho5Xb2FuEMVKdE7ABBuuoBj1K9UxiP7muv7
 ywi7Ld9oh7KbyGnDfc+2hZZSuuOStDV3VOwFl//CLNaZ3WRdyMtVI/4kPh9VVPPwwIi76+BTd
 kwqCbRrioC6IEFlXlqi3cKrAlxRYik1XqmZxnwbdEsf5ousL8iLOCwhMH1z4OMwCwCjy2tfjj
 5wgiw9nth1Y4gXc7KmU4oIanfBhlOdYb/IgQBSmGEKtSCQ+S+MYoQWfv5TiZSu2q3gXBGocZP
 llxFe6xge+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Tue, 8 Jan 2019, Jacob Keller wrote:

> On Tue, Jan 8, 2019 at 12:47 PM Markus Wiederkehr
> <markus.wiederkehr@gmail.com> wrote:
> >
> > On Tue, Jan 8, 2019 at 6:43 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> > >
> > > On Jan 08 2019, Markus Wiederkehr <markus.wiederkehr@gmail.com> wrote:
> > >
> > > > Would it be possible to retain this information?
> > >
> > > You could use the reflog of the current branch, where it is the second
> > > entry.
> >
> > It is not, depending on what happens in the rebase it could be any
> > entry. That's why I always have to search for the right one, which is
> > tedious.
> >
> > Example:
> >
> > $ git rebase -i root-tag
> > ... (apply one fixup)
> > $ git reflog
> > 906caf1c (HEAD -> master) HEAD@{0}: rebase -i (finish): returning to
> > refs/heads/master
> > 4906caf1c (HEAD -> master) HEAD@{1}: rebase -i (pick): qux
> > 85dab37b4 HEAD@{2}: rebase -i (pick): baz
> > 7de7420d2 HEAD@{3}: rebase -i (fixup): bar
> > 9bc0461c0 HEAD@{4}: rebase -i (start): checkout root-tag
> > a150b73ca HEAD@{5}: commit: foo
> >
> > Here I have to use HEAD@{5}.
> >
> 
> He meant using:
> 
> $ git reflog master

Indeed. That's why terse answers are often worse than no answers at all:
more often than not, they leave things unclearer than before, in the worst
case they are misleading, as was the very terse first reply. Just don't.
Too short is not beautiful.

> which only shows changes directly to the master ref, not to HEAD.
> During a git rebase operations don't modify the master ref until after
> the rebase finishes. This, of course, assumes you're on a branch.
> 
> If so, you should even be able to use master@{1} and be safe in
> assuming it always refers to what the branch was before the rebase
> started.

There are more tricks up Git's sleeves: @{1} is a shorthand for the
previous state of the current branch (if any). So after you rebase a
branch, @{1} will refer to what previously was ORIG_HEAD.

Having said that, it is an unintended regression in the built-in rebase.
Markus, could you come up with a minimal test case, preferably in the form
of a patch to t/t3415-rebase-autosquash.sh?

Thanks,
Johannes
