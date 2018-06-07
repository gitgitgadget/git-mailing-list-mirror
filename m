Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 096FB1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 21:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeFGVK4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 17:10:56 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:15872 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbeFGVKz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 17:10:55 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 411yrF2KXqz5tl9;
        Thu,  7 Jun 2018 23:10:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id BED6D108;
        Thu,  7 Jun 2018 23:10:52 +0200 (CEST)
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607145313.25015-1-git@jeffhostetler.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
Date:   Thu, 7 Jun 2018 23:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607145313.25015-1-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.06.2018 um 16:53 schrieb git@jeffhostetler.com:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> I've been working to add code to Git to optionally collect telemetry data.
> The goal is to be able to collect performance data from Git commands and
> allow it to be aggregated over a user community to find "slow commands".

Seriously? "add code to collect telemetry data" said by somebody whose 
email address ends with @microsoft.com is very irritating. I really 
don't want to have yet another switch that I must check after every 
update that it is still off.

-- Hannes
