Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,BODY_URI_ONLY,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB1981F453
	for <e@80x24.org>; Mon, 11 Feb 2019 13:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfBKNgk (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 08:36:40 -0500
Received: from forward400p.mail.yandex.net ([77.88.28.105]:46874 "EHLO
        forward400p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728162AbfBKNgh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 08:36:37 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2019 08:36:36 EST
Received: from mxback10j.mail.yandex.net (mxback10j.mail.yandex.net [IPv6:2a02:6b8:0:1619::113])
        by forward400p.mail.yandex.net (Yandex) with ESMTP id 765EC1BC0D8C
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 16:29:31 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback10j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id NerTXs67yb-TUHWWh8f;
        Mon, 11 Feb 2019 16:29:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1549891770;
        bh=Mvkv64aStWFmw+Ybxqen9Tv4+ftd0v7KHH3dkjFfIK0=;
        h=From:To:Subject:Date:Message-Id;
        b=U5jmUq0QYr/LV/+JlDLMgsWIkm9fGlhwPkJdUMMDcwGeZMsY0tK85zB5Qct6ueiPK
         qQXaeFQy3jDpjb7myPcFI8v3IssHwBw2UfyFfBuzQ+NRi8pJyWmFctXvrDfciHWFkY
         UOV+9KFfheivEeT7BOfCLXvOpKRzOFs4NNMcDdZM=
Authentication-Results: mxback10j.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by myt5-96980ae04900.qloud-c.yandex.net with HTTP;
        Mon, 11 Feb 2019 16:29:30 +0300
From:   pm <pm.ittown@ya.ru>
Envelope-From: pm-ittown@yandex.ru
To:     git@vger.kernel.org
Subject: git clone by certificate (known_hosts)
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 11 Feb 2019 16:29:30 +0300
Message-Id: <2168701549891770@myt5-96980ae04900.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.
I have trouble.
https://superuser.com/questions/1252276/cant-type-during-git-clone-putty-connection
