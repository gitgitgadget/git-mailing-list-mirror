Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DA3B2018A
	for <e@80x24.org>; Wed, 29 Jun 2016 05:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbcF2Flm (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 01:41:42 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:50197 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbcF2Fll (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 01:41:41 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rfWkn2Tx2z5tlS;
	Wed, 29 Jun 2016 07:41:37 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 9045552BC;
	Wed, 29 Jun 2016 07:41:36 +0200 (CEST)
Subject: Re: preview: What's cooking in git.git (Jun 2016, #10; Tue, 28)
To:	Jeff King <peff@peff.net>
References: <xmqq4m8c7uo6.fsf@gitster.mtv.corp.google.com>
 <20160629014342.GA28661@sigill.intra.peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <57735F90.1010907@kdbg.org>
Date:	Wed, 29 Jun 2016 07:41:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20160629014342.GA28661@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 29.06.2016 um 03:43 schrieb Jeff King:
> Another is to just put the posix/ksh schemes into the helper function,
> and let Windows people sort it out later if they want to.

Let's do this.

-- Hannes

