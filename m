Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11FA61F454
	for <e@80x24.org>; Mon,  4 Nov 2019 22:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390676AbfKDWLU (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 17:11:20 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:35041 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390344AbfKDWLU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 17:11:20 -0500
Received: from localhost (unknown [1.186.12.17])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id E3C32100003;
        Mon,  4 Nov 2019 22:11:17 +0000 (UTC)
Date:   Tue, 5 Nov 2019 03:41:15 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [GIT PULL] git-gui pull request
Message-ID: <20191104221115.hinnt47xm4ba3lzy@yadavpratyush.com>
References: <20191102235006.rpguewvbbpfv4wi5@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102235006.rpguewvbbpfv4wi5@yadavpratyush.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/11/19 05:20AM, Pratyush Yadav wrote:
> Hi Junio,
> 
> There are some changes in git-gui since your last pull. With the 2.24
> release coming up, I figure it is a good time to sync up.
> 
> The list of changes is a bit misleading. A lot of these changes are 
> already in Git's tree, and I retroactively pulled them back in my tree, 
> since these bypassed the "main" git-gui tree. Effectively, the merge of 
> the commit 60c60b6 should be a no-op. [0] for a reminder.
> 
> Sorry for being so late. I didn't realize the release was so close. So
> if this pull request is too much trouble for 2.24, I'm fine if you don't 
> pull it now. We can sync up in 2.25 :).

I see that you did manage to do the merge before the 2.24 release. 
Thanks.

-- 
Regards,
Pratyush Yadav
