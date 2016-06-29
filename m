Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A48BE1FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 15:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbcF2Pc7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 11:32:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:57217 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbcF2Pc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 11:32:58 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MSdz2-1assp041pc-00RXQc; Wed, 29 Jun 2016 17:31:19
 +0200
Date:	Wed, 29 Jun 2016 17:31:17 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 1/2] t3404: fix another typo
In-Reply-To: <xmqqlh1o584u.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606291729200.12947@virtualbox>
References: <cover.1467210629.git.johannes.schindelin@gmx.de> <2ad336745e1b2a610b20b7cfba169bd3e042c178.1467210629.git.johannes.schindelin@gmx.de> <xmqqlh1o584u.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wnNd0LHoxpoM1dZ1lstfjIlAO4pHdL43zn2vBoR0VHEXMxaxIAJ
 O53g9Zkcg+gqp1s5QJs+l5pQCtK8ErDQiky3p5eeU2RT35OCeMmQSwSSu/BzFZjSUq/A7T1
 LDkk5LSd1sbzrP2M2p67YI6jusurqVD/rrdiyD2Bbl60gKk/679Xlz5+O8SauLEMc/9ulD/
 DDwMMJy7TQRDcMyh1gUpg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:qaWZimmCKZM=:5lgqhcQlBlWrEEPLaBEcbC
 w8sXutQoZlr6JM8hhaqKrM0o7ufzeHed+HQ+Ptf/zXyu75FkKR8lMPwz0fsq4UveCqUoQyJmA
 6xTldLAwUsL6Cq7kdM+DIxXupoOP7tPj7dEUhVuvoYvhK2soYxisdHoDGF6dPdHt7RRpT+wsq
 N7rLJ6pZv1xSCBxKZCOfmpj8+wzm7ublHpfcvFwo9HFlQRuhC+F4Ydidw1N+i6c+oBn2EL6of
 ZiwyfRhSs/fzQ/gRxEUYw/JFRbRjBQ7cJpDA+Zc6jQcKMrXqFB8AShU6c6oFj1tvr8AbINCbP
 h5nXYSQ7c6GqlE00WWxdKWGQNVTSzXVRTyQQvA0zonY+lQTUVK9E2gqGC7okDxFAa+1k55N7G
 9QqYLDO4OHX4X5L4osk79ArZL3bQXFAGLMCZ7YS86yssODPwiHGqy2QJErzBM5CVBOPczy049
 DWKeVJCz4+grtioGy2hbWAGjAgKXveGNiWB64Ir90toB3QVZ6VLNtQ+gzqrh3X0PjWfv9nUB7
 dt7wetahOC/l8bWVYSksHhPrqZUCOOJ5AEdIMSEZxkc2zUPzGqhULho9LTucnMG6mJOuWK44V
 QI7czW+o2gNCDoeCOyH/Y1bfvWbFpHbwaXs5vK9XII7krtHUP6AQsgMMC8LRsd70hMPDW9WyA
 aDGVZX40XS77oGBu5Zg9FeUlaiLyP/eWH0jwBNJpQLXyXGFbt60iyJSHHmRJ2y8zqN+Lu1lDu
 KYKUilaoYbUhxDNsHQ3ubL534xe8ocrcrmGjpN5ErK/duIDSTJXpgavD1IBOaRRstsNm9NqQV
 3wpnrzg
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The past tense of "to run" is "run", not "ran".
> 
> Actually, past tense of the verb "to run" is "ran" ;-) The reason
> why this patch is still correct is because this is writing in
> passive voice, where you want "be + past participle", and the past
> participle of the verb "to run" is "run".

Embarrassing! ;-)

Well, I shall fix up the commit message thusly:

    t3404: fix another typo

    The passive form of "to run" is "run", not "ran".

    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Okay?
Dscho
