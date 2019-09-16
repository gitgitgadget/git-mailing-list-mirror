Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D6D1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 14:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388530AbfIPOKC (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 10:10:02 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:34791 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbfIPOKB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 10:10:01 -0400
Received: by mail-wr1-f41.google.com with SMTP id a11so29293592wrx.1
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 07:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WUHha3OHwG0rwh7/GaVaxyQgJw8hkisCQOpYrqBRsYI=;
        b=kJQVxEgZ9WWFiqP2xLmO4bzaqBgDlYLmlOd5TuxSiFm3cmprJ+RGzwnJ5GzE+ZxiGi
         /Y6Bci0ofg5gTJWIbkCOt773Qo1BtfXS5HfFUCHkmcu1DdUHfinrzrVE7j74wTBajo31
         0E3sfbr5LuJtiAm1MNEbQlzLJYUi1xELYWX0KK8W5uJnqVHnD6KBZNX4rZ1XrPrIxzZh
         UJ+dLe1CZTD1Ohyqtc0A00xko1cuWUGKz0pQ7iEEw4l2qqt97YRGVbwyd5kIWAl7SQCR
         4L7Jfdx2dijoQ3FM6w8pPt6BM4Q3qGm3MMggJR67Djz5gGMrROUk3znEC3nC/eRgf2xv
         VqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WUHha3OHwG0rwh7/GaVaxyQgJw8hkisCQOpYrqBRsYI=;
        b=VrMucMqcKD2ZRa1dcaBdW6Y/95o3EFw+AxSWMcPwSO8CZ/p9Kt5EA1TzzsbB6dn497
         +If/stvanq6OpEnbNGegCSc4kLUUhKlQ0JZdwYFF+daO2WBOXzDx6HAE0/Cg0HDs+9Jo
         KPt9QbvxMCBBmxE1YUYs64vZBHQlVL5mNatb4e6TE2bE9IK7Ohbo/PGweb6K9FAkWaKT
         NslCOCdXHjdh6oRkgr1pcQiN7RY9dyg1eYNfM5v/1iN+gt/84OFhpdRZPdJRoCANGzS2
         cA8hKW9FyjyUeqm+WBssqlKMoh7ioZKBKHkgoSxRrXDmuhQyoReSR4PcZVQnor4qT8UM
         K2jw==
X-Gm-Message-State: APjAAAUXzc6Sku6tU9RdQnQPaH90Rho/TYmykda5oQvrKBjkaoQd8UqL
        qDNn68pilBBYonRcS04BuGVOH2xD1GzsL1r80qGN7Q==
X-Google-Smtp-Source: APXvYqwfDlMbFnJd0nlrnTF4d30E+4bCTHlXmIfP7plD535sQKvQh8/q/0kjV1mJmyTcr+9gunT474Dh+haaG5Hcy6Y=
X-Received: by 2002:adf:e2d0:: with SMTP id d16mr21379355wrj.245.1568642998621;
 Mon, 16 Sep 2019 07:09:58 -0700 (PDT)
MIME-Version: 1.0
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Mon, 16 Sep 2019 16:09:46 +0200
Message-ID: <CADMnYXC7W-6n+A=1C11yzD5OnbQ_-Ac-H7canT-kdCPZpTWn0w@mail.gmail.com>
Subject: Promoting Ethnics-Ess-Nix, a friends-based search-engine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

We texted a README.md on a new project hosted on GitHub, promoting but
not yet implementing a "friends-based search-engine", hosting the
complete WWW in the future, thereby reshaping GIT and HG also. Now we
figured we'd like to advertise the project to you directly.

https://github.com/ksemb/Ethnics-Ess-Nix-friends-based-search-engine

Please note that appropriateness is triple-solved to be necessity,
constrained to knowledge and feasibility, making this a perfectly-fine
email.

This is the first wave of a propaganda-war, false from injust-people
gets us extinct in the long run.

Cheers,
The GCHQ
