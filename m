Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1764720C13
	for <e@80x24.org>; Fri,  1 Dec 2017 14:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbdLAOuz (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 09:50:55 -0500
Received: from siwi.pair.com ([209.68.5.199]:40472 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbdLAOuz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 09:50:55 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8F36384560;
        Fri,  1 Dec 2017 09:50:54 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 73D738455F;
        Fri,  1 Dec 2017 09:50:54 -0500 (EST)
Subject: Re: How hard would it be to implement sparse fetching/pulling?
To:     Vitaly Arbuzov <vit@uber.com>
Cc:     git@vger.kernel.org
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com>
 <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <172c1b03-3f44-2828-b3a6-52a6b9eac376@jeffhostetler.com>
Date:   Fri, 1 Dec 2017 09:50:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/30/2017 12:01 PM, Vitaly Arbuzov wrote:
> Hey Jeff,
> 
> It's great, I didn't expect that anyone is actively working on this.
> I'll check out your branch, meanwhile do you have any design docs that
> describe these changes or can you define high level goals that you
> want to achieve?
> 

There are no summary docs in a traditional sense.
The patch series does have updated docs which show
the changes to some of the commands and protocols.
I would start there.

Jeff

