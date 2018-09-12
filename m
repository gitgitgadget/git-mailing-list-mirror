Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682751F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 19:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeJKCdE (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 22:33:04 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:40514 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeJKCdE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 22:33:04 -0400
Received: by mail-wr1-f54.google.com with SMTP id d2-v6so6955167wro.7
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 12:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:subject:from:to:mime-version
         :content-transfer-encoding;
        bh=5dFYpvIfplYmNx1cT9uAJHMlvH4PIjiiIEyfdYA7pY8=;
        b=rNB4Ih2QP9pf0ns+DeNMygNeseGoy9CWrsNlcviHwdPFtClZcigmto4AhyBMIuerVz
         7vA1BzAB5jEIQP+PxnYI2v0Q4BuhS9zRoBJGeIyRzuJP/+KF52UNOAeii/2iGDi6QV5k
         T0IMNICOMeiggxkDs4U4tAVPnMk+B8DNsmxbxwlg6x9d9cC4n6q3ekysYT8Nd8eDQuMW
         WUMAoduQXxaWP3MCXYm7GtMSfInj9kbm8UONH3p+rFOnhtn/xCm1J9VAGoFYs74xB0v9
         4z75bqGQdWp2cruIzYetHmjowA+n8vkqxCQpz+Ipk67YPD/aeNr8sPB6NgYHKjeLZe70
         Hbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:subject:from:to:mime-version
         :content-transfer-encoding;
        bh=5dFYpvIfplYmNx1cT9uAJHMlvH4PIjiiIEyfdYA7pY8=;
        b=eiIys1sJFntuKqyZTP4ehrJLa+rGir1IsCgt4VW+uE3EhNA6y9NI8CHzyYvZJMEWHh
         YLipqW4gTHM7/aXU3EZHcnvhsRE4W/GVksF0Bo3hpZiWAwyqSs3XclUwztGcUk9mbqjb
         TPLAKXO5Sg9WpymHgNKOM1nDaVI4LfRE8gh/oJ5FkX2EDaj4iiBJQvvKAVAWuFK+wAya
         UkgOpgu7PA6UFmD9Ccth+FsqM7ndnQpGO5RcoOnS///Jbbtp1SlxVc2/FBFHOu4M0Xbi
         9FKgdyn/5TAoQZfOV9cjh4uleC7MOtguNYSzH+D+HdhnCM9yExr0X1wQhfF/UfsdwepM
         1Dmg==
X-Gm-Message-State: ABuFfoiQugM/QroJ+hYfvJ22KiFh1uS4OPUh9XAr3FHMGrPMUMdvuxO/
        gljVXavsHhVb/9dqy8r7G2LhhavF
X-Google-Smtp-Source: ACcGV63PulaTyfalC3yfnXygQR8wDQRYnvl1REDcj5BLm2R7U2clzda3JuonDB1rXIMjuSLjznJPXw==
X-Received: by 2002:adf:eb48:: with SMTP id u8-v6mr22592481wrn.22.1539198572052;
        Wed, 10 Oct 2018 12:09:32 -0700 (PDT)
Received: from [160.157.60.41] ([160.157.60.41])
        by smtp.gmail.com with ESMTPSA id 2-v6sm17660949wro.96.2018.10.10.12.09.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 12:09:31 -0700 (PDT)
Message-ID: <5bbe4e6b.1c69fb81.bd4d3.6875@mx.google.com>
Date:   Wed, 12 Sep 2018 03:35:49 +0100
Subject: Subscriber
From:   =?ISO-8859-1?Q?No=F4men_B=2E_Hassin?= <bnhassin@gmail.com>
To:     git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

TmVlZCBmb3IgdXBkYXRlIHN1YnNjcmliaW5nIHRvIG1haWxpbmcgbGlzdCBmcm9tIEBnaXQKVGhh
bmtzCgpTZW50IGZyb20gbXkgRXZlcnRlaw==

