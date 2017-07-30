Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5536320899
	for <e@80x24.org>; Sun, 30 Jul 2017 15:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbdG3Poc (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 11:44:32 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36456 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753963AbdG3Poc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 11:44:32 -0400
Received: by mail-wm0-f50.google.com with SMTP id t201so160557341wmt.1
        for <git@vger.kernel.org>; Sun, 30 Jul 2017 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FslsAH+oEE82P932K/HB7DgR23SKu2Eqnoj7LbRR8FY=;
        b=EQYibmsngO65zkfKJaH2kpvUEzZUPhBNM2vRaR9OTf1DDD6VbsXrx6ydWs7p7vubxD
         0/Rnv7AYctCEfCTr1lx3JrNsV6wl1upFSkM0BQUeAZj90KLsKBXlEitSs08W/IHaC6tN
         p8bi+Ma0RX+4k49FqxQMAajFf7nOa4rniLUbDpHbDEA6dYV+uB9IWT5eF112FlK2SGYM
         XPFkAx5tHA3g5yutYZcdBn7RIms13frHa4wlRs8E2wacmGHVKA3+UU0C5mQ5ojPSYpgS
         /JtspVTiC+PzZukszmgmrENt24D7x10Kq+JBhbrxVbcjxfJInENxAK7ABLNTTpvpw4LX
         nAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FslsAH+oEE82P932K/HB7DgR23SKu2Eqnoj7LbRR8FY=;
        b=uRZgjduEK3fzkyY79g9uG+gmHxndXKSMioHTFxf0RDY34loPXYomXTaJdvlMDGt/lY
         N6YiM+4XBryeDSrl4UtJnzNvEW30CvPxMzAyH1iQv5k5dYlzUutW9eRwSuk4TpG1MKOZ
         /IyXO/VG43KpzjymQDveEt07ranIDhq9yxYpaWLPZBKzBPWjPBm4AgNwF7HAFfh5p5ks
         PW01T8oF6PqDQJZa2ngk5o7Qrev3ougCwBdr3h/eOXYQTDDQTq7uUV+4z6oyKxtcPiJs
         fF2h/UGQ2P69XKA8X1uqFTmzMBDIvRaQVVPZvzW6dcU9R38ydLp8HnolwMl/WgC5hYYf
         Gkiw==
X-Gm-Message-State: AIVw1121B9OFXnpZ66RJvchpSD2H0JeuwRP5/9S1mpQqa7lbW3QvIWCS
        DJGUwkIMbK0+iaAtlTqVEovm4u4fOnd3
X-Received: by 10.28.71.5 with SMTP id u5mr10356652wma.138.1501429470719; Sun,
 30 Jul 2017 08:44:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.18.197 with HTTP; Sun, 30 Jul 2017 08:44:30 -0700 (PDT)
From:   Gholamreza Sabery <gr.sabery@gmail.com>
Date:   Sun, 30 Jul 2017 20:14:30 +0430
Message-ID: <CAJx6kgVnd=EGWWupFmHggJ=Vz3HOqsQ0_f8mCuA6SqSca9M-EQ@mail.gmail.com>
Subject: A repository that contains List of all free and non-free Git books
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I gathered together a list that contains all free and non-free Git
books. Here you can see it:


https://github.com/ghrst/git-books
