Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F539202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 09:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756914AbdJQJD4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 05:03:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:64629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752936AbdJQJDy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 05:03:54 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lx83d-1dAxqA348H-016hVj; Tue, 17
 Oct 2017 11:03:51 +0200
Date:   Tue, 17 Oct 2017 11:03:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Steve Hoelzer <shoelzer@gmail.com>
cc:     git-for-windows@googlegroups.com, git <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git for Windows 2.14.2(3)
In-Reply-To: <CACbrTHcwjGLudp7WQta2bs_kitquj562rLqo8LAmRF5+d_RE=Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710171101280.40514@virtualbox>
References: <20171012225339.2808-1-johannes.schindelin@gmx.de> <CACbrTHfnph8Cp9G7LrspPa4s-E2ATHWkLqj7WDPFSiLXzOSz7g@mail.gmail.com> <alpine.DEB.2.21.1.1710151710340.40514@virtualbox> <alpine.DEB.2.21.1.1710161254430.40514@virtualbox>
 <CACbrTHcwjGLudp7WQta2bs_kitquj562rLqo8LAmRF5+d_RE=Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iHQNFoq4MzOdSzVe3CUMzNomEwdr8eCAcRidvAD3GlP72FQrH4F
 hGPAXA8eheJF2FRjFRZHWFYa7YgPSa2ktNAyTu6ciZfpmXBmk3ozHck2bsvD3pwx5O8iHlF
 WJT/fUyd/+wQM086qu0Cna5gBeKL5gi6ouH70UfNE6mdW+oHxk011wfV8C4FaT/iyqN7CmW
 1ra2WQy3s+KnAr+zi7aGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VlIV+lWT2Rw=:6Yr6+4asl+ZAUwI7QCa+bO
 Wx2FPZSvSUk0BWCx7sDwF0mEIWp5HifEVeWCqOzuTTy587nsxR9gAys8pdMZpfJONopAZcsSb
 NN+PIuA8prp5J9xiDjnekG1ZcV6pAg0ozseEVDURcxx5j6/M7KD950Bl6LCn9m5joexQL6Yxx
 3JX7d81+xa8xbK5oh0L+1DEPYROMIBQpZnTy6zgGPytTMrJiGXhTcY3EIIx03d5/Z4vgDOPcd
 Kb/Y5gtngulS/GqjSZZr1DC1KihY1TUdvbmOZlZMOCfFUf/JrlvIst7MAWjFbsQmtJshxJOMb
 0mtoYz+dVgsYoNTaaUx1lNNyyWxVDUp9CsHS5nZyKNSJUBB1mFCTUrpOiN6L9zkIsjE6FWXXi
 49A5R6FHO9FX71F5VsHc5ZABjLaQ8ci1k47legtVl/lfB70n8u69hKUBnoh2ZIzB0JyE7Jr1k
 Kig9zv8LCyaqLZYlVAetEGmY+ry5QmDOMVD6UtV6TkOTTR0XQo4g+xNXdcdJwMIeHYfBlqmpf
 htsVJteDNwQjIV93cEc1R+PoQCLYdHBuSDhXJ0EgJREIq0EfoE5YplP5cQR21W6Fw5Jj3YZN/
 IUgyWEqKMjPb1yG9fCJahFRRTqbQMBBY5Py/KzqFNLTjVSA9qjmOJZUWEbhRpOwLfTVlWvlKu
 y5kdirGOlWUedRDP5UXsxAFduXSE7lInmnLHxgQe5dg78i/ebM4IurtayAUSu66GSj+k/u+A7
 PuOkIERqSDB389IEEgh9na7M9zAZlJIaH9IeeEgmiEitbispMteWxeYl/TrRaBk/1H1EQfULy
 GRl3a752qY3BqWN93GbjoSjOdUIaHL5hTBME5k9YaJUsubYYzA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Steve,

On Mon, 16 Oct 2017, Steve Hoelzer wrote:

> On Mon, Oct 16, 2017 at 5:57 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Steve,
> >
> > On Sun, 15 Oct 2017, Johannes Schindelin wrote:
> >
> >> On Fri, 13 Oct 2017, Steve Hoelzer wrote:
> >>
> >> > On Thu, Oct 12, 2017 at 5:53 PM, Johannes Schindelin
> >> > <johannes.schindelin@gmx.de> wrote:
> >> > >
> >> > > It is my pleasure to announce that Git for Windows 2.14.2(3) is
> >> > > available from:
> >> > >
> >> > >         https://git-for-windows.github.io/
> >> > >
> >> > > Changes since Git for Windows v2.14.2(2) (October 5th 2017)
> >> > >
> >> > > New Features
> >> > >
> >> > >   * Comes with Git LFS v2.3.3.
> >> >
> >> > I just ran "git update" and afterward "git version" reported
> >> > 2.14.2(3), but "git lfs version" still said 2.3.2.
> >> >
> >> > I also uninstalled/reinstalled Git for Windows and LFS is still 2.3.2.
> >>
> >> Ah bummer. I forgot to actually update it in the VM where I build the
> >> releases :-(
> >>
> >> Will work on it tomorrow.
> >
> > I'll actually use this opportunity to revamp a part of Git for Windows'
> > release engineering process to try to prevent similar things from
> > happening in the future.
> >
> > Also, cURL v7.56.1 is slated to be released in exactly one week, and I
> > have some important installer work to do this week, so I'll just defer the
> > new Git for Windows version tentatively to Monday, 23rd.
> >
> > Git LFS users can always install Git LFS v2.3.3 specifically in the
> > meantime, or use Git for Windows' snapshot versions
> > (https://wingit.blob.core.windows.net/files/index.html).
> 
> Sounds like a good plan.
> 
> I think I have successfully updated to LFS 2.3.3 by copying the new
> git-lfs.exe into C:\Program Files\Git\mingw64\bin. Is that right way
> to do it?

That should be enough in your case, as the config is already written by
the Git for Windows installer.

In general, the best way to install a new Git LFS version seems to be to
download and run the Git LFS installer:

https://github.com/git-lfs/git-lfs/releases/download/v2.3.3/git-lfs-windows-2.3.3.exe

Ciao,
Johannes
