Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EA5520372
	for <e@80x24.org>; Sun, 15 Oct 2017 15:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbdJOPLc (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 11:11:32 -0400
Received: from mout.gmx.net ([212.227.15.19]:56658 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbdJOPLb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 11:11:31 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MdKkd-1dlFz92JX9-00IVlN; Sun, 15
 Oct 2017 17:11:28 +0200
Date:   Sun, 15 Oct 2017 17:11:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Steve Hoelzer <shoelzer@gmail.com>
cc:     git-for-windows@googlegroups.com, git <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git for Windows 2.14.2(3)
In-Reply-To: <CACbrTHfnph8Cp9G7LrspPa4s-E2ATHWkLqj7WDPFSiLXzOSz7g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710151710340.40514@virtualbox>
References: <20171012225339.2808-1-johannes.schindelin@gmx.de> <CACbrTHfnph8Cp9G7LrspPa4s-E2ATHWkLqj7WDPFSiLXzOSz7g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wezLK8rT6tFXVyJl/j38q8l4oejqPP1Q4bc1/MUKBxvXZ3kkGcG
 FX4bHBIKlZrS0BPjJbTJ8zvc0cFJQQcWEej0Dm0OHZoJBXjoLgge9Z30dSfp0AwVqZsJPYc
 4wMJ3tMsfuOp/rzeOKnuynhZKEe0YbRkf4OjsiNkAahtF5nHFMfjEyIDbRQU7QW0npXmEMi
 LkUsuV0Uw98F8DEdQ+RcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B/y7FtJlCRw=:CmAepkuWdNu3F85kEcBHa0
 FKuYrJ/G++GHQOgXGviEXyhVSPFW3p/UUq8bgyZJwEC3eBRSEbzd+NT7lCZd8uAC3N3Kf/7Td
 m53ugdxGKy8JChFNzCqsmyKELU34PgFl70fQl0uqhBRdw0KQw4scm/5AeHGEjcGvMcE8PmdTA
 oYplrs7dGeqjbCcnJKA0uvSU3JYIJv8hxDmHuWDqv7A4eF2uL+EGtozgET2l6polU1xVOOApc
 0tZr0+sF9xZUK0g0OYiukWjEh6IJSnBmS5o4wxpCSqrVzi15NT4qBu5l10kjXZrES+qDsZehm
 vP2djP+SKNgznf44rs+sCZ6e42C+snNjvw1KQidsDGqimNQkyhEZFtlSLNQkYAbBgKA7bIT/0
 RWxJqQrkLMcHMllQhqUXXCICArAq3qYvzx+oo130otLgC+X6S2OQJXndAff7sJabe25AB/uI0
 PZw7JrERXqXpV+/n0TGAoWkOQDdO9BBahqMcGTOGZrKeN4xGmMb4P4GO12ml5n589+h1NsgBH
 XJWmyvwvIMa93ju+l138WcEpmgCeO8BpDTwSdvX6knp4ZX9fgksvjktRqlyCSIqgzJWbi1njx
 1mldZq6c7+Vx5w3jKazEoh5Z/bQAkpUmY+UV35lTtlmE0TrB/V4qv0f8KDPJUQNXcL/50iLCx
 nA6Ax0v9a3TxQnn2brTxT7XZQNazK/ynKe9lkV5aJA1TWs8drzhnyrtQTwrTC1tOnBkMyrrp5
 45MnSSOj3kQnZ1zX0uwl2PkiopFSaKrqKlCiFCIVuh2RZCa72KnMeDspzU06rWiVHRHtdjLKl
 yFRolGZ5omWeoZ2w6jcu+0donkYS5uhtsHQILgO3jX8zd+XdAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Steve,

On Fri, 13 Oct 2017, Steve Hoelzer wrote:

> On Thu, Oct 12, 2017 at 5:53 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> >
> > It is my pleasure to announce that Git for Windows 2.14.2(3) is available from:
> >
> >         https://git-for-windows.github.io/
> >
> > Changes since Git for Windows v2.14.2(2) (October 5th 2017)
> >
> > New Features
> >
> >   * Comes with Git LFS v2.3.3.
> 
> I just ran "git update" and afterward "git version" reported
> 2.14.2(3), but "git lfs version" still said 2.3.2.
> 
> I also uninstalled/reinstalled Git for Windows and LFS is still 2.3.2.

Ah bummer. I forgot to actually update it in the VM where I build the
releases :-(

Will work on it tomorrow.

Thanks for double-checking,
Johannes
