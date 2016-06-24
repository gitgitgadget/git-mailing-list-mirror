Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_20,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47D041FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 23:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbcFXXCy (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 19:02:54 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:45890 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750996AbcFXXCx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 19:02:53 -0400
Received: (qmail 25046 invoked from network); 24 Jun 2016 23:02:51 -0000
Received: from ::ffff:85.246.157.91 ([::ffff:85.246.157.91]) by mail.sapo.pt
 (Horde Framework) with HTTPS; Sat, 25 Jun 2016 00:02:51 +0100
Date:	Sat, 25 Jun 2016 00:02:51 +0100
Message-ID: <20160625000251.Horde.vVfLKdUIk3yyVI6IH45x6TN@mail.sapo.pt>
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Alex Henrie <alexhenrie24@gmail.com>,
	diane.gasselin@ensimag.imag.fr, Matthieu.Moy@imag.fr,
	git@vger.kernel.org
Subject: Re: [PATCH] unpack-trees: fix English grammar in
 do-this-before-that messages
References: <20160624053135.7848-1-alexhenrie24@gmail.com>
 <576D1BEA.8020509@sapo.pt> <xmqqoa6qdxxk.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqoa6qdxxk.fsf@gitster.mtv.corp.google.com>
User-Agent: IMP PTMail 5.10.8
X-Originating-IP: ::ffff:85.246.157.91
X-PTMail-Version: PTMail 5.10.8
X-PTMail-User: eyJpdiI6ImFRR3dJRVk1d0wzTFh6VzV5UzFPN2c9PSIsImQiOiJIcjUzckZiUnJBZ2dPYzNtWkU1Wm1ZWWgwb3kyajQ3MGRNSyt2MFAyRVJjPSJ9
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Citando Junio C Hamano <gitster@pobox.com>:

> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>
>> The only downside I can tell about this is translator are going to have
>> to update those strings on their translations, but that is a normal
>> thing to do on an active project like Git.
>
> A larger issue is this fails to update tests that check these
> messages.

Yes, I forget about tests :-). Alex Henrie, or someone else, should  
update the tests to reflect this change if it is to go forward.

