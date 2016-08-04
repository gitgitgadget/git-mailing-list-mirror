Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B34A20191
	for <e@80x24.org>; Thu,  4 Aug 2016 05:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbcHDFbp (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 01:31:45 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:44061 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932363AbcHDFbn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 01:31:43 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3s4dph4Mm0z5tlG;
	Thu,  4 Aug 2016 07:31:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 0E65E5148;
	Thu,  4 Aug 2016 07:31:40 +0200 (CEST)
Subject: Re: [PATCH v2] t4130: work around Windows limitation
To:	Junio C Hamano <gitster@pobox.com>
References: <5bd59ca2f87e388350f3c8fb17c9a287661cd055.1469623136.git.johannes.schindelin@gmx.de>
 <9d167448-84ce-e368-0bb4-41aa4452268d@kdbg.org>
 <CAPc5daW10y_5rat0Au-1NWXUf2QYFrDfQeprqq9NsYPBjdqOTw@mail.gmail.com>
 <alpine.DEB.2.20.1607301011140.11824@virtualbox>
 <244e3458-4a41-49bf-fba2-71da872e7f66@kdbg.org>
 <xmqq4m71c0mz.fsf@gitster.mtv.corp.google.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <d00bfb15-a510-834a-9569-fa3fdb2db62c@kdbg.org>
Date:	Thu, 4 Aug 2016 07:31:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <xmqq4m71c0mz.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 03.08.2016 um 17:50 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> The patch itself seems to got whitespace damaged somewhere
> between you and me, which I fixed up,

Sorry for the damaged patch. I forgot that Thunderbird's "Send again" 
feature as well as copying and pasting between Thunderbird windows is 
poison for patch text.

What you have queued in js/t4130-rename-without-ino is correct. Thank 
you very much!

-- Hannes

