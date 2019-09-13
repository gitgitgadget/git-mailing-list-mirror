Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D190C1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 19:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbfIMTtQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 15:49:16 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52017 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfIMTtP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 15:49:15 -0400
X-Originating-IP: 1.186.12.20
Received: from localhost (unknown [1.186.12.20])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 3B85640007;
        Fri, 13 Sep 2019 19:49:12 +0000 (UTC)
Date:   Sat, 14 Sep 2019 01:19:11 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org, Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH] git-gui: convert new/amend commit radiobutton to
 checketton
Message-ID: <20190913194911.3vwki4wa4jd3capr@yadavpratyush.com>
References: <b3f1cd2b-7462-89fd-ff2d-9e53da286027@iee.email>
 <a2026a3d310f90b70a191e2c24106d600195d2b1.1568354429.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2026a3d310f90b70a191e2c24106d600195d2b1.1568354429.git.bert.wesarg@googlemail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You missed fixing the typo in the subject. s/checketton/checkbutton/. 
But no need to send a re-roll for that. I can fix it locally.

Other than that, LGTM. Thanks, will queue.

On 13/09/19 08:02AM, Bert Wesarg wrote:
> Its a bi-state anyway and also saves one line in the menu.
> 
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

-- 
Regards,
Pratyush Yadav
