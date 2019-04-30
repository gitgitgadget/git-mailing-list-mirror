Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408961F453
	for <e@80x24.org>; Tue, 30 Apr 2019 18:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfD3SKF (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 14:10:05 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:40599 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD3SKF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 14:10:05 -0400
Received: by mail-lj1-f176.google.com with SMTP id d15so1714957ljc.7
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1MKpJ4WGK3/L4jJXZvTfp3jZv/ca4N9EOSav+AmvU4U=;
        b=OB/CFlkmLaCxQ4oZ4dg4Wnm05STGKhkPbKx7ZgGBenYEkDhNkjOh/VjnKQsm6CA64V
         azF3sDHrZGbnSU09M8mHL69TN+Tilau5ynaovf+R1NlinOE760kVnC4nN5R2fEGpasCd
         ELibf6G0POEZEGRNDgTX/DRJMZL25vtCb/9Bh5W5Z+DDgqYAOHuDm41cDJipMGkIwpTS
         UOvPhETvbbWwHRoSOi+LpFUxtN84zT60rUMseYu21xh4yrvl/XC1YDxInq0Fre5M7AGn
         7rBM8nsmgeIRF+yTSCtVqHaGfDZS5JEM2PDZ41UCFermpkDUA9XWV7OQO7f3vsKODYQZ
         7lWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1MKpJ4WGK3/L4jJXZvTfp3jZv/ca4N9EOSav+AmvU4U=;
        b=DF8t280d5GNMf3iAuZKirUlDxC3an60ZLxvDLJAavzGF8sx5Nrs0N4bhyHl4IqCeOI
         QA2Goop+g1fo8PWg4RJVpNLX7UzoMfkrvLzwjMN4geKUUcVRCjx+NFUGo1zN+8kfHAD5
         FqEQFa9X19GJuVu1oLe2F3+GMy61u4dvhEPo8fA1b1TxeObiqKjGadrtOZFsG8XC5l1d
         RhooU6oUhKj2wChUgGF2cOy+obUEpeo782NSDkAIvTDl3/4cYlNZGBrB1yOiiscHOma8
         jZ7ejarXni0FZWQvoY7ZrnxPiiSmrJw/kZCYxBvQOdt1rLM9C5ncWgn/ASHbmgeShA35
         Y27A==
X-Gm-Message-State: APjAAAW5phTE3UELzfOH6z9Xk95qOkxEt0YSsAX8trD5ax9LBxi6O1XT
        Pr2qW+G9zbD1VpUa41yn/gq1Ll+kekGvJumND1Jzb902
X-Google-Smtp-Source: APXvYqymlmcSFHe5b5RvYYCShFVs3gh6l2kS+tsYy2iH/wcNoRGdjvSa7E54f9nT4y4qxGCtMkIjnnHZTNlhH8EXpv8=
X-Received: by 2002:a2e:d1a:: with SMTP id 26mr8943329ljn.147.1556647802732;
 Tue, 30 Apr 2019 11:10:02 -0700 (PDT)
MIME-Version: 1.0
From:   Priscila Gutierres <priscila.gutierres@gmail.com>
Date:   Tue, 30 Apr 2019 15:09:51 -0300
Message-ID: <CAHtYWY4g4BYDr_z7pfS-p=aX_YkVo4HzGR1Dsytn4RkzBo0GjA@mail.gmail.com>
Subject: Contributing with documentation/translation
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi
I want to contribute to git by creating and/or translating
documentation. Where may I find the info to do this?

Priscila.
