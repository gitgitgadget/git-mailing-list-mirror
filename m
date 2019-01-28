Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B1D1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 16:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbfA1QPc (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 11:15:32 -0500
Received: from siwi.pair.com ([209.68.5.199]:25848 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733063AbfA1QPb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 11:15:31 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 180313F4050;
        Mon, 28 Jan 2019 11:15:30 -0500 (EST)
Received: from [IPv6:2001:4898:6808:13e:815c:21bd:1783:513d] (unknown [IPv6:2001:4898:8010:2:6a90:21bd:1783:513d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D4DDD3F4015;
        Mon, 28 Jan 2019 11:15:29 -0500 (EST)
Subject: Re: [PATCH 00/14] Trace2 tracing facility
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
References: <pull.108.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e1bd52e3-1ac5-b08c-d1f6-a7fa63ebf0cf@jeffhostetler.com>
Date:   Mon, 28 Jan 2019 11:15:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/22/2019 4:22 PM, Jeff Hostetler via GitGitGadget wrote:
> This patch series contains a greatly refactored version of my original
> Trace2 series [1] from August 2018.


My Trace2 series "jh/trace2" has a bad interaction with "js/vsts-ci"
causing some unit tests to fail in "pu".  I'll post a new version
shortly.

Jeff

