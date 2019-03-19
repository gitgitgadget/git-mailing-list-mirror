Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB61C20248
	for <e@80x24.org>; Tue, 19 Mar 2019 16:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfCSQEB (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 12:04:01 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:51373 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCSQEB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 12:04:01 -0400
Received: by mail-it1-f178.google.com with SMTP id e24so26830399itl.1
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 09:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7OH9EszeEO45PmqLAE1waTijsMdaK60Xb8VdLsyoDkM=;
        b=nFJ8+em147AplR+CsbdpJmKs2EfW6mMQhAbOrYaqe+NUyzEhWRg6zv0SSVS58V8ovQ
         /lFbCvBQbD/DfGolbX3oagKocLOhUiKghIHBIxB0Zic6zVaeRQopt4Y79wAA8gXVF2Ik
         B9qq1CVTfdV3lLaGzNJEugBNcuN3o6iIy4uSZVhTImnFO61IwWsTPr+rKPfr//dFftLT
         XHkc3mLEqCloWrcL7z0RSyXUUlZSw01SJm+1LZFlaV3woifKSBJDZ/lC19sk/DhRAMt0
         K0NBslQX24IzqLh19gQnwGVLTVADR+QYYe4bgDFzRuKr7aahd242SL8e/3Y9dDbf2iCZ
         4rRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7OH9EszeEO45PmqLAE1waTijsMdaK60Xb8VdLsyoDkM=;
        b=roVdzAXqt57fDnNYffigqUkSPeh+/s+szO8Z7Q+qOxlFtFFMExnlz3Opin1Dvzjqgr
         OjZiUJYsftADpIKVJqwkEIyyCc6pN6LWbdMNOQZ7oQQzUhfVGIsSIE5fBvfDScDu0Zqe
         amts94L4aFq3FOZf8/sxRoAypq1Os9Z7EFIzNyE9agbUmuV3EdFbrB6f9ndmSLNtmrX0
         gTsOyRv386ofQ6EJZ4RxPnAspM5FjHzbpoK6YcQObZX315B8uog/9fzQgvC02Hb7ILWs
         cqh1gOpuqQkOQMuPJCHRDeN6Mop+sw0DPGgSEVfnKuca3tQMzVIygAGPg00LEyfkIaka
         lIOA==
X-Gm-Message-State: APjAAAW0eAdqX2px6f/LxJ8YLJY5eegjYRsres2Bv9uekXCPSiyWWyQF
        1DLM18frz4ShwMGyDCwLNV3ZUaRnP/GFhNEZ5e/DiWdS
X-Google-Smtp-Source: APXvYqzQ2qBUqF8ZaT6JSKyCCJKiDVGfZgyV+cfye5HXPSg5WW1mGOUILoFQc944Y5BLBnlb/z8qdoJ6l9bmSIbThbs=
X-Received: by 2002:a24:ac6e:: with SMTP id m46mr1949910iti.49.1553011440464;
 Tue, 19 Mar 2019 09:04:00 -0700 (PDT)
MIME-Version: 1.0
From:   balaji marisetti <balajimarisetti@gmail.com>
Date:   Tue, 19 Mar 2019 21:33:34 +0530
Message-ID: <CAKcrOwe2ARK4J6YuiXUiVXic=q568VC8JtgWMNs6WEd4hhZs3A@mail.gmail.com>
Subject: git command history
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

Can anyone please tell me if there is way to see the command history
of a local git repo? If there isn't a way, why hasn't the
command-history feature been implemented?


Thanks,
Balaji M

-- 
:-)balaji
