Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE75F2018E
	for <e@80x24.org>; Wed, 17 Aug 2016 11:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbcHQLgJ (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 07:36:09 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:58688 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbcHQLgI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 07:36:08 -0400
Received: from [84.131.251.93] (helo=sandbox)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1bZz8d-0000FJ-VB; Wed, 17 Aug 2016 13:36:04 +0200
Date:	Wed, 17 Aug 2016 13:36:02 +0200
From:	Heiko Voigt <hvoigt@hvoigt.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] document how to reference previous commits
Message-ID: <20160817113602.GB6080@sandbox>
References: <578E7A07.8080006@web.de>
 <20160720082515.GA823@book.hvoigt.net>
 <57911AFF.7030107@web.de>
 <20160725143706.GA4872@sandbox>
 <xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
 <20160726094913.GA3347@book.hvoigt.net>
 <CAGZ79kaOf3NRAXh+krM=onwswSjAF3yy_zpa1d+9CFOBNke6-w@mail.gmail.com>
 <20160728111636.GA7760@sandbox>
 <20160728125514.GA2813@sandbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160728125514.GA2813@sandbox>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Thu, Jul 28, 2016 at 02:55:14PM +0200, Heiko Voigt wrote:
> To reference previous commits people used to put just the abbreviated
> SHA-1 into commit messages. This is what has evolved as a more
> stable format for referencing commits. So lets document it for everyone
> to lookup when needed.

A quick ping about this patch. Maybe you missed to include it Junio? I
can not find any reference to it in the cooking mails and in your
repository.

Cheers Heiko
