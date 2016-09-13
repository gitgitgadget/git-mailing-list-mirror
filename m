Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7AB20984
	for <e@80x24.org>; Tue, 13 Sep 2016 17:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755204AbcIMRSz (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 13:18:55 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34519 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbcIMRSy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 13:18:54 -0400
Received: by mail-qk0-f180.google.com with SMTP id h8so94377580qka.1
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=FfPInELZa+uUFr7zKy1L5R/fskD+aDw9pxP+AlxzIBU=;
        b=Ba2okui+/F6XWR33/SIviwUMlOG88jdSqa346JVXwkRUM9xtqSvqIwfTJSbTxhssBh
         3ardRr3DQ47GpasHVhwgW9f+TVkWFZx5+NxIyKeRu8MOj5EiDG3K7JNyp38O3ndcn6HD
         4EKI72cmI7BxF8Hm9hSlwMod0aR437kGjEK6Qyf4R3gYN1ZbtckEFMr7AsaUcTkhpDB8
         pufCk42jVE9Ddgi/W7yUu8+30/XtDhJ5UcVxTZchXMKLh6DXX9Wzal9ZLxTe4pIwh+IM
         qx8+SnNHu3qehRoN9WWlZxH7xVxfBm7u5f1JGSa+/6uqJPinRpx84F4Z+9uSDon/efLZ
         twcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=FfPInELZa+uUFr7zKy1L5R/fskD+aDw9pxP+AlxzIBU=;
        b=hnOkivDEOKglhduqq1IKT64OxV9Ag6ysoAgALGBmgpOeMkWPwIRrv74MT2Nkn6SeQw
         PpqIOyI9pSYaSvdU8cLxG8go6WIRiaFtECvgiJYygLTIEuuRchsO8Qi4AE/6R6JPXhUd
         U+WOormM/rIUt52QhsQjWkqDihO2fdV7YYVMdv0VMGZbKPx4wnwhiesyMnhhe/n3qjXT
         W6e4VSoZ0ZLLJLX+1wr9LTyo9CSdsb9tq205LwxKFoHOm9uedoLGkRmQ7uM5ARhj0XQo
         fRlcjS76yKqdOt5DnlTQ4ihr3/+dqiB4arXShnrR/9k+p5eep7pHw3eDoOdO2dcNujzB
         QnBw==
X-Gm-Message-State: AE9vXwPjiFKc30Y9i8juscqy9sWbBnjzZVwm4iKIeSB6RKZUPtc3YsECzppGTP8bzTI44w==
X-Received: by 10.55.18.148 with SMTP id 20mr2492433qks.210.1473787133939;
        Tue, 13 Sep 2016 10:18:53 -0700 (PDT)
Received: from ww205128.wwnet.wne.edu (virt126.wne.edu. [198.7.235.126])
        by smtp.gmail.com with ESMTPSA id c64sm13983105qkg.43.2016.09.13.10.18.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Sep 2016 10:18:53 -0700 (PDT)
From:   Mike Hawes <mhawes24@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Bug
Date:   Tue, 13 Sep 2016 13:18:52 -0400
Message-Id: <B1BB8E37-C36E-4F4A-BC5F-FDA32CE162AF@gmail.com>
Cc:     mh351681@wne.edu
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To whom this may concern,

I found a bug in git while trying to push my website.

I redid the process and it happened again.

I also tried it on another computer and it happened again.

I was wondering how to claim a bug?

Thank you,


Michael Hawes
