Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA10208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 07:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeHHJ6z (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 05:58:55 -0400
Received: from mail-yw1-f43.google.com ([209.85.161.43]:38877 "EHLO
        mail-yw1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeHHJ6y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 05:58:54 -0400
Received: by mail-yw1-f43.google.com with SMTP id r3-v6so892712ywc.5
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 00:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+kZ5UjM24bQ9q8NZHn8q9jxXHr2BaRnhhHBPMujfMI=;
        b=fiZVyAa0Otb4H/sNHyRTL5LHE3daASb754xNQtEBLuKNZ3up0rO1LIVrWj5KndP7jL
         94LwLtqUWVYGyQN4KrnjJqF9pmvjQQHyZaJYg5SEZStt77FEGj/plAvvEFNF+RHRgOzS
         ofRfy6MANbJKechPge5zs5AF4XHC9KA0VVQz+im0YxkHj4ZiIJK5gVbD6trwVguGA7hG
         VFwE9FgFnAfW207dsxvz6Hov4xGYCnfWJ5GYK4bwkVwMtP/Ii8XfBE+ZU6ouxOYjlrPD
         lXEzTf9AJ4hxjPHMgyo2MjOaF0pAYVmPDtPhaqcUQnHoqc3RCHr6ZNVTvFEQEpwC8ksH
         HIig==
X-Gm-Message-State: AOUpUlFmkvwVw65vugKZgzNe+az/soyt4zkG/ntGnmW6EC5ORH2pxiCo
        g2hdVtIWAhAMAvpTjtYSExj2mpSGGpMPseFHcCGIsQrU
X-Google-Smtp-Source: AA+uWPyvCT2gzNdUubNIkM2LxJkqOrNNi0e0q96wzUYbIj7oYl70by5pvItpEsUWK9ga6CScw4yKHsS47On2FzMsN7o=
X-Received: by 2002:a25:9d81:: with SMTP id v1-v6mr818250ybp.76.1533714028477;
 Wed, 08 Aug 2018 00:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180808035854.49D69E450E@mailuser.nyi.internal>
In-Reply-To: <20180808035854.49D69E450E@mailuser.nyi.internal>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 8 Aug 2018 03:40:16 -0400
Message-ID: <CAPig+cRP-t+4nDd2ei7PNPupcWSbcNAQaqmiEMVLGh3Nwuc2FA@mail.gmail.com>
Subject: Re: Page content is wider than view window
To:     mail@bradyt.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 11:59 PM Brady Trainor <mail@bradyt.com> wrote:
> If I am reading the git book or manual (https://git-scm.com/), and zoom
> in, and/or have browser sized to a fraction of the screen, I cannot see
> all the text, and have to horizontally scroll back and forth to read at
> that zoom.
>
> Can site designer consider this in layout?

The git-scm.com website is maintained as a distinct project[1] at
Github; it is not directly related to the Git project itself (to which
you sent this email). A good way to voice a concern or make a
suggestion about the website is either to open an issue[2] or submit a
pull request[3] if you have a specific change in mind.

The Pro Git book (if that's what you're reading) is also a distinct
project[4], not directly related to the Git project. You can likewise
open an issue[5] or submit a pull request[6] if needed.

[1]: https://github.com/git/git-scm.com
[2]: https://github.com/git/git-scm.com/issues
[3]: https://github.com/git/git-scm.com/pulls
[4]: https://github.com/progit/progit2
[5]: https://github.com/progit/progit2/issues
[6]: https://github.com/progit/progit2/pulls
