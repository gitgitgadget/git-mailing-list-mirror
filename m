Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0A0D1F462
	for <e@80x24.org>; Wed, 24 Jul 2019 18:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfGXSHg (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 14:07:36 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33113 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfGXSHg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 14:07:36 -0400
X-Originating-IP: 1.186.12.56
Received: from [10.86.3.123] (unknown [1.186.12.56])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 0E97E1C0005
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 18:07:34 +0000 (UTC)
To:     git@vger.kernel.org
From:   Pratyush Yadav <me@yadavpratyush.com>
Subject: Where do I send patches for git-gui?
Message-ID: <35506bd2-aae9-6608-ed4d-a408e0c831b8@yadavpratyush.com>
Date:   Wed, 24 Jul 2019 23:37:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a quick little feature to add to git-gui, and I'm wondering where 
should I discuss it and send patches. The git-gui repo [0] has no readme 
I can see that would point me in the right direction. Googling around 
didn't get me anything either.

Should I send it here on this list or is it somewhere else?

Also, is the project even actively maintained any more? The last commit 
was in 2017.

[0] http://repo.or.cz/w/git-gui.git/

-- 
Regards,
Pratyush Yadav
