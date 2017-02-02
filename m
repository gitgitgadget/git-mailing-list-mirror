Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F381F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 10:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbdBBKiO (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 05:38:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:62246 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750774AbdBBKiN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 05:38:13 -0500
Received: from virtualbox ([217.64.244.213]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M04uG-1cL8Gl1ERI-00uKgo; Thu, 02
 Feb 2017 11:38:07 +0100
Date:   Thu, 2 Feb 2017 11:37:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] nd/worktree-move update
In-Reply-To: <CACsJy8A-tuea7W+tj6rNddtM0j_374FODjQqKsT8eHfeZ0qDZg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1702021136210.3496@virtualbox>
References: <20170202085007.21418-1-pclouds@gmail.com> <alpine.DEB.2.20.1702021015160.3496@virtualbox> <CACsJy8B3bdokeYVt6aEyZVSzO50PiQRn+0sid9mSDTZ9q-mnww@mail.gmail.com> <alpine.DEB.2.20.1702021043110.3496@virtualbox>
 <CACsJy8A-tuea7W+tj6rNddtM0j_374FODjQqKsT8eHfeZ0qDZg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1323097232-1486031883=:3496"
X-Provags-ID: V03:K0:WwzWFgM5dqKAFSprHoRfCPLnc8d1VszXNXQDW17D6rAzgnj0irC
 YLS+iMAVX4LrC4HrVTiZ7SSZOqPl1xoCLVZxEGtlJrxgpsMOVx2yCyS4sX6Gaqfs37KRY1g
 PUR1U81P3oq70+VmOqjWX7zPRqCr6cSPbP/8BCw7QWSLiXH1TumqguvfAqVpfnChDwZrRQm
 yB6gpXSSiSGkuATYe48AQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TopxEYTMo5w=:ahQT8Albt3/KMWlncr21Wh
 BlQ4Be6TdLGgZqOt2Kin3Yzlpw1dz3KIYPdP+AwH517djPD4uWkEl0xgtczUwRY+YEOKi3P/r
 djxWUutGUhXs/J6nO4thb9dEG+PuiFGd17Bho/dKBFo/DuEhG6Uk586TJZkdN+PV8r4blqz5g
 5cGvfW7bLEfxiHsoXrznQUiMMxN0nIv8HZwpwb+Aeq/NWEKhAtPkZCWQ/0K5+wpRIWlrUr2T0
 02IJEGDJVpzCnapWvqJpLCzYaS5ow5Jr1ljPdcYxcaBOW9VgaVLX3hpZE9jVF4MHxAgB1mz5K
 nNexQKe3e9Q3AAtZqLS3AjHk/gWCcVD+XDtz/DM/vN4D/rx3dFB9mHN50N9d4Xbg6brohSPlh
 VhsD5YjRTF9wNCZ/fcPFO9OsBvbBeP86KSSt1Q0nCLw/cdncovKEsbJwQUOJYLxdZ3Dx87mBg
 UIm+4VH9ch5irHNTfFh8TKamQFR3LKM6HWlAf1nhi5Su7cDsJELcDeqE8oCqgTNFas8v4f5le
 mtkCwHt9x+KfkBU379NrCQVphIsjjDTuYboRP6Etb0/+jx4uJUvF6Dri2P5ZgYiui4wow3VA6
 b2/bkKAKZr1uxbH0Qb35bm3J3g3Epv/TL8qu5w25g5C0sQi0UyVZPpkcwVXv0E7eAW6pzLYA7
 gB9j2+/iSwDFp4JZEnN2MBjIfq0eqT2Zs+I7lTspMFkFqoDNiFROo3rCCIdqz5Z49a7dHOzkB
 84x9ZrpuYNd33+jbs7IwZB3l1etz7UyLePiPDPacGdiR6Nja6iKgulYSPpL6VDnPUqDO3HshW
 DLMvU9w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1323097232-1486031883=:3496
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Thu, 2 Feb 2017, Duy Nguyen wrote:

> On Thu, Feb 2, 2017 at 4:43 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 2 Feb 2017, Duy Nguyen wrote:
> >
> >> On Thu, Feb 2, 2017 at 4:16 PM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >> >
> >> > On Thu, 2 Feb 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> >> >
> >> >> This squashes two changes from Johannes and Ramsay: [...]
> >> >
> >> > Sorry, I lost track of the worktree discussions... Could you remind
> >> > me which patch is supposed to fix my continuous reflog corruption?
> >>
> >> The corruption caused by git-gc? It's not fixed. All the changes in
> >> this series is shown here.
> >
> > Oh sorry, I meant to ask "and if it is not in this patch series, would =
you
> > mind pointing me at the patch series that has that fix?"
>=20
> You meant this one [1]? There is nothing substantial since then.
>=20
> [1] https://public-inbox.org/git/%3C20160601104519.16563-1-pclouds@gmail.=
com%3E/

I guess I mean that.

Given that this results in real data loss, it is surprising that this has
not made it even into `pu` yet!

Would you mind rebasing and re-submitting?

Thanks,
Johannes
--8323329-1323097232-1486031883=:3496--
