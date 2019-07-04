Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43F971F461
	for <e@80x24.org>; Thu,  4 Jul 2019 10:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfGDKql (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 06:46:41 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:18383 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfGDKql (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 06:46:41 -0400
Received: from [192.168.1.22] ([89.243.190.203])
        by smtp.talktalk.net with SMTP
        id izGBh6dfGnuQZizGBhlumt; Thu, 04 Jul 2019 11:46:39 +0100
X-Originating-IP: [89.243.190.203]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=eLyEXkeXgyqjrUSteAL3aw==:117
 a=eLyEXkeXgyqjrUSteAL3aw==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=vZxbLtyPAAAA:8 a=que0cE52iIBSqqrjLfYA:9 a=QEXdDO2ut3YA:10
 a=6hzUJDC_kiwA:10 a=YIznc7gRMHvxYRuyG5Sm:22
Subject: Re: [PATCH] make slash-rules more readable
To:     "Dr. Adam Nielsen" <admin@in-ici.net>, git@vger.kernel.org
References: <20190604173446.2664-1-admin@in-ici.net>
 <bd722415-1547-8db5-f88a-c35c8b48d8be@in-ici.net>
 <13f99ce6-f856-6554-5c14-1b1838d697d0@iee.org>
 <d1d2ebec-a94a-0092-4a6d-8ae32db1573b@in-ici.net>
 <b33e42c2-96a7-88d8-03b1-2da317dfa692@iee.org>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <1104adb4-dd84-9e87-3c95-70a0088eadb0@iee.org>
Date:   Thu, 4 Jul 2019 11:46:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b33e42c2-96a7-88d8-03b1-2da317dfa692@iee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfGgTr4PRXF2pGCFM0wFkKHfw9t1l8ARn18Yxe2fg2LhRQXIuT3lkdG4buxznWUWKGb69PwFbgDTT67maGIEAiZ75tH5N8TWxVlltnXIYnZqzQww+0PXe
 d/wrQsOVJ//QqCE6T3w8/Z2ugf45IcS2cMbA9pKvwK3tzFFXVxJNDBgK04ythriAH5cPQb2s4fpIeLPhihtpzObtHxZA3LzaYkk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oops, I missed Junio's message [1] while looking through my backlog. 
Sorry for the noise.
Philip

On 04/07/2019 11:40, Philip Oakley wrote:
> If all the issues are cleared then I believe it is a case of providing 
> a clean reroll (maybe identical to previous..) to Junio and the list 
> to confirm that all issues have been resolved and it is ready for 
> pu->next->master in the normal way, which should then show up in his 
> 'What's cooking' emails. 
[1] <xmqqd0iyc4av.fsf@gitster-ct.c.googlers.com>
