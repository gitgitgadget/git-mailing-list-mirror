Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154F11F454
	for <e@80x24.org>; Sun,  3 Nov 2019 00:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfKCA1O (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 20:27:14 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:45177 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbfKCA1O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 20:27:14 -0400
Received: from localhost (unknown [1.186.12.57])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A4E8C240003;
        Sun,  3 Nov 2019 00:27:11 +0000 (UTC)
Date:   Sun, 3 Nov 2019 05:57:09 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Subject: Re: [PATCH 1/2] git-gui: consolidate naming conventions
Message-ID: <20191103002709.lhk3ourmj2ll6ya2@yadavpratyush.com>
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
 <da1704c56e0bd3f1ac53af96b702e3777bb3eb37.1572418123.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da1704c56e0bd3f1ac53af96b702e3777bb3eb37.1572418123.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On 30/10/19 06:48AM, Jonathan Gilbert via GitGitGadget wrote:
> From: Jonathan Gilbert <JonathanG@iQmetrix.com>
> 
> A few variables in this file use camelCase, while the overall standard
> is snake_case. A consistent naming scheme will improve readability of
> future changes. To avoid mixing naming changes with semantic changes,
> this commit contains only naming changes.

Thanks for the cleanup. Looks good.
 
> Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>

-- 
Regards,
Pratyush Yadav
