Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80DF520248
	for <e@80x24.org>; Thu, 14 Mar 2019 18:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfCNS0c (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 14:26:32 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:42100 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfCNS0c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 14:26:32 -0400
Received: by mail-qk1-f177.google.com with SMTP id b74so3940507qkg.9
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+75RkP0LlebOiwBrUEFxsOLgoNSeZG37mr/ZTKqcVSU=;
        b=SXMTKebdYK0a/HjpVd6fSpOBn49heZbAH+cq02+7e+MjXkrhVLxl8b3HWMA6h9fmHs
         7cu9ux0sy3Mgl7qJoNlEkFMo4RhGcsKdKf0HUhv9SeQ7VYQ8Afnja1uXrRZgiNEvpsJ9
         TjG+fbcBobMqaxWEsPYAE+VY9ssoIo7mFEIzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+75RkP0LlebOiwBrUEFxsOLgoNSeZG37mr/ZTKqcVSU=;
        b=sjvl1Q1yw2YecyBxtBFI7RMLSp8Ebrn12xtFdWfzH4awDjnAH0KLzjtDExdSyFh7CA
         grJkMTh6gnOvtRIWgQrZdWW2DNO+kdCkKvjIzm9aIu4ufgMYACzsV58HUzydjMKDpRfC
         KSS0X/swp+NeX+bYqKn/vATBq550kkKJg5aCQ8ST0IHqwMhymxt6HXIttt2EDOa5/R0F
         ccamLNLCPMm3MgMlYbgP3xFJ55rnYHjd8Fb7//m/7GlQ/QbDdIH/8E4kicW291hYLtiA
         7+5v9N627L8GlHCT/FDdavB6/MRBQs4TP36Q3j6wu89R6ySa7u70Mv+cX4Jjnp4naRw8
         NOUA==
X-Gm-Message-State: APjAAAWIlvwSlGXbIeKp94+SE7nEOaAq6w19wJ5m6B5RJj5iQ0LBhwme
        8k+w1lWExsWmvMChh48ZitBXUe86As9DeEGcsrRGbpanrds=
X-Google-Smtp-Source: APXvYqyMjgGzS/2e/unpxObUo3795JMMWF4QnpcQh7KkjmpEF1gAh9Zc4f5tIHyNZ49HwHUXExArYrrl6Qd7qwaYAp4=
X-Received: by 2002:ae9:ec13:: with SMTP id h19mr27683651qkg.345.1552587991102;
 Thu, 14 Mar 2019 11:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190313205539.GA30425@sigill.intra.peff.net>
In-Reply-To: <20190313205539.GA30425@sigill.intra.peff.net>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Thu, 14 Mar 2019 14:26:19 -0400
Message-ID: <CAMwyc-S4B6NzOJmGLhmfF4t-i0qD=+eKROg+4gewLxAjcgfcGw@mail.gmail.com>
Subject: Re: straw poll: git merge conference location
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 Mar 2019 at 16:56, Jeff King <peff@peff.net> wrote:
>   - preferences between Canada and US?

If you're looking at Canada, East coast is generally more affordable
than West Coast in terms of venues and accommodation. The three main
tech hubs in the East are Toronto, Montreal and Halifax.

Toronto pros: nice city, lots of tech presence, direct travel from
most international airports
Toronto cons: only marginally less expensive than Vancouver

Montreal pros: nice city, lots of tech presence, quite affordable for
venues and accommodations
Montreal cons: many international travel destinations require stopovers

Halifax pros: very nice city next to the ocean, a vibrant (if small)
tech presence, very affordable
Halifax cons: most international travel requires stopovers, inclement
weather if unlucky

Honourable mentions: Quebec City (if you want to be in North America,
but feel like you're still in Europe :), Ottawa (if you like museums
and large historical government buildings)

Best,
--=20
Konstantin Ryabitsev
Montr=C3=A9al, Qu=C3=A9bec
