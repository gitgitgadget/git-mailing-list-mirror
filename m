Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7B9C5519F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 01:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F992225E
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 01:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgKSBCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 20:02:20 -0500
Received: from vsmx009.vodafonemail.xion.oxcs.net ([153.92.174.87]:46029 "EHLO
        vsmx009.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbgKSBCU (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Nov 2020 20:02:20 -0500
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])
        by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 43A62159D748;
        Thu, 19 Nov 2020 00:56:17 +0000 (UTC)
Received: from [192.168.2.101] (unknown [94.216.44.144])
        by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 0C50B159D745;
        Thu, 19 Nov 2020 00:56:12 +0000 (UTC)
To:     git@vger.kernel.org
From:   Ernst Reissner <rei3ner@arcor.de>
Subject: what is dirty 2nd
Message-ID: <504b3d77-3333-0b8a-b187-4a8d1df733de@arcor.de>
Date:   Thu, 19 Nov 2020 01:56:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-VADE-STATUS: LEGIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello All,

another idea to that subject:

Maybe one can add another flag, 'untracked' or '+untracked".

So it can be -dirty+untracked or only +untracked or only -dirty.

I could live with that also as i can see from the version string whats 
going on.


Better suggestion?


Regards,


ERnst

