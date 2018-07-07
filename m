Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B651F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 12:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753765AbeGGMgx (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 08:36:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:46569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753316AbeGGMgw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 08:36:52 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHrk1-1ffKyR2Jif-003cP3; Sat, 07
 Jul 2018 14:12:06 +0200
Date:   Sat, 7 Jul 2018 14:11:49 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= 
        <pclouds@gmail.com>, kgybels@infogroep.be
Subject: Re: What's (not) cooking
In-Reply-To: <CABPp-BFs1gYzBY5+QrrLEB5kJTaierSGDnYWs=5HKRcPksx9cw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807071411090.75@tvgsbejvaqbjf.bet>
References: <xmqqlgaogeff.fsf@gitster-ct.c.googlers.com> <CABPp-BFs1gYzBY5+QrrLEB5kJTaierSGDnYWs=5HKRcPksx9cw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CBd3DWL/2TooKFpx62nnzsXSLADlwWTPvE+FgjupVSnu6JMpJTE
 45SBDn1H3xSV6K3Dk3/xobnunbLBgRR0KdTOdO+EtY1L7CSU34UY8JvGo9HR9Ird3buuNfL
 1jUdGaRV99+yfseXKYeVLNnl6f0yU3D/SkLUybwdPq12ilPHyAxOLhxfMbK94JOF5BbMLj/
 nUeCYK7LPLqHm3HMf5igQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TjWOrqQM8dk=:iNJ2tz8kDDOr1t8Dafm+c8
 VW/8a3Hbp5NLjlTS/2tciAOZ7X4p04U0gS29IU2m+EjKPQewiDUgMOpVpk3IXd9E2bh4+waKn
 mDI+FBzbP/RO8It3uX6PQayCysaS0sXsDDAJmYvMNKaO7o4gUGtd7G0+8CvokJhqzp5qW5HgV
 hUpEdc+IDTl7pqFo9mzvwMqC8nA3HWgGXc6y/cejj1rnzLSheGCDlpcFDNSVfP/BRFGEbAmPj
 ihPfeb6FLe0XhO8mcNvEd+/oIn+iWP2XhbayLo+qPMIvZg/3mVaRWOPiXfNQPueyev5LGyZHT
 mBNXC912EtO/cN7o3AHxugyB2weXisyh7eZlj6GcIeMZUQ6CR1H8fFRj/aUJD/i53i16dGaCL
 MNeaAq8htgL+9llRXkuUf8j8Zx7m9YjTN7trfOkh3SFc+Mhqzg2sweeTq6fvpjFDMCDHYZ3du
 Bggi+tGFdCBHGBRMDVB6TSXMQKPH6N39qx6sImstpueho4KQ7GGceuRt18lRCQGXzb7H78C7W
 wHkT+pLsZ55dorAl6YPTsjdfd/KwkOSkJOWEmn+Ub1kSsgMASDqHeLC1YlZhcl62YBATN05zv
 OVlBq+0tPgkHcpuiWSinRZ09vR3+Fg4doRFhUtzjboQh/mDkD0ZRZIeX3i+KqcW1jwczLiCPa
 voG+qZ3SWy6nC4rlvJznFpfmEjwx5iHd2Qb5rixDlFR8FUCwjBl+GuIIqnVAgtOe2Qxv6ZwL5
 NkcXLrtsA3WTcOyOtNU5U8d09cTbc3rEf1bQHLFnVwxVFKXQUQVFz1oh8+dYgs2K8p+cMStQ6
 f6Hbjlr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 6 Jul 2018, Elijah Newren wrote:

> On Fri, Jul 6, 2018 at 3:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > I'll be pushing out the integration branches with some updates, but
> > there is no change in 'next' and below.  The following topics I gave
> > a quick look and gave them topic branches, but I had trouble merging
> > them in 'pu' and making them work correctly or pass the tests, so
> > they are not part of 'pu' in today's pushout.
> >
> >     pk/rebase-in-c
> >     en/dirty-merge-fixes
> >     en/t6036-merge-recursive-tests
> >     en/t6042-insane-merge-rename-testcases
> >     ds/multi-pack-index
> 
> It looks to me like the main problem is that pu itself has lots of
> test failures.  It seems to bisect down to
> kg/gc-auto-windows-workaround.  If I revert commit ac9d3fdbebbd ("gc
> --auto: clear repository before auto packing", 2018-07-04), then pu
> passes tests again for me.

Is this the segmentation fault about which I just sent a mail?

Ciao,
Dscho
