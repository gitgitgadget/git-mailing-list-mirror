Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196B91F600
	for <e@80x24.org>; Thu, 20 Jul 2017 12:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965425AbdGTMGq (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 08:06:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:63937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965422AbdGTMGn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 08:06:43 -0400
Received: from [192.168.0.2] ([86.56.108.44]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LtJAR-1djwpG14ix-012skw; Thu, 20
 Jul 2017 14:06:41 +0200
Subject: =?UTF-8?Q?Re:_--interactive_mode:_readline_support_=e2=8c=a8?=
 =?UTF-8?B?4qyG?=
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <55629eef-537e-e5b6-c0dc-6e3372d00b33@gmx.net>
 <CAN0heSoJVf4A=92GPwFGUL0uoqWK3eY89+uCTirVzSYHHhfwwg@mail.gmail.com>
 <59370040-020f-a5b0-fbd1-677e46d382b3@gmx.net>
 <CAN0heSqsn-XGgZFxc+kLiBPSdzrtqg6JR4_g9062F+jZmLu0Bg@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Marcel Partap <mpartap@gmx.net>
Openpgp: id=2E9589E4B9A4460B66AD9B8D65C6B04A8A39FBDA;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=mpartap@gmx.net
Message-ID: <8e7e45bb-3f5e-e4f2-f532-7a709e8e8dcd@gmx.net>
Date:   Thu, 20 Jul 2017 14:06:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSqsn-XGgZFxc+kLiBPSdzrtqg6JR4_g9062F+jZmLu0Bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:GWSbchOULZ12OffOPhhjERfz/L5kXpQ/0rx9No/jeNuCkKDiXjD
 U92ZjLrDb+5dskxRx7a3ZJx0iT88rOZ05NiEEnBycEdwbtAVFYKOx/ByseW1693i2W6CBKR
 9316panM+hxA8GMHgoZcypUfMDnEJE49/mkKxacMqo9AL7ol9iE55+EfPy21Xr2whyamXwg
 vW1oSGHSepIuBOQjkG3pA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vlSa6vgG5WM=:2ixzh/v+EeDr5QpSikRgAB
 qWnc8ANq2nIW+XrR4ymvFhBaQxIXp3QSmOU3lCbua3S1SRRP+mbDqXlY9Q90E7xBC02FR2XRW
 1E7wGH5fl7O0AYSoFbSxOk8qBcj8T/UhGSGG205sgRATe9Gt5WBOlb3mQxMZ0XScn+OnZDxI3
 ALSfp78P6wOLQkytOWUVMI4UWv7bCAHgq4gYDLWRuKTSjHDmUIS7r8EQEP2qmP+foUmoRaGa3
 jCaZ1qTpxryP/yiSfz2uk+/yL5s8CAC3wTkGktMAjXVCCV9y8cfBHlrBfnFEKaiMV6ItEITd7
 sXHCSlkENxeiGWHoZnINFDKkfdnn66zYSLS2UZIqJYUPnU0Tb1+ehTAMDuzeDj0jrh6lAo6Lk
 TENovDyqDf0ea1/etzP7i4/Z6xRXekFFxAghPQy89yO4++HUwA4ka9yxGbdHGzNngqppZ27FA
 BP0KrRbT3uddAWofKkBCsyGXY1q0idiG4pCcTHyzYRwxdiBTWrs5hzResEw7iiv/ezKfRlhcc
 L0Tr9hm+QGQsVxHn+fYngFNwU61/9AIN7ckyy8dVbCOtj4HnQCLhIaBL1GIGawg3Ef2alxecE
 IdkdLOL7kw9KDSsLPP3mfUiENiIhEjGhpFi8n5lcqZzqMe/lJRE0NZw8yEZ0ipU9S/wqctMS/
 FjHpC7XuslSMCwmu0XLbjhMTLuNaxg4XIb+E6FGEIFEArs4aXoZjegbqOyCBZDPGYNyhqPKVa
 4lkMY3SziAxQ+g37UsS7+sdTBjMePStPp3UjX0qQZBrkeRJKawUcuZe9FMHmiVlQF5VNCV9Qk
 qzs5LF+da+hYXl0WOk7pis2w7e35eDsHdZs2aAuEyEK1l/aL6M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Haha, totally slipped by me that there exist two kinds of interactive mode. Not that I haven't used both... Sorry for overlooking/being to unspecific.

#Regards/Marcel X )
