Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2B8B2036B
	for <e@80x24.org>; Tue, 10 Oct 2017 13:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756120AbdJJNpl (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 09:45:41 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:47329 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756036AbdJJNpk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 09:45:40 -0400
Received: by mail-lf0-f51.google.com with SMTP id k40so11605647lfi.4
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LhRxXDehVgV7lQU+tyFMZyAjhbKnSkzjsfZEm1dOdo8=;
        b=BdzFZPKGG5hpCr4x/qUsG6/gZUn7xnk5dzHx0P8IUojcS33OBLDbd8t6TYq9dcyK6k
         AY7YNQsI54wq21FROT+1wTNAl6GJqUMPQuy1/+znWo2kVbp3YckQ3XDWt7S/vdosooO0
         vDTiwHY8gsG4VcWjvxZzeKAPIo/+eTrpJvN5qXrqS/motSEIuFRSyLIS3ji8eVBRf0DO
         Q3r+pndkkF4I1qgmRGuPOsoeqTcnMp7MbS/vusgNzZKdJ9F/MiWZ4ou03CHUXhbE8dn/
         DHeqa/YDifbmMyYWVmmBOyXRkPLEVoXvyxN/scHUz6ys5rcgIEePu9jdVkHIHZYo0UkS
         mJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LhRxXDehVgV7lQU+tyFMZyAjhbKnSkzjsfZEm1dOdo8=;
        b=OcjIaJ1tgjDeTfNulcjNg+3iDe91TIbQjNAcEQxNDpl5YT9+xe3OpzD+xla9al6Yvv
         ZWYp7HGPHphpV2XfvsJkF1VYrwiZpOpd00f1OGVAh+mQmdigcL4wPG+ciHyPEHneRJ6n
         76FaJpYfS93k5jl0OVGOwk9sSjvPbMIUkqS7/UUyFwgjCVcEZiBbLdJXCTpanXdhkUK0
         W+veRnZb4gbF8kpHtxgobmofGzs4FqyeyGwq55nZDsevw7WlhGyFJ6hIeKnX2fb8rEfY
         1VwFHLHQ/fibdI+LpJL+FqGFo0U3Ucovox+mSFS9IqjQqgkUExJEFyJWgl67bTmHB+5r
         l/iw==
X-Gm-Message-State: AMCzsaWh658CJF3qD5W6bZ9OxEGBm7+TosI6jcUESdo4xDEzRoiRLfgH
        GYJDy22tWpgQ2NR4mM2igcSfIzreESDvcivD7+34Wg==
X-Google-Smtp-Source: AOwi7QCJhWJbyJczxCeRPxghgWBA5qiX7mEnksWnAeo6ug05xwuXhZv5n5MYJ0E+ouZU3JwSwo6xGpk0ImJelsQxjvk=
X-Received: by 10.25.145.80 with SMTP id y16mr5009972lfj.102.1507643139419;
 Tue, 10 Oct 2017 06:45:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.193.23 with HTTP; Tue, 10 Oct 2017 06:45:38 -0700 (PDT)
From:   Anthony Chevalet <anthony.chevalet@gmail.com>
Date:   Tue, 10 Oct 2017 15:45:38 +0200
Message-ID: <CAMnBc7=ar=v_FSdMq44r0Lo_S35tH=UQFWvfGFF4VXoTjbg4Cw@mail.gmail.com>
Subject: git download issue
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I can't download git for windows from https://git-scm.com/downloads

https://git-scm.com/download/win redirects to https://git-scm.com/downloads

Any hint?

Thanks,
Anthony
