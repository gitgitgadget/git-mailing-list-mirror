Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB3B6202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 19:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750803AbdCITtT (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 14:49:19 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35365 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdCITtS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 14:49:18 -0500
Received: by mail-pf0-f194.google.com with SMTP id 67so8267881pfg.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 11:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=SzNNpdaChMDShssyNbCawpw5AX22CmEeyv40/9Lqn7w=;
        b=ZnopDCDAIm8ThP4snaaXJwU9ufuF5AGmWa4zeTEKtnsMmDLgxcXRA+S3tf9k75eUA8
         3lye7xvcTm5PV3hi5ma6lsd+8W7Nbg9pagQwWWuA9JE+L47kk9nhbP9C1iGJJAM9fu7u
         IXrCD4/gadwy0GQM7tazHhv5v133dC6mSj6hVvLZTiVSBEAwppMSM9Q/Nv3VgIgjaom4
         bC2tY2GXXNC4/Hocv5YuwQapITC3+9+taNgCY4vw9jzgcK51zPmCpQIIBUKDCNCQEHPm
         apSSWDyMa2bHhc6z7aZyP0tawHx0v4Y8w9072HtAXk8MtjcMUgbFEaEbtuWHbltyBD/V
         SbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=SzNNpdaChMDShssyNbCawpw5AX22CmEeyv40/9Lqn7w=;
        b=oW3BpFKBSqr14g23C+OGZ1QCqalJiXDZ50HADSDLVCc9RjSHnw668vAiE9ld8I+BCO
         mgo8iUfloCGMZ85knkVX6r3IxunH3n0NjDC5lj8DNGx7w+6gEg5Z5BSq8DzQ6aSYePOA
         IMwcARb4Eymnzsh6XKeebdm35g+tQfR+MUyI+ia5/zzoyMBIp2g8fPhdao+f5CGZnRdi
         TLGi/IyvSQnfcLKdZh7Si7tT7cggi7StKXteSdfieVEnNaDy5SPy50cJzHxJyqYzg1Dc
         3UaE2AuDqOX5mf1zXSZ8UfAuF82SL0dw4Kyd33rt/Tnue3WcHiMbX9dBGFcTIxIfYQIk
         nLKw==
X-Gm-Message-State: AMke39kZNsIbSGCiBm1JTEqFR/cvUt4ulxDhFdsSDg+6g9Z2TttvP7ZDXcFsMqHedtkmmQ==
X-Received: by 10.99.50.70 with SMTP id y67mr15360225pgy.109.1489088956894;
        Thu, 09 Mar 2017 11:49:16 -0800 (PST)
Received: from [172.17.58.51] ([202.78.235.156])
        by smtp.gmail.com with ESMTPSA id y16sm14035046pfk.52.2017.03.09.11.49.14
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Mar 2017 11:49:15 -0800 (PST)
To:     git@vger.kernel.org
From:   sourav mondal <souravcristiano502@gmail.com>
Subject: [gsoc] regarding microproject
Message-ID: <c25fcd53-c4fb-1d08-8b73-cd0359773ead@gmail.com>
Date:   Fri, 10 Mar 2017 01:19:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hello,

I want "add more built in patterns for userdiff " as my microproject. Hopefully I'll add some patterns for well known languages.


thanks & regards,

sourav


