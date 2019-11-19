Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD4D1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 21:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKSVaH (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 16:30:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:41415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbfKSVaH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 16:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574198999;
        bh=HQc6YwKuoLhoDyaGzB/php4tvLYlu4Xh/DUqpsDkU7o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Oe28uoJUvqCAW6DEFHNm4YLDoFuhE/D3McMHjfvBDlvOickf0HWvZV09AAxGGA1in
         9XuOcgs471FsMejIk8rIzBBBj4uLanVzcwSGj2tCdSPcpNPNrPEAHh6qn4wcSlFbbx
         2vJl3JaTZciBi5s0am13abMTj2asyQqRW0Xngj9Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKUv-1iHQ8e2iRb-00LkE6; Tue, 19
 Nov 2019 22:29:59 +0100
Date:   Tue, 19 Nov 2019 22:29:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: add avenues for getting help
In-Reply-To: <20191119184919.GM23183@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1911192227280.15956@tvgsbejvaqbjf.bet>
References: <20191115230637.76877-1-emilyshaffer@google.com> <xmqqv9rk4j1y.fsf@gitster-ct.c.googlers.com> <20191118214519.GH22855@google.com> <20191119184919.GM23183@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1859658375-1574199000=:15956"
X-Provags-ID: V03:K1:cIViRXMuh2iZtLkLzY93G0tGnPun4X3gYfLo8JXNaTlo+6U5edV
 zz7mUF7VCXR7omjUJ9i9I6hJ/ZuzzjI339dInQ9m0t5t8+H6sKjJcxdkWGRnzAScMYgRhxj
 j+uEB268JjpBcetX7I8rULWWYAXtOABnWiwAMANxVDXEh9WBMosuQhZsOaTJ9zPNxQFt4Hd
 Ks/5ryo7yxVMTvOQOLhjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N4VG/3qX7CA=:1xrhQwOG3Y8gHMTFZe7tD+
 tT3pNv99/L34VaKjmR3gGUtCXU6KdWXpzZQT062TmEYC5HdI9Mu3SneiBDoWKS5Aw6TJl6RSt
 XqnAmYuiy3VY/CVAOlXYa8vcrGIR35FVVbb4rL4rPAEO/5KmMSqJPJn7DwehhgIW1bZvsT2pb
 HDSBTIA8Mjf4E6Abx/PRAIZlfogoSbAzvg5d94JvRqyt6TsU5roihmM4lledIMfu/zJRetUaZ
 D/3qMyYLbKuVlrZWjFGbOWkU6DgqQH0BOhyJwM4XiaEwZWkZjZePZkuzK7gRgHK2YWmQCFibP
 F2eAXPQ2j/P6/4X3xYGw6yMO0y+f4HZOBXDP0yNuD4Oyn51AYSzxw1vklymTYTt+Wt5aiFMEA
 7ugTkU9Q1bx5bkvFAtfWzkNlNkDkc48evFJeN8d/g6WdNgaXQHgRTLNaCrQcOfkpf7iacbCPo
 Bi0qh7eYayLIRnd3ykjykCj27mtpxVr1y9UVZF/5YoZtVbpUKt8BFEbsIXz2Gced5cSI2WVIw
 Dz8iN/OtHYJ+gSxE6MXSY7N03HiZKgKS7lEkHS8c02HzfTka3oTyf2BB6K7IFJGs1SVclCiKL
 b9PLlZd6hyr0F5KR/ITguB97l733FtRNQpsOOx1qwBuSefQsQXiUdsX4WohYIn5B7WhxRh16m
 dMl3sFR3LTvCXq/FEy/LvNFIUlGDi/YBzFEb/d89FmZIoddOVZ5pYbh4tO5Mad3Jo5n+7LuQV
 cOdtNIEkZEiFwgZnyWT6L3t6kGMCJzn0V4UI/xXXNCxCbPRveSXDJrCtqIgExp63e/4Kc6dac
 bH4KdiXBpMPVu/NeSPGBiOhuSwd5sdysACM1WnuDGjSNvjFzIdsluC1HSCcM55MgbUWWQ6k9c
 aTvgqOQYJ0jjTCakpf+tVHRT6za+uFFsj4uP2TSX9DlBjI8KcUh5qaxpgctBRjMmVAYW4KWXw
 W1JFn69UZWibng7aEWYaaUv406JqGQNQ4JJTpuH96ZM6ZTpnWWLseGb9WemMUIQgH2BSu/5qh
 P9Y5cKtA3sl3oF600QZexrPtp5Y2ycmRSG8Oi+EGQxauxzPTpfbmMsYgS6rYskE4Av6CiX4do
 fxQduIut3f1QM7KhYNe4LEribxtDGN6RzhnTCFvi5SG/42MFfXMsoNY9VrpyGISzqAUHkfOuH
 FyBz5jsfv2WFv1AXk1uiZJAajKzFHzX15Ka4OO/81KVsLcBTzbYSwaV/6/8dEzzKSgI3TMzzT
 eT7hWa9vbQ4dHR+TXl+ShwPGsUQeGZhEWIzxmsG78p1kbmbO79ctfySB2pqc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1859658375-1574199000=:15956
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Tue, 19 Nov 2019, SZEDER G=C3=A1bor wrote:

> On Mon, Nov 18, 2019 at 01:45:19PM -0800, Emily Shaffer wrote:
>
> > I don't mind the idea of pushing folks to ask on the mentoring list
> > first. It's pretty well attended already - just now I count 16 list
> > members, a pretty significant majority of which are project veterans.
> > I have no problem suggesting newbies ask their questions, which others
> > probably had and solved before them, in a space separate from the main
> > mailing list.
> >
> > Of course if you want to encourage newbies to ask in any of these
> > three venues, weighted equally, I can change the language. But
> > suggesting the main list as a last resort was intentional.
>
> git@vger is the ultimate source of all wisdom :) and it is openly
> accessible for anyone for writing,

... except people with an @outlook.com address (all of their emails will
bounce) and people who do not know how to suppress HTML in their emails
(which I believe constitutes the vast majority)...

> reading, and searching.  Therefore these three venues cannot be weighted
> equally, but git@vger should be the explicitly preferred venue.  Only if
> the newbie has some other preferences should the other two be
> considered; e.g. if more interactive, chatty communication is preferred,
> then try #git-devel.

Ciao,
Dscho

--8323328-1859658375-1574199000=:15956--
