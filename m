Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5943200B9
	for <e@80x24.org>; Thu,  3 May 2018 21:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbeECVH6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 17:07:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:51873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751126AbeECVH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 17:07:57 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOTRh-1fJYei0YhZ-005rxw; Thu, 03
 May 2018 23:07:53 +0200
Date:   Thu, 3 May 2018 23:07:53 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 00/18] Add `branch-diff`, a `tbdiff` lookalike
In-Reply-To: <87po2cy5qd.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805032307160.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <87po2cy5qd.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-275019780-1525381674=:77"
X-Provags-ID: V03:K1:0jDM5sBQEpCDumJVGoLBON2z1cXhHxyy0b06C8hqz2P32FAhGoC
 Y1LKCsjwAWGQ2iVAAA2ghuqNYYtfR7ZjHT/BllhprlR9kGCKfveDQ5uiTAANDnz0VqtLZXe
 pd+oT6CCu7cXIxEs8WsUZe0Z9u19KGf/iunI6GNoseHWTe/hL55rs/KoWNJpWXpBWWQpdwb
 x+6jirCKA3V+WxLoNw/KA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bMxFw5c9JlY=:xT6/BZVGUgUoZ283Wt/0uS
 s/6kDXl+47IRhf6mqJqbu06tLEGZN/11+RD4h8+g7dl0zo+t6XN34NdJ+0UyzQnCYuHmL1aUi
 FpYbwlzo9gF3PMFQC78UbmKnYI/vkIr4WLWenX4s9rNp0UtOIr/vUg5U+Wfb3TvsmbYnDA9LJ
 mYa6r1BQj1DNeNADBE4u3TG/lCQo+pPTCZg+VTANIhxvMwp3T88aAAs9+dN//qlDb6L1f8kku
 7KA7jLJFXfqYvWDZjGt6n0WLLVq7sdOVvlXcLVDFY2dn8aZY8xtkbqqOTOkVqmSTiF2AcQjwi
 ljExqKPUjfN+/sLVm6dTOsRSO86bNXlCfxOg/mRAGJt43VpMNgaNYaYjK42z8wXW/MtI3tZCg
 yB/UmCgwpyBCb1NqUnDA5sMJSZjO2cC1QTRiBzSi4S3Plf0z595Maal3HzsVddf4115QCKjwL
 kuWTThMqchDjmcsjEdvDX5BqOmdYr+Nm/u4fZUU7mmERDfvTB/innNCXnfpY1FIfDIvjNe96L
 xcTP4Z78Fj5wl7NH/psmBIQ5MgEMaonQPSSbHI/fRID6LozfzQboRVyH2k0MSBkj0U0uD/RmY
 kjinFS9KDnphab9T4Facx38zlW5ae33ZQigxhS8b3umaF0R9Jdngc3rLowfUmAhESKcjNEh5/
 AP8CG2+QiBS9byAZASR3pYQQsSy3C36ymRegB+SDtmKyv06RjSI1qp7AR5C+SM1EN8/9QGtdh
 a8T9rtQIiZgDWj2okCWylB2hOjmJPMcJQqn/LCL7X8aB7EWsNop48if03uCDZL+snHVQdgxhM
 u8vn5nd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-275019780-1525381674=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Thu, 3 May 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, May 03 2018, Johannes Schindelin wrote:
>=20
> > The incredibly useful `git-tbdiff` tool to compare patch series (say,
> > to see what changed between two iterations sent to the Git mailing
> > list) is slightly less useful for this developer due to the fact that
> > it requires the `hungarian` and `numpy` Python packages which are for
> > some reason really hard to build in MSYS2. So hard that I even had to
> > give up, because it was simply easier to reimplement the whole shebang
> > as a builtin command.
> >
> > The project at https://github.com/trast/tbdiff seems to be dormant,
> > anyway.  Funny (and true) story: I looked at the open Pull Requests to
> > see how active that project is, only to find to my surprise that I had
> > submitted one in August 2015, and that it was still unanswered let
> > alone merged.
>=20
> I've been using branch-diff and haven't found issues with it yet, it
> works like tbdiff but better. Faster, uses the same diff as git
> (better), and spews to the pager by default.

Thanks for your enthusiasm!
Dscho
--8323328-275019780-1525381674=:77--
