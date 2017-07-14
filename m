Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2860920357
	for <e@80x24.org>; Fri, 14 Jul 2017 13:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753912AbdGNNnW (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 09:43:22 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:34904 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753634AbdGNNnW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 09:43:22 -0400
Received: by mail-it0-f43.google.com with SMTP id v202so21326361itb.0
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=twAtVuGxQG1C3tg2SqnuMgQqedn8VY2lom0IeC9yoPg=;
        b=Mj9fGnBGp5asjvIFKsmX4E/+g3IG7TOMsndDCrWbLsyWpnsNwoa2CTSZWsyjaVTbG0
         HrTP4+oLZVuvOLDWMVTJLoZQL1hIaO4hW+1RqkPr7jtVEDUEi7VjV/9PFn74LL6xyIQC
         Hu71GJtgxjTZYod1Z9PdUWgsTn4Ao9ZUleOHi2B60BhuN54fDPCEXF+ut7h+Makx0ehM
         COv5Vb6qvlEC6Xa37O4+URnY/XAoYMHDJ6GzxkL55dU6hd5fJpeuKnUEEggsx7omdoXI
         LYGEowaAt7oecdcv+6Tn8Qts3Qo8ZgJS3TO7DlWvFINrh1IAsgSlKnwirvbg//OU8mSf
         KWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=twAtVuGxQG1C3tg2SqnuMgQqedn8VY2lom0IeC9yoPg=;
        b=qgrCWkMixAyBgut0fjoe+FgBeBOBUsgYTfLPHjxzUYSZ/MU/69ntxvCF7+sFyMvTCK
         AVsf4VKbFcPPL6Djy9RCT4bvbcqwANokfXaaBNVw197MKZltzOuNVxxZG3DqW5rIQcZI
         JJWzeO6Mc3GjvQrCUAZVUIYzMYl5oooM6/aKzkHbe8PGSzsutULKbHuxhOYJI6VYBGJf
         JUy+Y9mk+kx3T2V3HWvnUAvws1Ocrcm0YmSpICtnFFQLp07DR4w2lj6zv9N6Twv8OTSU
         jggPmAZsTcXhvXzvLJgSvg6gOa2oof3+yS+4rYWQN5bh2+wZXjG/pQrL8APWyKHMCtWp
         6VEA==
X-Gm-Message-State: AIVw1124Mkrnl8C8wOi3yczHK8ojaMcGrs1vQQsCyPfUeANYRT2MsVHe
        7fNSUzCn0Puo2lfnFh/kLSs0uQgwRMgetaI=
X-Received: by 10.36.66.2 with SMTP id i2mr3470818itb.39.1500039801137; Fri,
 14 Jul 2017 06:43:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.34.16 with HTTP; Fri, 14 Jul 2017 06:43:20 -0700 (PDT)
From:   Kavita Desai <kvdesai2@illinois.edu>
Date:   Fri, 14 Jul 2017 08:43:20 -0500
Message-ID: <CAAu0pLedy5xqUgF7drMf=tQgMJD4rXq+JvKaiE54EdRFZWuTkQ@mail.gmail.com>
Subject: Git Bash Bug
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Originally, when I first had Git Bash everything was working
perfectly. Randomly one day, my bash commands were not working. I
uninstalled Git Bash an reinstalled it. I have been trying for 3 weeks
to get it to work again. I am working on Windows 10.  I have tried
editing the PATH variables and the PATH environment variables and
nothing seems to be working. Do you have any other suggestions?



Thank you,

Kavita
