Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDC561FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 23:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764264AbcLUXRY (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 18:17:24 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34386 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758301AbcLUXPV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 18:15:21 -0500
Received: by mail-qk0-f182.google.com with SMTP id q68so97741795qki.1
        for <git@vger.kernel.org>; Wed, 21 Dec 2016 15:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5S2UTqr3mY13Nqc6Efo7M/XoJsX7+bHyBPeuvy98kfM=;
        b=SsmLiqdcAW+lKX9L0yE716sWO/gnHDoi0Sv6gUDGlGDA9rRqQG8Iwh1YLeoRTlaM9f
         0bjaAO4Y+0tIswYAjjc1MgM7sIUbBNcicJhddAOBu+pMrcymMwNBUyzhAT/6W4eRUbET
         zCcgrd4Ix1YdTAb+XEklRuuphupL7m8e7gJzuMM6bmZYXalhFYs8NzZhpcGtijzFjiLH
         nXLni4qRDSTsmfMHcf7+HpLs+i2UJasCjDpswZW0m8WNEhNB6wotLIZ26dY8Le4HxR8F
         pGfZdQj8w+edA6fvPoJ4mJ+JN92Ps0U4G2lOv6fXdBKeiLmrOus89ANMzlWp8a46gzSj
         HMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5S2UTqr3mY13Nqc6Efo7M/XoJsX7+bHyBPeuvy98kfM=;
        b=m/ln5MteZHLExVMWjUioFyHgjb7PZv5rAJt3QSW8ZZHapA4r1fGnYxvJ8k0SH6mqvF
         3c6IJJspuzqn1fqitZpA7JoH6+v5Teltmmw/yFco6/mgZqvLD+o0LGk7LX1mYtzkTliq
         BDJDMT5IUIk7L4RpUVEgJZ5dzW4ZyNvQN0ipjGn2a+or0yrPnhJWV/ERPcyQLJaUUhKv
         7d/3C/nGE2KXbC8Yvb0aafsvEyfpVrjDJitbYlDiwFC93aSfzFb8578X4K0G4sdM+VGc
         PVAruEgzgGHgkR7DdWX8qz8fAW1GOXoJxSau6ykwIOZg5VZ3e7OgeCNkWK5xLqfwD4Hw
         Wx4g==
X-Gm-Message-State: AIkVDXLchcUCHb1S9UDgQQuQXCX5wnU+dAJJXK2YUS5ywAyKC0k0oI1zg4E2+r66xUkejnr5Cdse1EohDqe/a1KQ
X-Received: by 10.55.3.19 with SMTP id 19mr7141355qkd.86.1482362120934; Wed,
 21 Dec 2016 15:15:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.148.45 with HTTP; Wed, 21 Dec 2016 15:15:20 -0800 (PST)
In-Reply-To: <2284357.IWoC4bU66L@thunderbird>
References: <2284357.IWoC4bU66L@thunderbird>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Dec 2016 15:15:20 -0800
Message-ID: <CAGZ79kbVvWbdHrVhO+Lbf1snuBFyeUggsjvMGwJW=n07dgyX+Q@mail.gmail.com>
Subject: Re: References to old messages
To:     "Stephen & Linda Smith" <ischis2@cox.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 21, 2016 at 3:12 PM, Stephen & Linda Smith <ischis2@cox.net> wrote:
> I want to pick up work  on a patch that I was working on previously.
>
> I had been told to reference (i.e. footnote) a gmane URL.  With that service
> no longer being being online, what is the preferred method footnoting?
>
> sps

See https://public-inbox.org/git/
