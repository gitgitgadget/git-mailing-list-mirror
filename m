Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4E520958
	for <e@80x24.org>; Wed, 29 Mar 2017 13:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756123AbdC2NUj (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 09:20:39 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35909 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755920AbdC2NUi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 09:20:38 -0400
Received: by mail-lf0-f51.google.com with SMTP id x137so8144422lff.3
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=15BdGRNzidp9EoYkEqhpWBUu2zIV23UhkxUMpEYY2Q0=;
        b=dtxzRURym79o4secFmOz9XVg8obAOYeANOO/ciA9AB5N+dz8MpLgRBnzcLPZMXDlJg
         if9YABDSSmTXeMl6lkB6zh2OIdPdc30v5mOlye4DN75rBoiuUAo87OODuheh/lV0GKAo
         +SppzNYP+8yvHxRXqGucAlShmrDAKAWRtWz6WGo6c6+jgFv/7YqlNcRz3bOrArL2Jq6j
         PDr6B0zv73Dm/8g31czVKSHBLGSGUq7lWoc6Pm+Kuo/1PyqOBuuz6Mt9xWWNRxQdNBN9
         4p+Asiq5BWB170kBMc6LG3ZGwIm1FqiLJLGeOKpA8LkcK0UXN4LHcf9baVnGOSFOHzX7
         RWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=15BdGRNzidp9EoYkEqhpWBUu2zIV23UhkxUMpEYY2Q0=;
        b=H/P9HqM/VFsnC8w8oqjPjCe7RtKLEca5ykhmiBuwS0DkP80he6sUZ0SNz3w+lpWKC1
         vpoVOBGaE+/XzgrcDMYXWpIfgVDC0Sloo2gHurWd8CsAvrsDXg4OHIrSXeVr/JDECePK
         6L5eafTV4EroO4mqSF+xAgAnWr8Mzh3x+jh0zFOA+kJIH1m5bicI+whJioOUVbxySCw7
         n9f08jJX0NDGX+6p62IjvyZVqJMNltsFNCAthGb55bQ0wRxgh9Y7rZfnyny3/R7T8wK+
         tzkklRZPyDTbNCduojOY2702hPdepD9fXZa43eC2pPzNTHg5QrkuueNIDI+0O7avcqpH
         pxEg==
X-Gm-Message-State: AFeK/H1g+sgjI16ZnNqnEG8NEiQCYbor2ovONBH6boUd1UgfkoZ9PscCyUIiKCtgc5a29VviZasrRNRWDn0q4Q==
X-Received: by 10.46.71.81 with SMTP id u78mr190268lja.16.1490793636510; Wed,
 29 Mar 2017 06:20:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.10 with HTTP; Wed, 29 Mar 2017 06:20:36 -0700 (PDT)
In-Reply-To: <20170328221810.GA3240@hashpling.org>
References: <20170328221810.GA3240@hashpling.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 29 Mar 2017 15:20:36 +0200
Message-ID: <CAP8UFD3xuaHaZQsCtgE-7sEXKjgsUdWSsup61xo_L4EGEsV5Jw@mail.gmail.com>
Subject: Re: Git hackathon New York / London - call for mentors
To:     Charles Bailey <charles@hashpling.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charles,

I maybe available to mentor. I am in Paris so closer to London.
I have no date restriction for the weekends after April 9th yet.

Thanks,
Christian.

On Wed, Mar 29, 2017 at 12:18 AM, Charles Bailey <charles@hashpling.org> wrote:
> Bloomberg would like to host a Git hackathon over a weekend in both New
> York and London, towards the end of April or the beginning of May.
>
> Crucial to the success of the weekend will be having mentors available
> in both locations who can guide people on the project. Mentors should
> have some experience with developing for Git and should be familiar with
> the process and guidelines around contributing.
>
> If you are interested in being a mentor or have further questions, then
> please get in contact with me via email (either to this address or to
> cbailey32@bloomberg.net) letting me know whether you are closer to New
> York or London and if you have any date restrictions.
>
> Charles.
>
> ---
>
> Git was the first project for which we hosted an "Open Source Day" and
> since then we've learned a lot and would like to revisit Git again.
>
> The event will involve volunteers who are usually competent programmers
> but who don't necessarily have experience with contributing to Git,
> working to contribute to the project over two days. Typically the type
> of tasks tackled would include documentation improvements, test case
> improvements and very simple bug fixes that have previously been
> identified as "low hanging fruit".
