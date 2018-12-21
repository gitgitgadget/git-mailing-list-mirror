Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1805F1F405
	for <e@80x24.org>; Fri, 21 Dec 2018 12:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbeLUMQT (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 07:16:19 -0500
Received: from mout.gmx.net ([212.227.15.15]:59543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbeLUMQS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 07:16:18 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwrPM-1hT7FV2yjo-016PH2; Fri, 21
 Dec 2018 13:15:57 +0100
Date:   Fri, 21 Dec 2018 13:15:40 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     William Hubbs <williamh@gentoo.org>
cc:     git@vger.kernel.org, chutzpah@gentoo.org
Subject: Re: [PATCH 1/1]     Add author and committer configuration
 settings
In-Reply-To: <20181219183939.16358-2-williamh@gentoo.org>
Message-ID: <nycvar.QRO.7.76.6.1812211310040.41@tvgsbejvaqbjf.bet>
References: <20181219183939.16358-1-williamh@gentoo.org> <20181219183939.16358-2-williamh@gentoo.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ON35oUdFCYU8BVMd8BEctnHcHcyFbAntsIQRp3LKmd2p+Dx9oBk
 BWp/XgUGhLS7yuee7Wae1xwoVL7qE1kk0pGhrPCo7oh8cD5+mu4KqCabZYJZq53Ej3XldbF
 zqLnoCZ5XRB19Wrzvbw5Zfz1r7OaAZ8fTyBLAiebqlFl2X8MbZE1M0Ullm6cFb5hHsjUlE6
 9GFzJ8AahGRdBNGxcf4Mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uDN2blJRV7E=:XfIjtbt/UVW6ZwVojZ/V3c
 4DPYkNslrkmYW6Mxc0VgAURvRrS5tGIGjuK5/abX8i08yQnq86SGQI2HnHf2nN9I8tR1t0YBS
 ESDTuOazX0VATmSYk7eTV2mdxF2O6jXxSzmhImKJP2D5487x2dpboF2rTqvnVXVXzennoUgpf
 9MXzfyd5QS7frRc3otX4q2FFCmVncZFUMPcIX8u56eHCtq7c/PVC25CUAzjnptZnZ+WAMpe5r
 9Js1UF/CDEEgEbs37noVu6er+wlXSjgP4aAMLV2EDb0IHuhdQf1v4iVmleSofDto0Uyfq6TmL
 aADa1kIh4/ksUs3MA3+N+NjTCGAGDzD3j0RZiwliafpxzHM+gkwxeWBHJFjTCEve41bon/fPw
 oz5e+kCCx3DYcvWZ/B8i9bI8ptjXjXHr7oW1RcJ7rJxWBJjyVvJQuXYLQ4o+1S8ddT32T0nnh
 shy/xnntTJQhlvRC7YIWd0D5gU6exMLWOdmyW4tHtaolTLHB3nFsk4JvTLwzUiCEUNpK1kObp
 FFF5E4MEjo3MQVN40KqH3nBPwlpHE+VMCZ/FZ2a8G7dli8zyUozZ+Qu6BA3dhFvUc3tIB1Gej
 6lu1G/gp3xZ1vlVIy+MiEpTzgIf/mXLUdvkfY8yZ6DmwymzM4MLg7oOMbZJNL/G0pCnkGFY9M
 8D2mpj33QbYdNZiavz4CRoJj07AJlV9CaOfDrBiuzG2P3g8HctvDN74UFiJjnoI3z5ox5zeua
 E20X2URqygzpLm1jUvGybrYzMs64R6L5SyQPAceO8QepJBboJiCWiy4gFIPJLhHq/5p1rCq/+
 GREFC1U008IKioONvr4wdgQYdMjBal7EqsA5NvZCMqxY5pQwC7G05k2djl9Mua0LESEbxuHaj
 uzUnzwWH38dtON5p7nWb1TeD/zH1U/i36O+4oKQzwxg8nexIGGU1kzdlywVB9FrNHqIsxAI1O
 PBs7XvS59Nw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi William,

thank you for putting this together.

On Wed, 19 Dec 2018, William Hubbs wrote:

> -extern const char *fmt_name(const char *name, const char *email);
> +extern const char *fmt_committer_name(void);

If it would not be too much trouble for you, could I ask you to split this
change out into a separate commit (which would be the first of now two
patches)? It could have a commit message like this:

	ident: rename fmt_name() to fmt_committer_name()

	Ever since 4c28e4ada03f (commit: die before asking to edit the log
	message, 2010-12-20), all remaining callers of that function want
	to format the committer name. To simplify the code, therefore, we
	rename the function and move the getenv() call into it.

Ciao,
Dscho
