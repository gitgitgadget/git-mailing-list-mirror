Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70871F461
	for <e@80x24.org>; Sun,  1 Sep 2019 22:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfIAW1t (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Sep 2019 18:27:49 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:54515 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbfIAW1t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Sep 2019 18:27:49 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i4YK3-0004Sl-3S; Sun, 01 Sep 2019 23:27:47 +0100
Subject: Re: [PATCH] git-gui: Add hotkeys to set widget focus
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     git@vger.kernel.org
References: <xmqqbmg13sxq.fsf@gitster-ct.c.googlers.com>
 <20190831122326.9071-1-birger.sp@gmail.com>
 <20190901113218.3lfu4ifsxhzrsw4g@yadavpratyush.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <e2b35f49-5578-c58f-326d-3111333737a0@iee.email>
Date:   Sun, 1 Sep 2019 23:27:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190901113218.3lfu4ifsxhzrsw4g@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyus,
On 01/09/2019 12:32, Pratyush Yadav wrote:
> Hi Birger,
>
> In case you haven't been following the list, Pat has been inactive
> recently, so I am acting as the interim maintainer of git-gui for now,
> because no one else stepped up and Junio would rather not maintain it.
>
> You can find my fork over athttps://github.com/prati0100/git-gui. I
> munged your patches to apply on my tree (which is separate from the
> git.git tree), but it would be great if you base them on my tree next
> time around.

Are there any plans or thoughts about creating a more inclusive man page 
for the git-gui?

Such things as the Options dialog linkages [1], and how to drive the 
command line options are areas I've wondered about over the years.

Not exactly sure how our plain text man pages and formatted HTML would 
fare for describing the gui layout and where to click. One thing I am 
noting is that these hotkey nicely have numbers so can easily be used 
for reference..

Philip

[1] 
https://stackoverflow.com/questions/6007823/is-there-a-help-page-for-the-git-gui-options-dialog
