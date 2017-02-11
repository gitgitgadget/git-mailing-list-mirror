Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801701FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 16:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750753AbdBKQdc (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 11:33:32 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35123 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdBKQdb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 11:33:31 -0500
Received: by mail-lf0-f66.google.com with SMTP id v186so5134503lfa.2
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 08:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=dsL0vnfw6RbDY7BSXUCOT+9wgoM29z0/QYhQ3OhioL4=;
        b=ODJdrSn+1lD4DX6xh4ZHGjwjLAL88PKPYm9od7vAeGsJiW+J0HEL8ZxRZ4W7KXLlRf
         zr3UOHunkXzxlxWg0LuAPHYOTCRaJdLW5UEDxuQoCkdHkMBNkVFtaNyytGoPPiC/oFPm
         SR6XjZrnLFE7/Xnir7TG/pxBTZirJQiIDMKeO2jjmI8SKos92FUgS+pmCAycO6QmeB7H
         22b+0s6+7ooGyou4lnUel0SoSyCoviFxplYFRCLrWmWzaOybODl5ayphRVhTBWsCNvF2
         Rs/7qKdPfe3KRum0AJoeFXVatnw4s1AignqGllUS8tXSnvWGgkwckeCrNo5AaR2Hcl6z
         A2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=dsL0vnfw6RbDY7BSXUCOT+9wgoM29z0/QYhQ3OhioL4=;
        b=jZ01avkL4ZReUZ198MMnepUro3XvirZknUfyki2VYTHpeVKt8cjSAGpjh6yZNwknWn
         xmhqTPzmzNOCWmKKtJrubYr9tYSz8stOLeB3C9P5/nEecSRlBNumngp/JPYXBzJiTksU
         gVPycz5D/ngug22FgB/TnMgmqvYbf1U3IZiGGpsSk8Ptw9qsgjJkzv/anIQajx6r4knc
         2lfabz5OoR9uY8Vs7mknYGuL7/QVgq+9K+hlXMru/N/AxgsCM/Ys5pJRe7MLsE0HG5vO
         fLzgynwX8mDfCEyIhEf/yXoYE0kqjXme+AgN/lHMIqwiJd/8g6FcdE7iDiJ5h9cDFSAi
         MKCg==
X-Gm-Message-State: AMke39m/iV+LY8xlHxikd+Ie61Guc9h8g1f59eiqdhTmgdl5Bh4BATQzSsOqRhCz7jjtXQ==
X-Received: by 10.25.212.141 with SMTP id l135mr3928478lfg.48.1486830809345;
        Sat, 11 Feb 2017 08:33:29 -0800 (PST)
Received: from [192.168.1.26] (ewz196.neoplus.adsl.tpnet.pl. [83.20.249.196])
        by smtp.googlemail.com with ESMTPSA id u30sm1384782ljd.4.2017.02.11.08.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Feb 2017 08:33:28 -0800 (PST)
X-Mozilla-News-Host: news://news.gmane.org:119
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: [RFH] Request for Git Merge 2017 impressions for Git Rev News
Message-ID: <8b6e998d-2bea-924b-42e3-936dcd9a2995@gmail.com>
Date:   Sat, 11 Feb 2017 17:33:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Git Rev News #24 is planned to be released on February 15. It is meant
to cover what happened during the month of January 2017 (and earely
February 2017) and the Git Merge 2017 conference that happened on
February 2nd and 3rd 2017.

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-24.md

I would like to ask everyone who attended the conference (and the
GitMerge 2017 Contributors’s Summit day before it), or watched it live
at http://git-merge.com/watch to write his or her impressions.

You can contribute either by replying to this email, or by editing the
above page on GitHub and sending a pull request, or by commenting on
the following GitHub issue about Git Rev News 24:

  https://github.com/git/git.github.io/issues/221

If you prefer to post on your own blog (or if you have did it
already), please send an URL.


P.S. I wonder if there should be not a separate section on
https://git.github.io/ about recollection from various Git-related
events, with Git Merge 2017 as the first one.  This way we can wait
for later response, and incorporate videos and slides from events, as
they begin to be available.

P.P.S. Please distribute this information more widely.

Thanks in advance,
-- 
Jakub Narębski

