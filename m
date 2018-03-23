Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AD831FAE2
	for <e@80x24.org>; Fri, 23 Mar 2018 09:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752341AbeCWJs4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 05:48:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:57203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751839AbeCWJsz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 05:48:55 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZfZi-1fITpT0RWY-00LY4e; Fri, 23
 Mar 2018 10:48:53 +0100
Date:   Fri, 23 Mar 2018 10:48:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Wink Saville <wink@saville.com>
cc:     Git List <git@vger.kernel.org>,
        Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [GSoC] Regarding "Convert scripts to builtins"
In-Reply-To: <CAKk8isqH4uRdf4dXKpxMkNoJqpabztWNPgELqtLbSupR+_C=SA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803231048110.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CADzBBBb0KDVJiX2WSNW=vC6b6paWoK=5XrnZNAY+pwpcu-t9JA@mail.gmail.com> <nycvar.QRO.7.76.6.1803211242190.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAKk8isrOMMm0zyJ1JtH3aDm=tF5hwokZ0Wzn=D1BQ1R-qEPicw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1803221831120.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAKk8isqH4uRdf4dXKpxMkNoJqpabztWNPgELqtLbSupR+_C=SA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:f2cv8/RDAUo5Nf9R/rr/K/cWh2ARj83HduZ/NbGQ68nkrZYKAdc
 GffkiQe/Tcg9kA0++YuWndZ6o9IqOGXT0U1rPIWiGY1ZOW2Bq0kOrvMKWTLNh38dD6PEDet
 HtKx9zuS+zccfE8bnuRQGhIkBhv7mBRX42pRvUCDjJD7a/veeLfIV65Pwh+Kj6ramCo5s2V
 mgGODMSQaaqTGk+YsTSBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Di7GNwIRxlg=:bbdS16UqL2u0hqv4X2WVel
 bHnaPJQAmcWfTQMxDt+zXR1UAXTYdh0RPrG+XLY5Y6L8F3xLO+JjWc6w1BXifmFY6VtPeLQvm
 SiU3Tif8zsSDYUsRPEN+Ys5tT6r+XXH6Pg6MuFvk+CZBQynaOa/kHUSecjvzfs3lT6jZhlej2
 hzxxeH7wBeC7OAK6YyT+9DIvugWDl8J1mRqjaq7FfL55yiV+Al1uQEwRKKnWwF7qtyrnGpHGo
 iZgYMycCjVgJd6ql731SMz5X+WWEZfdnndgt5L3PcIfhgKflPPI5proTjPP54K3ScgCq/H7Dj
 lSiWmxi42UHK3ncdxX0IFcaPredssIcJI2EiKQBseJbvICpQZ2b3tj4hwWqBouafn1poaEx2s
 hTv01xviUztahqo9lr8WaMLhy4s+yk1OFRZhRsi1BvbsvXfK4sfyyROcPaEN7r4p/GMRL/JfL
 9hdFkr9S3PRsRIDvh1aV+ibEJGfg8qM13CdiNOk21fs4oqMb9QxVY4+p21I5VlDGB0Tfz0MWw
 4dqSTXCYNiNHUQF3mjHG0sQEnj/RQzNof6Y1NQ3paBKuw91PtCNYhRDzgiuqTDY7WpZGzVpvc
 obo5meoKrZ25R+KlO5t+Co3bwTl36M5ckoa6drHWS0YjoX0cf1aSc1NhK9BdTP5DB08hhfhhX
 bRiMkWhFpSMtuoiTfXTZyvJZONvQubx8Y292mxWkueSqCU9zlsfU/vRTS+GMkfkU++klTw41d
 xEb54nhhfWk76g3M7aZvtOJ1V/+dmjWmojy5LsqEIMvin5OyNNGK+38tCK+bKnqgvJdp18nBQ
 A9waMIOy7iK37a6Jd4pt0UJbHRijOHMEaQ3ZH0smytkCYhM1no=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wink,

On Thu, 22 Mar 2018, Wink Saville wrote:

> On Thu, Mar 22, 2018, 10:32 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> I now have a version 3: "[RFC PATCH v3 0/9] rebase-interactive:"

Great!

> Cheers,
> Winthrop Lyon Saville III (I had to repsond with my full name although I
> always use my nick name, Wink, just because Johannes seems so formal :)

Yes, I am formal. All Germans are. It's a matter of form.

Ciao,
Johannes
