Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737BB20248
	for <e@80x24.org>; Sat, 16 Mar 2019 21:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfCPV5c (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 17:57:32 -0400
Received: from mail-yw1-f43.google.com ([209.85.161.43]:44311 "EHLO
        mail-yw1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfCPV5b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 17:57:31 -0400
Received: by mail-yw1-f43.google.com with SMTP id c4so10083242ywa.11
        for <git@vger.kernel.org>; Sat, 16 Mar 2019 14:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=ln3Z83jUUB0rH7pwIJi52UM4/+QhVbLWekZXDDUf1V8=;
        b=krsbkVOum76/wJeFAYXhaK2mhH7VW1/xU2PO3zswHy6UMPwqWgKoVwUMlmO2Kam0Zh
         UPm1TjeGcOxZqCUxFXsAZ7se9yN9VaB2nVC7k0khmj4zKheuHE3fwa2UjPE+wvN5+fWz
         0/nLXp8oUgMwzLOuGhPEwY7/U6fIS5CfB/Gq+X1muFWcxvct6JDqbiZWSq5QasXEyEUX
         poRDgL4+1XFLxyTp0haW61ClFnx8mvUfWWguHU8i2S74gyZs3QvlEeIqgaU+jy8Z+bKh
         0bSHkRQ4s6EADf0yGHuZBCtu1t5KoBJ7AdrhlKqTATYp4GEvDeT3WW7wgIBVlwEOPV9F
         yKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=ln3Z83jUUB0rH7pwIJi52UM4/+QhVbLWekZXDDUf1V8=;
        b=dADeY+Zv7MCZY6JDJ/Woru6WW8moc1TyeTfA7//CJqPXqRKfHmSyhvrtJAmfA2VNsz
         0J5xcM4STeLzCKTgf1FVyCWagjES0zGsnsAuYAaSIcqk/k+iqrbzUoZXr5lvOfXuCX1l
         I5Bb/Dn5LuTiPn0MYUeZVtEvQS14sOuBtWFk/CS3B3Q9Mj7bYkQfhKxB3cGsUxmkkCKr
         2dQ+vxcwJLB+Dc+iajjfERInnPpBUdRUEMzwD0EZD6QX1+/MvzjixX7XWE1zYyLktNX2
         Kw6W/8KsKr0AMAHaBpB5Kg64fLHipYe9Wo62Q1lIaCByVSX89K5o/x7VTILwBezg2/ie
         W/TA==
X-Gm-Message-State: APjAAAXBww9VjY9T+E+iJZcBohVKF/fvB5ZmGmh25lBbWBtAlKXggPpE
        ZP3ToLqYYMWNCEg8/XDo9RXzWZYEKcc=
X-Google-Smtp-Source: APXvYqyBCcsAYWDEp5/7t86dKXRUX6qg4c7e3DsFYwTK/QcmMeTk0UvrsLoX6+GgiM8scnstJ5CsVg==
X-Received: by 2002:a81:234b:: with SMTP id j72mr5949527ywj.279.1552773450700;
        Sat, 16 Mar 2019 14:57:30 -0700 (PDT)
Received: from ?IPv6:2605:380:32:495:43f1:a1::c82? ([2605:380:32:495:43f1:a1:0:c82])
        by smtp.gmail.com with ESMTPSA id h131sm2308995ywa.81.2019.03.16.14.57.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 14:57:30 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Linda Brinsfield <lindabrinsfield26@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 16 Mar 2019 14:57:28 -0700
Subject: I am working on my Excel workbooks and I need your help because I know nothing about Excell. PLEASE PLEASE
Message-Id: <22946499-2681-411A-8C39-95056D88B8CF@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (16D57)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone this is my new phone and number
