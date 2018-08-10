Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 895AD1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeHJXiK (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 19:38:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:41451 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbeHJXiK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 19:38:10 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEKZg-1fhZiM2Riq-00FVAj; Fri, 10
 Aug 2018 23:06:34 +0200
Date:   Fri, 10 Aug 2018 23:06:37 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 17/21] range-diff: populate the man page
In-Reply-To: <20180729212354.GB9955@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1808102306080.71@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <9e09c6be66e960db496b1c9a30eb5040242ab764.1532210683.git.gitgitgadget@gmail.com> <20180729212354.GB9955@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gBjoCFWcZQy+E1+YoPu1m89zG2guF6/GQIfwx6GW5U0m7j9se4X
 RB+pxSziqqXUxni8jAjR4myBowyQAY7CnLbc3MpG/3Q+mj0/UmUKQr2aCmCXKJYs4rieRJn
 GtFvcVbqyvC0LXq9qU+XEVELwlBjDBzuSONaGz1N65zrbNRpGHCPJFY9Gdmgpy4cFQv34S6
 DJP3HFRwMTlX2+3yffkmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MW8TkjzTXNs=:h9JN8iA43lq8ga98lZzrV4
 NLHQjKazz7sYWIUC1YKOhTa1gGvGTdnMwHm+Elxsj1LFxLt5PJHtac8OFyewrhSktnxA6EJFX
 UYEsH/VnM80c7T31UHdh+kibEMHoh4V6d673ATMPuJyHQJ6yGSECc10+LjU+LQFF2gw5ZSMFO
 1xd+kviOFZWZy5nHcYWSzi2DpEJnKA8JV+RgAbpB9O4w9dwvYJ2k9jFAKnYsl2fzYkdi7r6go
 Zhe/5ocBUWQSYcw77dsSBKWO41twXb9tfVjwdrnLmo5cv74KjTkBslQhZUkBLQRT0P0y3yEEd
 cWWys2tTzlaTlY/ZlKubap8Moyq2QB1u2j8On0X6vQYCALCOpIOzYv6RgWW+jZWfqD2SOhh88
 Gjfic880Eil8jMHrlswDbnR3fg1HAWIl9+Xyj76l86QEouFK21qC+BVGyxmu62MhyhQFwdXAD
 sDzPptFjlmB0x/xrAEvjKi/HdfIrk2Y21XRRNL4n6fid1nR+AAuSxDiNdPVRB2d6X3knHE5TA
 SoJ1dqNyPMMuGsnaWtl/ClJnu/NgaWtH2oGSFLemvaoXwrc6P8HiSmc5yFexE5uz7gtwsJ+sB
 cj9Ml2kqLNgnThMCkxJVy5gJXEV+lJwlh+TdYOM9eA4PF9qCL+wO5BPlXJpRZfXaNDPC07cT8
 HU46JDKAbde87+YD+FRPtjqoNO0qSY7SIHD7RxY6cruY1TQizxBXFgcXqEvBgPVTwoHMMLil+
 xrWmwIUMjv1ngidz5aaTFDtD7zGLLK0T+odLnZxqWdYwX7Mt5EjMZtOUEO54QPgc6lNZrkQOi
 c+K0+7y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sun, 29 Jul 2018, Thomas Gummerer wrote:

> On 07/21, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> >  Documentation/git-range-diff.txt | 229 +++++++++++++++++++++++++++++++
> >  1 file changed, 229 insertions(+)
> > 
> > [...]
> >
> > +CONFIGURATION
> > +-------------
> > +This command uses the `diff.color.*` and `pager.range-diff` settings
> > +(the latter is on by default).
> > +See linkgit:git-config[1].
> 
> Would it be worth implementing a `rangeDiff.dualColor` configuration
> at some point?  Dual color mode seems like something I would like to
> have on by default, even if we are not making it the default for the
> command itself.
> 
> (Again this is something that can be a future enhancement).

Sure, go wild!

Ciao,
Dscho
