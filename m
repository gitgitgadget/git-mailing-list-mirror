Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB7C20372
	for <e@80x24.org>; Thu, 12 Oct 2017 22:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757549AbdJLWxg (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 18:53:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:52807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757544AbdJLWxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 18:53:35 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MB2G8-1eARqr0D80-00A1rN; Fri, 13
 Oct 2017 00:53:33 +0200
Date:   Fri, 13 Oct 2017 00:53:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Steve Hoelzer <shoelzer@gmail.com>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        git-for-windows@googlegroups.com, git <git@vger.kernel.org>
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.14.2(2)
In-Reply-To: <CACbrTHeKw9fN6uARHsjyKZe+B839UHSqbNhgzz=0Dk8_VCZE-A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710130052520.40514@virtualbox>
References: <20171005200227.8028-1-johannes.schindelin@gmx.de> <E2CD2BA7-130B-479B-84DF-A7AFA0EBF30F@gmail.com> <CACbrTHeKw9fN6uARHsjyKZe+B839UHSqbNhgzz=0Dk8_VCZE-A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IKMRfZmDMu3K7i22YjfEAFKeLGq4qWJw4HBYlRKgKn8pvIO3tyl
 Kf7oWnz4gIWICUw8vTbvQL1UBEowSLDvd4VD6AkVkLQl/2UKunCORLlI9OkFJUbzCbd7g7c
 Fm35sFTWihpdwQBoRJ2h1HFr7KtWt0vb/5fWVi30BtUBSQPWDU2VIkfi7s1TmFWaKyCdLl5
 XkRiY8TiYuVAYklkk1UrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZOsGT4V9Nzo=:/Jia1kzwnpzRYBDghImeLU
 AexYP71zdBIn3eM8cx89AKCpkNwEJgR75JlDdTJtD4DKBDwFOHY7ub8QBXQM8LetFj+xznbuA
 LR2g9uMEbmYOYF6f25F/MYL1T4O9w8ARJUx1Kb6jkkdQg6pQzRkuTNCC8Z2+nKcsh+WmjhMAo
 5W/DOsSZGwbIPQpZuO5YJFjFQy+Chb+lkjLqTVhRFIYyqK8vhvzF90RuM+fzlenVPye4i3/aC
 Ew6hBMBGIlX/sA/G8I6H1609cQnqFUhcR6AXj68XMBzFj5poo1yfA6REJmcXtnlFj7YkOX01h
 UMcKV6zxT0lcr1mTKfZ2QFZPNIqiYF6ul80cZGQmL9AYy7XKkuLJXj/PotNgiBLwF0li8tCmp
 nw4zvyyLJFbB8CLpsUH+cbpuTBmIcDHaXvzgSuvJx1oowGCHLhbUw01kN39S0Z5KHt7mgWVH4
 4/P46bh54RaV72kEuNiFP7YazDd0UV9VYjSwx6FdEhjrbXlIdKhZcYbu3Rp2dkEWyi6woY/2D
 ILNSn66eQ5/mcVae6vsS5enZnHzuo5clt5U7/DNu3JISjVzDy0+OmB867PLjYMZWJHDbw/sAd
 COlWZ8n366z3slgzetPS6B/JbzPo3Q2A0LPDpr/kZAOpjrCcy+QNwk4tHmA9amyqAB2NDQ03K
 fAXC+Yx/eOhr2nODmI83cx+QBgE/G5tJ8jOaeVwl1PoDPjUt3yHQGVEPZ47m6hE4GWZ5cfbKI
 LXOppgGNUECxaTaOx7zStm0xdDuhsLs7gbX1oJE45ebYHNy/zdUCKz/ukvKGOLb9BzG+Loq5p
 cj6dJnRbLiUTEtG6X4/bsG1LCIx/O+mLcYv7s12g93h9dnNvGA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Steve,

On Mon, 9 Oct 2017, Steve Hoelzer wrote:

> On Thu, Oct 5, 2017 at 3:22 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
> >
> >> On 05 Oct 2017, at 22:02, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> >>
> >> Dear Git users,
> >>
> >> It is my pleasure to announce that Git for Windows 2.14.2(2) is available from:
> >>
> >>       https://git-for-windows.github.io/
> >>
> >> Changes since Git for Windows v2.14.2 (September 26th 2017)
> >>
> >> New Features
> >>
> >>  * Comes with BusyBox v1.28.0pre.16467.b4c390e17.
> >>  * Comes with Git LFS v2.3.2.
> >
> > Just a heads-up:
> > Git LFS 2.3.2 contains a bug in the `git lfs clone` and `git lfs pull` calls:
> > https://github.com/git-lfs/git-lfs/issues/2649
> >
> > I expect 2.3.3 to be out soonish.
> 
> It's out now.

Git for Windows v2.14.2(3) (including Git LFS 2.3.3) is out now, too.

Ciao,
Johannes
