Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CEA21FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 12:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938699AbcJXMjt convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 24 Oct 2016 08:39:49 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:43130 "EHLO
        wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934997AbcJXMjt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Oct 2016 08:39:49 -0400
X-Greylist: delayed 936 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Oct 2016 08:39:48 EDT
Received: from ip-37-24-172-167.hsi14.unitymediagroup.de ([37.24.172.167] helo=zanovar.fritz.box); authenticated
        by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        id 1byeIT-0004nC-Mu; Mon, 24 Oct 2016 14:24:09 +0200
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 00/27] Prepare the sequencer for the upcoming rebase -i patches
From:   Max Horn <max@quendi.de>
In-Reply-To: <alpine.DEB.2.20.1610231151140.3264@virtualbox>
Date:   Mon, 24 Oct 2016 14:24:49 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <DAD768D3-5558-49DE-9FDD-E46F17933ECE@quendi.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de> <xmqqinsk8g1b.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610231151140.3264@virtualbox>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1477312789;ee245d02;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

> On 23 Oct 2016, at 11:54, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Hi Junio,
> 
> On Sat, 22 Oct 2016, Junio C Hamano wrote:
> 
[...]

>> There isn't enough time to include this topic in the upcoming
>> release within the current https://tinyurl.com/gitCal calendar,
>> however, which places the final on Nov 11th.
> 
> More is the pity.
> 
> Thank you, though, for being upfront with me. I will shift my focus to
> tasks that require my attention more urgently, then.

Junio did go on, though:

>> I am wondering if it makes sense to delay 2.11 by moving the final
>> by 4 weeks to Dec 9th.

I was reading this as an offer to delay things to accommodate the integration your work into 2.11. I.e. "within the current plan, there is no time for this, but we could adjust the plan". But maybe I am misinterpreting?


Cheers,
Max
