Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222BFC00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 16:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B944220724
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 16:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgJ3QFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 12:05:10 -0400
Received: from siwi.pair.com ([209.68.5.199]:17967 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgJ3QFK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 12:05:10 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6FBB93F4096;
        Fri, 30 Oct 2020 11:58:47 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 21C453F4090;
        Fri, 30 Oct 2020 11:58:47 -0400 (EDT)
Subject: Re: [PATCH v3 00/19] Parallel Checkout (part I)
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     gitster@pobox.com, chriscool@tuxfamily.org, peff@peff.net,
        newren@gmail.com, jrnieder@gmail.com, martin.agren@gmail.com
References: <cover.1600814153.git.matheus.bernardino@usp.br>
 <cover.1603937110.git.matheus.bernardino@usp.br>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a6365d1a-9baa-2488-ca1e-e4e3354bccf5@jeffhostetler.com>
Date:   Fri, 30 Oct 2020 11:58:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/28/20 10:14 PM, Matheus Tavares wrote:
 > ...

Looks good to me.
Thanks for pushing this forward.

Jeff

