Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_05,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889C1C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 05:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A07611C2
	for <git@archiver.kernel.org>; Thu, 20 May 2021 05:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhETFb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 01:31:27 -0400
Received: from mail2.dravanet.hu ([109.61.0.142]:48674 "EHLO mail2.dravanet.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhETFb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 01:31:26 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 May 2021 01:31:26 EDT
Received: from [192.168.0.108] (unknown [109.61.91.19])
        by mail2.dravanet.hu (Postfix) with ESMTPSA id 370BBC49A2
        for <git@vger.kernel.org>; Thu, 20 May 2021 07:22:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eqnet.hu; s=20210419;
        t=1621488154; bh=crpgkR3c4lwZEGA4NmydhjRICt3dnaxhVzV3IWICfuk=;
        h=To:From:Subject:Date:From;
        b=ilan2WCF8eZ+7slt4cgyMTNUi1QcZxczCg6mc26HiSvhTGZU6rsO51eYykf1br16x
         4/fl5XHI1qW0VNjzWai7F8dx7FnhnUzzD/FthVDpMMuQ/Y5l8jPjfD4qo7sLkypWIV
         hUailtTuCU89E+wDSrf6fG+0qOvYentDIELRAoHaQBozhb7LeCd7jMQaKEonfGFbcI
         hQGrTe4wM30MFx1ZufaZr03Ots8QE8wudX0n/p2CSJMrzc4T1IBMG12Qqxk3khvJq0
         rTyyRWCUAKgjF4g2a+99Rln1KeY8XHgP1EuFroJVWRAI6rKMibH3WvSq477WcDRwpY
         MDhdW3HISw6QA==
To:     git@vger.kernel.org
From:   Somogyi Henrik <Somogyi.Henrik@eqnet.hu>
Subject: getting git.exe for Android Studio on Windows
Message-ID: <773cf7ee-f897-a568-92be-9ee7c2813c3b@eqnet.hu>
Date:   Thu, 20 May 2021 07:22:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: hu
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Community,

I have just learnt, that I can dowload an Android app example from 
GitHub into my Android Studio.

But I do not have git.exe installed on my PC yet.

What shall I install on my PC to have this git.exe?

I wish to install only the bare minimum needed for downloading the 
example. I would like to avoid the install of a fully fledged Git with 
all the whistles and bells to have an own "github" on my PC.

I do not find this info on [Git - Downloads 
(git-scm.com)](https://git-scm.com/download)

Thanks,

Henrik Somogyi
