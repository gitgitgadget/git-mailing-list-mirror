Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6931B1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 09:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754055AbeGHJJL (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 05:09:11 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:39188 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754030AbeGHJJK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 05:09:10 -0400
Received: by mail-yw0-f171.google.com with SMTP id r184-v6so223695ywg.6
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 02:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxIU6bC8SeKiPg4zQsfzf2lLugCumpXzDcCu9HtHLD8=;
        b=XUYWV8PbEjsPmp92z4ft2d78xNwvGUtpoyEbbraVvYZeZANH+rgUZkZMfKdTi8L8gB
         4+WUTHhtEE8THmU1J1e0/5EId8KqVDZWrJw09dQTm7tm4i5X4+MFy21lrq3FlQuD17qH
         q9pKMkz7SEA0wwhU7zDCxdReHfCWhjXH3pypro0WjlbzRSYQluj/qTYW8IK5QhmbMsEr
         oZJ+LgfLfQ2sHSIlz/YiP9DqGomPzfgi4pvpP+Vw8qRx6JTVe1zkL7HMCC+IUUu4Z6Fj
         RS3a9v8ornOpU3JG54MUJ9ABDI9iGFUDWnn0B+YIE+FOSebFzpavl5c3MIFxWoMUjgW9
         z+Hg==
X-Gm-Message-State: APt69E2p4fn3j02ATkJKO2/3LVlzQfjcPt0VyjunJzJd8x34sVGLZQau
        TN8TpcPLx9KIuW2tGA5Auvv+5r4Hnan8lEk3O5g=
X-Google-Smtp-Source: AAOMgpdzpmf5xM1DNKKjHRM6ntVDvgjV0iOI2m/pZNwluy2UCtbWkWUO0KfzgwH6sEU1t7dk2iTYFH/6b8dA4apg9C8=
X-Received: by 2002:a81:7bd4:: with SMTP id w203-v6mr7988752ywc.70.1531040949999;
 Sun, 08 Jul 2018 02:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <58c9972c-55c8-8fd7-71bc-97f2f11d519a@optusnet.com.au>
In-Reply-To: <58c9972c-55c8-8fd7-71bc-97f2f11d519a@optusnet.com.au>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Jul 2018 05:08:59 -0400
Message-ID: <CAPig+cSnBF0Kx7d+Tc2O+CpOniDLB9jaQ64nDwEzW3KX_6wSRA@mail.gmail.com>
Subject: Re: Croatian version of Pro Git book
To:     josipzamboni@optusnet.com.au
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 8, 2018 at 4:23 AM josip zamboni
<josipzamboni@optusnet.com.au> wrote:
> I've noticed there is no Croatian version of Pro Git Book and I'd like
> to produce it. If you agree, do let me know the contact details of
> person(s) I should be dealing with.

The Pro Git book is a separate project from Git itself. They have a
general guide for contributing here [1], and a guide for translators
here [2].

[1]: https://github.com/progit/progit2/blob/master/CONTRIBUTING.md
[2]: https://github.com/progit/progit2/blob/master/TRANSLATING.md
