Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 977D620899
	for <e@80x24.org>; Mon,  7 Aug 2017 10:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbdHGKCO (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 06:02:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:49168 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752606AbdHGKCN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 06:02:13 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lb5Tp-1dCQiA15RJ-00kgZ4; Mon, 07
 Aug 2017 12:02:11 +0200
Date:   Mon, 7 Aug 2017 12:02:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.14.0
In-Reply-To: <c532df98-b020-810a-c378-04c7dd5b0fa7@kdbg.org>
Message-ID: <alpine.DEB.2.21.1.1708071147430.4271@virtualbox>
References: <20170805230001.3232-1-johannes.schindelin@gmx.de> <c532df98-b020-810a-c378-04c7dd5b0fa7@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Wrie9k+uQPlDBwo+UWiOdvuQcGZ/400x0uPZDHo9ORIl5rIZnWU
 QVL7flj/1Durr2YTyxlWDdDT6RR6DhJ2jRUcHifsqeXRYMdH6Eh98aMi0v3oYoEKnf1CmH1
 5gw5c/ONdEdNjdejxmWVNUIVYSX2WWPt9QIaQbwFhnL+5jX2+nsKVDr1BZg3dfXyHyrf4oC
 ZkeKyAV4Z6ZQnDWzzF1og==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Jc3NXLbYS4=:xYpyAwT1om/JzypuZYylzn
 thcox3YSS65qHLZcsHKjAY+lSGrSIJ58khZUmHEO5DQIJw1U1KxORHK2Ht7zL9RQAwIc9po8W
 zpqN5SB8bpdoIQ6N8xfuQs7DMF6cK3yyV0QlKaMgAWtwB0N6DE5lbKfb/Gq/r7zsJmqOqkSKj
 +H4tBeo+mhb38zxL1Sl4xO8gjXM7rEve12IX5kSFbjgMPtLX4AIJ13mUjhLyyLgEi+TAdO9g6
 OTJ4BTG3DhstyYe3urMOqsAEkVHy+jDIECjp0ASFTVeCE0vl5Go345Jmrk6Ij2qTxZ2LyBTDV
 wjzwPDS2aPZ7VAPyB/rtiNnmsswyp/q4FObvrRjSwgLRURw5Mhe6rbOPhL90JpKAAoLwCfwdD
 w3piEkSJc3sRzq7MPmbzYYF1wYMHiju4ZhKLmwTCo1N07TlU8iOaa4dVkGmn6ODq/WGclQUTX
 kKbbbEaZYL+bnV3WeVcuXpmUGK7riD5hUtkSwdGmfWJoKNLJHWp6bbjZkuASASb4aHz+DZSt+
 4daBq5DJdxqG4JiWWinPIYosHLCG5xGsyiTR2iQ2UwZzgWawCyPOTI2WfrM5QnjkL0uwLZ8Rc
 fDZrRuD/QnUmz/RNsZjcy7LZxwqlWtQ2drToR8wylySum9vMzaOk61VCF1d60UoUav/TW+OyF
 rsOF8RXMq9aB8NCsX60LW4QxowsK0uR9ykaJw9N9fWQ+rH2WvewIrUEaPMbiwVdIySq6zn6GQ
 xaFrMqbAeWmU5yzopvudXchZ6JGshHJxdcZxJlycV3OWkrMbxO32lt1MNW7QCGoqJ85sL/k1r
 lhfvMTV1/24DXdvZrT68GT+HLSNqEDnmdxEoMxW0qhaX/3He5Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Sun, 6 Aug 2017, Johannes Sixt wrote:

> Am 06.08.2017 um 01:00 schrieb Johannes Schindelin:
> > Dear Git users,
> > 
> > It is my pleasure to announce that Git for Windows 2.14.0 is available from:
> > 
> >  https://git-for-windows.github.io/
> > 
> > Changes since Git for Windows v2.13.3 (July 13th 2017)
> 
> Thank you so much! One question, though:
> 
> >New Features
> >...
> >    * Comes with [BusyBox v1.28.0pre.15857.9480dca7c](https://github.com/
> >      git-for-windows/busybox-w32/commit/9480dca7c].
> 
> What is the implication of this addition? I guess it is not just for the
> fun of it. Does it mean that all POSIX command line tools invoked by Git
> including a POSIX shell are now routed through busybox instead of the
> MSYS2 variant?

As I wrote a little later:

* Git for Windows releases now also include an experimental [BusyBox-based
  MinGit](https://github.com/git-for-windows/git/wiki/MinGit#experimental-busybox-based-mingit).

And as I described in that Wiki entry, no, Git for Windows does not make
use of BusyBox just yet. Only the experimental version of MinGit.

It would be *awesome*, of course, to benefit from using BusyBox: size,
speed, robustness (reducing the MSYS2 dependency). But we're just not
there yet. What needs to happen before that?

- lots of testing. And I mean *lotsssss* of testing. BusyBox is by far
  less tried and tested than Bash, and BusyBox-w32 is *even less* tried
  and tested. And BusyBox-w32 *with my patches* is tried and tested only a
  little, and only by me. Before I risk getting bug reports about a
  BusyBox-based Git for Windows, I want to be a lot more certain that
  it is basically solid.

- BusyBox-w32' interactive functionality expects a Win32 Console. In Git
  Bash, we only have MSYS2's pseudo terminal, no Win32 Console. If we ever
  want to be able to execute Git's scripts via BusyBox-w32, it *needs* to
  learn about MSYS2 ptys, at least to emulate isatty() accordingly (we
  have code in Git for Windows itself to do that, of course, it's no witch
  craft, but... yet another thing to do).

- judging by the number of bugs on Git for Windows' bug tracker, there
  *are* some users out there installing their own hooks and aliases, and a
  really tiny fraction of those users seems to be really happy to have a
  full suite of GNU utilities available. BusyBox, however, does not
  support that full functionality. Therefore, switching to BusyBox would
  possibly break those setups.

Mind you, I really want to get there. And I think we will be able to get
there. By inviting testing (the BusyBox-based MinGit is a very good start,
for example). By adding an experimental option to Git for Windows'
installer to switch to BusyBox. By announcing in Git for Windows' release
notes that this will become the default at some stage ("please test your
aliases and hooks!").

Ciao,
Dscho
