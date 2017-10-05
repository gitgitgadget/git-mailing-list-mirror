Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F119920281
	for <e@80x24.org>; Thu,  5 Oct 2017 13:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbdJENKj (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 09:10:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:60752 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbdJENKi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 09:10:38 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MegbQ-1dgNBA3Qvw-00OI8m; Thu, 05
 Oct 2017 15:10:32 +0200
Date:   Thu, 5 Oct 2017 15:10:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.15.0-rc0
In-Reply-To: <xmqq7ewa87fw.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710051509360.40514@virtualbox>
References: <xmqq7ewa87fw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1213969949-1507209032=:40514"
X-Provags-ID: V03:K0:lWOeMM7oBo+ZQLN5YoKcVCVF3Lx/a7oSVMGSFE4mD4nPriAk512
 SYAPDq4FDkerTGDUWunHMjHd1zORR7mjekMrBibBu6ROm+LXqgrbU5s+hSMCn4g3b9GaVS3
 Rq4afJFf1Xl5cZhAyG2zjMZW6f63hMay6UzPaxCaUEJ8YJRN5aaSSxTE5KARHpbU26/hLEj
 5zkwp1JDua2qUJ93TTEMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3nGNIXOA7yI=:bLJaGBAjlnyKT6/XNitHLA
 nWdgBlvDtGzJjhWd3f87J+QaCbYEeShnSiTO1dHQttzsvVL5TZadNArnbjysCRf5KkTjiJQ+0
 5n3iMA+EleClGzvqUOrjGJQnFJ4u4YbnrGcBMy2Z0VkQEIDltCCIFCAjvYOrZmXw0nCQxpbKA
 FzlGWInX8YZ0+QgTEhoGpaCTbdVbV2uh4FcP9lfVwXuKeQ08pMXaJi60bKm+axPc6nfk6YoS9
 ti1Ar0RAHMGKmTQyiBbUIyr/zr68tuhFittyD6lH4EonsqRk0eOGtn/7eTErMMzWmpSudLOy2
 FsqGy0WH+ZtP3EUPwkuQm73fA3kQdJU4FEr+NG9/L7XRUIaDj3CMJ5yRS72AKwjiBL6C0aS/b
 xA0Yd7UXSXiq02bZLJ8QZ530B2h104c7A41Fr1CL2dexYOaAxZP9n3a42yPhzyF4UZNx7DwIf
 qBvwg/Z8gdj3C9tES9/zXw5XA7HXpkNyvml5++SnnO8l3FHoTe4OWMAgj8TMZ8GkUnkpyfz8U
 JZfVVDHmt5IXYODlR31EfOHGYpybQiYwtzanlZ2uYcpWsWx7UbcuGAHYgg4h58ppmGpYA12p3
 uZ1BgXhdBLCzbVDIMW7oE7fsoiyKzfDT5c1QVqNltLPUYOLWcBL13zg7D9rnxYen6B7jFGNNE
 IC4dJY4sI+7MnyANrxuJBAsMFlQ7Ny3IajiVpJ5N4FeojKAD1ftkt5/Wjgr/HZ9ywLL0+bsRt
 RiGGlw9r/CRsMv1qjcmfcUP06YWt2BqPc7MnIz41wp4ZUKo9V5PqwWyIEkDy/wkt0dL2/0Cdl
 8kiUahZJkdniQ0lQWvGgBkRC5ExQsdRg24SS42P9LDK308E8Rc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1213969949-1507209032=:40514
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Thu, 5 Oct 2017, Junio C Hamano wrote:

> New contributors whose contributions weren't in v2.14.0 are as follows.
> Welcome to the Git development community!
>=20
>   Ann T Ropea, Daniel Watkins, Dimitrios Christidis, Eric Rannaud,
>   Evan Zacks, Hielke Christian Braun, Ian Campbell, Ilya Kantor,
>   Jameson Miller, Job Snijders, Joel Teichroeb, joernchen,
>   =C5=81ukasz Gryglicki, Manav Rathi, Martin =C3=85gren, Michael Forney,
>   Patryk Obara, Rene Scharfe, Ross Kabus, and Urs Thuermann.
                  ^^^^^^^^^^^^

I think we need a .mailmap entry there... I guess the difference is the =C3=
=A9
vs e.

Ciao,
Dscho
--8323329-1213969949-1507209032=:40514--
