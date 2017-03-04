Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63D62023D
	for <e@80x24.org>; Sat,  4 Mar 2017 14:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbdCDOP6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 09:15:58 -0500
Received: from forward9j.cmail.yandex.net ([5.255.227.110]:51404 "EHLO
        forward9j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751814AbdCDOP6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Mar 2017 09:15:58 -0500
Received: from smtp3j.mail.yandex.net (smtp3j.mail.yandex.net [95.108.130.68])
        by forward9j.cmail.yandex.net (Yandex) with ESMTP id 3C9C920F73;
        Sat,  4 Mar 2017 17:15:55 +0300 (MSK)
Received: from smtp3j.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp3j.mail.yandex.net (Yandex) with ESMTP id DF4F26240C60;
        Sat,  4 Mar 2017 17:15:53 +0300 (MSK)
Received: by smtp3j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id nFPRWztxqa-Fq4Gkbrk;
        Sat, 04 Mar 2017 17:15:52 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1488636952;
        bh=9n4ISYkAWoF3edNN8alPctZEKbAU+2Qe27jxJG8/KkI=;
        h=Date:From:Subject:To:Cc:Message-Id;
        b=ccif5z0C3nv61MDvY6NqKgaabRETYMZTItS51Zo1JcDkpbhPlcFu9pL4O84EbdcS+
         YZlA0e0NkhaFzy95mau+TOXiSQ8ebKNcxh1W6n/2+RlcidVBomm6edKA1fa5TOyEdS
         NjMuqG9iZ4rk8ZtyQ1Y03wqX/eyJNI4mLIDeXyDI=
Authentication-Results: smtp3j.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-Suid-Status: 1 0,1 0,1 0
Date:   Sat, 04 Mar 2017 17:15:50 +0300
From:   Valery Tolstov <me@vtolstov.org>
Subject: Re: git init --separate-git-dir does not update symbolic .git links
 for submodules
To:     sven@cs-ware.de
Cc:     git@vger.kernel.org, gitster@pobox.com
Message-Id: <1488636950.25023.2@smtp.yandex.ru>
X-Mailer: geary/0.11.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looking for microproject ideas for GSoC.
Would this issue be suitable as the microproject?

Thanks,
  Valery Tolstov



