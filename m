Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E7D2203E2
	for <e@80x24.org>; Sun, 24 Jul 2016 09:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbcGXJAw (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 05:00:52 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36901 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbcGXJAu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 05:00:50 -0400
Received: by mail-wm0-f46.google.com with SMTP id i5so117813173wmg.0
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 02:00:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=QveX6c8wCoGZc8yM7ASNC7EPnvqh9rVIY9Ukbqr59eU=;
        b=ar9eVE6KlH6eD34OLCw31P02TrlMIJlqhU0cv4r+jIl40UzZkDzPmnodWp6vMVoOjH
         ANYn1Po9Gn1omUhF+u7bNPDcxJ4yQPLjs8VQR2CainQ2i8lQWmcEZ4nsjEidy+XeKSYy
         nrA4hDgf+D9f/w/MpJ49BH7kteBDnhiQoJraC52I1DyE8kAYhi2jHm0F4RTLeKRA8tds
         2HeTdEv4c0Z/QuvrjeqR5NQieYtxZDyaAiBVfzK2UW4ZDY2pd3GNDR4TuAFze5RvOWfS
         E+1JZkB/RLBhH5EDZ7kypXoFa0Gdpu7GDYlHj1i9a71rdGA9UfufN3ls2aonjNHvAMya
         DSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=QveX6c8wCoGZc8yM7ASNC7EPnvqh9rVIY9Ukbqr59eU=;
        b=JzTB5sieeHlysYTb/mgQDM4a2V3AUtrUupkZIjzKvyYcWehTea6UyjzKPCB5YaSJ+l
         kMcnvSgQDLjwaYGRLvIADV7Evi8M7tHo7Ygl4H+nlVj7v2oQT/pQ/WwX8/lRogIKO62Z
         64yTrd53q21awpGT/4TnL1CtXooNbB3PqCFOQTkjUuz22WYxtKGMn72lIVaP/8tF2hUQ
         mc59+CfAfrbV/7bSR+StyJGoolepiA+9usg1hrfKWeO4iiq7rVd4tyMRCvQ8JDjNprzg
         3VIwbmov8IZ12BVlG9FEfJWDKDphdjkLPN9DfvXiWUqL3QAWz5765gJbHyl8vDn2BvCK
         7+wg==
X-Gm-Message-State: ALyK8tJk/j4SIjLo2fciVHHQTM1xn7uawbde27nqaB0dB+VnXcp1Kc6i06OcfncTIwLMGw==
X-Received: by 10.28.166.140 with SMTP id p134mr33142718wme.21.1469350849408;
        Sun, 24 Jul 2016 02:00:49 -0700 (PDT)
Received: from [192.168.1.26] (exa83.neoplus.adsl.tpnet.pl. [83.20.250.83])
        by smtp.googlemail.com with ESMTPSA id b203sm21341568wmh.20.2016.07.24.02.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2016 02:00:48 -0700 (PDT)
Subject: Re: [ANN] Pro Git Reedited 2nd Edition
To:	Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org
References: <nn1euf$h6q$1@ger.gmane.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <579483B7.4090508@gmail.com>
Date:	Sun, 24 Jul 2016 11:00:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <nn1euf$h6q$1@ger.gmane.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-24 o 06:07, Jon Forrest pisze:

> This an announcement of Pro Git Reedited 2nd Edition, which is
> a substantial edit of Chacon and Straub's Pro Git 2nd Edition.
> I spent a lot of time tightening it up and maybe clearing
> up some explanations.
[...]

> The sources for this book are at:
> https://github.com/nobozo/progit2

I have not checked the book itself; it would be nice if it were
hosted somewhere, even if using GitHub Pages (per-project or
per-user).

Could you change the description of the repository, and perhaps
adjust the README so that it says that it is Pro Git Reedited?
Have you tried submitting changes upstream?

Best,
-- 
Jakub Narębski
author of "Mastering Git"

