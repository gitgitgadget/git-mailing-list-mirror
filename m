Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402D71F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeGPOWO (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 10:22:14 -0400
Received: from avasout07.plus.net ([84.93.230.235]:36034 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbeGPOWN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 10:22:13 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id f3xWfYDSKjlDzf3xXfUOZE; Mon, 16 Jul 2018 14:54:39 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=0wQfACPxRGgY8KnhC8UA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 00/16] Consolidate reachability logic
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com>
Date:   Mon, 16 Jul 2018 14:54:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFjGNM2/6VTeiZlO5r5dCgxFwVSor7HXmCVTDgvAC1ONu34NarDHcQQlziJhtZIvHSm041fizn/CWWrVtrc+b4cGQvK6PfkIx4yEJUf1OXsNlKmVhyfn
 E8MOGR6SXcEKvuCG4+3KZ5e7rmuBAn4xGYUdeH6G5NF7N3FKwTO9nKnBskc9VZ8R4bDdr/6PsTKywA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 16/07/18 14:00, Derrick Stolee via GitGitGadget wrote:
> There are many places in Git that use a commit walk to determine
> reachability between commits and/or refs. A lot of this logic is
> duplicated.
[snip] ...

This is not your problem, but I find these GitGitGadget
submissions somewhat annoying. This series has been spewed
all over my in-box in, what I assume, is commit date order.

So, patches #4,5 dated 19/06, then #1,2,3 dated 25/06,
then #15 dated 28/06, then #6,7 dated 12/07, then #8-16
dated 13/07, then 00/16 dated today.

No I don't use a threaded display (I hate it), be even with
that turned on, the patches still appear in the above order
under the cover letter (but at least all together).

Annoyed.

ATB,
Ramsay Jones

