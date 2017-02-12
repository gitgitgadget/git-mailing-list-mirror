Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A474E1FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 21:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbdBLVll (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 16:41:41 -0500
Received: from mail5.fer.hr ([161.53.72.235]:45253 "EHLO mail.fer.hr"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750999AbdBLVll (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 16:41:41 -0500
Received: from POSTAR.fer.hr (2001:b68:16:250::72:237) by MAIL5.fer.hr
 (2001:b68:16:250::72:235) with Microsoft SMTP Server (TLS) id 14.3.319.2;
 Sun, 12 Feb 2017 22:41:37 +0100
Received: from mail-wm0-f45.google.com (74.125.82.45) by POSTAR.fer.hr
 (161.53.72.237) with Microsoft SMTP Server (TLS) id 14.3.319.2; Sun, 12 Feb
 2017 22:41:36 +0100
Received: by mail-wm0-f45.google.com with SMTP id t18so2679101wmt.0        for
 <git@vger.kernel.org>; Sun, 12 Feb 2017 13:41:37 -0800 (PST)
X-Gm-Message-State: AMke39lfAfxCAixNPalDXEF1ay0lr077PrNJ/LwU4zHE92us/R6di4WuoqAaNn5L6hF4xCKR/Upcrrz4IbT5hA==
X-Received: by 10.28.35.142 with SMTP id j136mr33515319wmj.11.1486935696567;
 Sun, 12 Feb 2017 13:41:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.102.136 with HTTP; Sun, 12 Feb 2017 13:40:56 -0800 (PST)
In-Reply-To: <8a1179dfbb7743b6b8c23570306120b7@MAIL.fer.hr>
References: <CAEPqvoxM9_Ku-1YgwNiqearUBaaYbAJcehuSwZYNNfJLQNH1_g@mail.gmail.com>
 <8a1179dfbb7743b6b8c23570306120b7@MAIL.fer.hr>
From:   Juraj <juraj.orsulic@fer.hr>
Date:   Sun, 12 Feb 2017 22:40:56 +0100
X-Gmail-Original-Message-ID: <CAEPqvozCvFqOTNPw0c1ErKoOd+Mn1WCyJr9hj6CXiWWtL93Tqw@mail.gmail.com>
Message-ID: <CAEPqvozCvFqOTNPw0c1ErKoOd+Mn1WCyJr9hj6CXiWWtL93Tqw@mail.gmail.com>
Subject: Re: [git-gui] Amending doesn't preserve timestamp
To:     Igor Djordjevic BugA <igor.d.djordjevic@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [74.125.82.45]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Igor,

I forgot to write the version I'm using. It's on Ubuntu 16.04, git-gui
package version 1:2.7.4-0ubuntu1 (--version: git-gui version 0.20.0),
git version 2.7.4, tcl and tk 8.6.0+9. Perhaps it got fixed in a newer
version, in that case, my bad for not checking before posting.

Thanks,
Juraj
