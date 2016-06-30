Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9536C1F744
	for <e@80x24.org>; Thu, 30 Jun 2016 08:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbcF3ITH (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 04:19:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:51190 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbcF3ITE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 04:19:04 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MRoyH-1auaFp3B1N-00Suif; Thu, 30 Jun 2016 10:17:48
 +0200
Date:	Thu, 30 Jun 2016 10:17:48 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 1/2] t3404: fix another typo
In-Reply-To: <xmqqh9cb50p3.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606301017240.12947@virtualbox>
References: <cover.1467210629.git.johannes.schindelin@gmx.de> <2ad336745e1b2a610b20b7cfba169bd3e042c178.1467210629.git.johannes.schindelin@gmx.de> <xmqqlh1o584u.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606291729200.12947@virtualbox>
 <xmqqh9cb50p3.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/ruxZBcGq3tQ8okJa7UU13Rk0ZW/u1GikOS7PZCYNwmIlKOpSUS
 StxHQqM4pRuWdzPnPRBmdSP5q+/YYX2ZfjX9XKaFl0lTpqfx6ZMRZcPGxN3zAO/uy6z43IK
 xIkfPzVZnyh7CXTO6H2ixCF2WlwPHLI0oQQ5k4XnAV0GBw4r7P0M8q2j5W4AWbfB8nGcp8g
 /BVCwiiBU8Q1489GVI0Pw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:DiAL9V0CFk8=:o8h3Z2z3uZxEmPRA+MzYy0
 Tfyy2EVyFFs0Q71oKF0m902z0aLVMdTkbCFxNZOctAueLHCkr5OCbPSqxzDAMtO6l4n19m4UC
 PnMRQxnjRbhHlBV+hE0VR0uuOeTFrR7Bi8jDcKUe0yXXyjyJ1HVwyN7smJ6LxTBriyiOzRhhU
 /SjKd9+iLZyYTfUlnXKq++7v2ShkLJf1XZfyrZ2zybeG/W0TG+Z5Oi3KgHJxmYLMIde46t2rc
 66W+dphBsZZF66/RXhvUl5kLLzBIBdYPsfdoS6hessnpdGpFqACwWrWpMmioZlTLkhklLQoAf
 w4KA5NagBm1eBzh+Ilf3p+Ho5L1yhgToojkm7XsiYi8BSWpQIWH57rKuXsg77LqpcVz0dcV56
 04hTSfxv0KrXNUUyllHFw7XYZhu0ygeCN7c9iLhn9hj9fB4yP5NVjJ7h6xj3w6ehC/0wL0q5o
 DB0Uo/8YSLWSGbk9v6vtNQMar4retd5ovw18VMf85XCUq3OH/zSxAcLu7pB8bwYwlkC/Trqzy
 tSwEEoV+bZGGdc2uhQid4WJQzCoiZIfHfg5yGHW7YBwGcok6tXjmWZWN5eyWfBT8bUFPeXeUL
 aR2pBDg8OcGOJ9vezSm5UNpXNh+kGU3ihevWuAc90BqGnWYALvCTV18XwwDI9F4m4S1uDlk9U
 CsizENeHGtdoMB8rigjrUC5ZFpUmdQbBPzBMhWc15p1piDCdRqTygRKGMqQIJe25l12+GpXTy
 u8KpGtVxNmdob1gfyvH3l6Svu8Qmvr06wOfMBUZJi6vDWUT1PlTWtHd7ysCt39XfqisMD4Jq8
 G8JAbUq
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 29 Jun 2016, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >> 
> >> > The past tense of "to run" is "run", not "ran".
> >> 
> >> Actually, past tense of the verb "to run" is "ran" ;-) The reason
> >> why this patch is still correct is because this is writing in
> >> passive voice, where you want "be + past participle", and the past
> >> participle of the verb "to run" is "run".
> >
> > Embarrassing! ;-)
> >
> > Well, I shall fix up the commit message thusly:
> >
> >     t3404: fix another typo
> >
> >     The passive form of "to run" is "run", not "ran".
> 
> If your convention of referring to a verb is to show its infinitive
> form, i.e. "to run", then you would probably want to say
> 
> 	The passive from of "to run" is "to be run", not "to be
> 	ran".
> 
> But I think we do not need any of this if we just retitled it to
> 
> 	Subject: t3404: fix a grammo (commands are ran -> commands are run)
> 
> without any body.

Done. Will be part of v2.

Ciao,
Dscho
