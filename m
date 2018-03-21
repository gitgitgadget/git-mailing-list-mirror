Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B011F404
	for <e@80x24.org>; Wed, 21 Mar 2018 22:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753983AbeCUWbi (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:31:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:41979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753761AbeCUWbh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 18:31:37 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Maa3B-1fIlzL1v1l-00KChs; Wed, 21
 Mar 2018 23:31:26 +0100
Date:   Wed, 21 Mar 2018 23:31:14 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     David Pursehouse <david.pursehouse@gmail.com>, git@vger.kernel.org,
        David Pursehouse <dpursehouse@collab.net>
Subject: Re: [PATCH 1/1] Fix typo in merge-strategies documentation
In-Reply-To: <xmqqo9jkvwjh.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803212330510.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180317033142.20119-1-david.pursehouse@gmail.com>        <20180317033142.20119-2-david.pursehouse@gmail.com> <xmqqo9jkvwjh.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Jd8RQTU0PG9gKMbTRPYSJnbpKJM2WZr64cBwCQ2nwMLhxLWWm3w
 YToz9klwXtUhEa8+FcilAfZ1vJsTvOu1obAVs+oLRbKeNHy/w9vNent45RcqVb/4jByJaeI
 Mvdybx3L/tvHrMa4MmPQFTaYB1HffpqOEtnNiJZqI0Vab/3JEZR/rYRAgadayLv7JcSq3Qn
 nq2a5WUShKhMnUmu0ywNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wXyfdQve/vY=:6ZvBVcDSOF3Z8CQP/8rd0L
 x1beUVRpDXwGvIud+QUvF3cnYGzhCQaau2cmp4+GlHQro0SuPaAxgSTlKztfdIY3jY1VtG4YH
 zo6RNW3I5CfApLbTJOmMus8kE2W15WTLzRrUNwrrOAvOYsdoJ3HZnTuZQ3DSOHO8cZiQc6LDL
 0PBBtjxpvEUF4tHOMdJLLwgDOgKEPtk57kHv1I1hGz7a141rY2Vu00V0FqlSWxWvgUF81FnLh
 Pmso++TV9cuqxC/ax57zT9NpfIw2ARqpxU6eS/lhgrYriOP/7UJWWcqotkQ2ftshlTGdmOXTR
 FcFIPTXQgqBbkVWJc8mPU/fErHITw5zt+qEytMWN3cYY544vJRtA72FJJzC0Z7FaNyD8yPcRs
 nClslpxhxtJtC8yACeESc4dY1eQVhgrF+d54ScEVEXlWUBIe0q1tE8jogYyMCrSQjPHU9/PlX
 tTHYq0EBMiyRMlXzeyvr7LsllugH02HjtUIcc53Z2Edcq9djk+0mlAIAJ427AxDKss8046/Mp
 oTOC1CmS3rOlCryq3piKsVQt/slyw/aVU3PWYiY/fSLQU3pswyR9RyhYvQ05WjKzfZA8QYszT
 491bXyzjKDmk3uAewF87+aPf57Du/n9lFs6uPQ1VhhhtmP//O9V/N8sW5LnCDATiw/AOFI+w5
 qU23ev3CttYcB1ex0iIqj/R+XAcNc0uYE2E7CjU/y7TLf0ZkHKPuLIfdg8bg6fd9PtlQDQJcg
 cyo6ROhTWTL4Y//i9VnU0ergZlEeNlh+730+2hplEYTRx81ykUEgT1XgZfVEgiDEEZnKUzJX1
 cXNefLuIYTuw2hJzRHtoD6JhxFYXNrp3dQiidBwSmAoq21FCDA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 19 Mar 2018, Junio C Hamano wrote:

> David Pursehouse <david.pursehouse@gmail.com> writes:
> 
> > From: David Pursehouse <dpursehouse@collab.net>
> >
> > Signed-off-by: David Pursehouse <dpursehouse@collab.net>
> > ---
> 
> I somehow had to stare at the patch for a few minutes, view it in
> two Emacs buffers and run M-x compare-windows before I finally spot
> the single-byte typofix.

Pro-tip: git am && git show --color-words

:-)

Ciao,
Dscho
