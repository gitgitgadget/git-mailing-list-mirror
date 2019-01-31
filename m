Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E316A1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 22:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfAaWLk (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 17:11:40 -0500
Received: from siwi.pair.com ([209.68.5.199]:48622 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfAaWLj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 17:11:39 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B218A3F408C;
        Thu, 31 Jan 2019 17:11:38 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 75C473F4085;
        Thu, 31 Jan 2019 17:11:38 -0500 (EST)
Subject: Re: [PATCH v3 00/14] Trace2 tracing facility
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com
References: <pull.108.v2.git.gitgitgadget@gmail.com>
 <pull.108.v3.git.gitgitgadget@gmail.com> <20190131143811.GB10587@szeder.dev>
 <9b603fd7-d8f0-1ce7-7c7c-8b17484d7d0a@jeffhostetler.com>
 <xmqqbm3w3bjz.fsf@gitster-ct.c.googlers.com>
 <0764948c-f3ac-3bd1-fd82-2bd3f59b463d@jeffhostetler.com>
Message-ID: <a2b7a14d-5829-45dc-81b2-9ff9b876c017@jeffhostetler.com>
Date:   Thu, 31 Jan 2019 17:11:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <0764948c-f3ac-3bd1-fd82-2bd3f59b463d@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/31/2019 2:45 PM, Jeff Hostetler wrote:
> 
...
> 
> I can undo my formatting changes if we want to update the settings.
> I'll give that a try if there are no objections.
> 

I'll push up a V5 in the morning that adds the foreach
macros to the .clang-format and updates the code accordingly.
Currently, waiting for the CI builds to finish.

Jeff

