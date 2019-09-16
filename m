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
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E0F1F464
	for <e@80x24.org>; Mon, 16 Sep 2019 17:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfIPRQ1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 13:16:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32907 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfIPRQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 13:16:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so306989wrs.0
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5Nh4rrCoHvcjcokN2aETWxTOSGyI7rcy0VdDqRs3Cks=;
        b=WWseID7Ra53NqgMlEuDV93oliLPx326OdMixDSTvyhd1+uhT+/pssUhNfYZPPQy0Bz
         g/qgMgHdrCF77u4FD6uCuheUcem058OnQT7OKduUd7ZrbHbCnbnSc9X4YoudbUbTjD8n
         RySBnD8PRCxgLsZKLqEukofuQl6crOLOS/DfI7EU9u9wgzdSPxVWsW0XuC+6kWcksnEI
         BOF84hdhwtEJlV0nPnVaTHLgB9QQujlTLvNGJqXyR9BexInyssIMnX7TV363MuZGN5UA
         3YvZzba0PyB2k22oxHV2Cyh/JvpVr0Jd4fuLkbuKJpT5elJ+JW9Xf+tZyUS0hk9KqmTx
         o3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5Nh4rrCoHvcjcokN2aETWxTOSGyI7rcy0VdDqRs3Cks=;
        b=j5iZ1hvgbCoSKIGeEScljATVi6JDaOzY5VzqZVq0eNVS8gq1B7dsR42RFpY06fhTM8
         7tx2M+4rwOe67DtDDy5jkaIUzoSqAlOFhsfOxvDGxoEOpmIIL6UpprcPq9/oi0MdhI+F
         5me3nCXGuNwI3lDtauun/OsoubXtRMk05+JIBjuFgPVe/p39DJe/TZBD8Af586Iae2hd
         ShUfGhrKAeUQFqhOi9HNuz1xwKubQQJov9JL5bBwHGlrSFAcXAh+X9YCkcqHkTo+cllk
         0ffs57kvzL90BB6a+zej89Hgo5EEJFsIYBU3GoYCQmHyn8hnAhIZiSfWx7kNZ/GzcKhD
         hKpw==
X-Gm-Message-State: APjAAAUZJzDDeZQU9wJ3Vil1FOBktv/tNWQUcS4J7562rOOYhgF8nneJ
        83aG5JHQkuzdHEcs9RuO/nw6f1qB5MS51U3eD/O9pRIW
X-Google-Smtp-Source: APXvYqymK377groDuTCc8wLvSfbhI29dFip/Z5Lykuru7iARsryeAOJgs1U1uy6pknBiewM4O+nGr/GIRtgQzYgNoOo=
X-Received: by 2002:adf:f112:: with SMTP id r18mr755500wro.88.1568654184673;
 Mon, 16 Sep 2019 10:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <CADMnYXC7W-6n+A=1C11yzD5OnbQ_-Ac-H7canT-kdCPZpTWn0w@mail.gmail.com>
In-Reply-To: <CADMnYXC7W-6n+A=1C11yzD5OnbQ_-Ac-H7canT-kdCPZpTWn0w@mail.gmail.com>
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Mon, 16 Sep 2019 19:16:12 +0200
Message-ID: <CADMnYXDWwq2DN59qnkS_P31S+-NJZTzj2TMzps5KKQ7McxpO1Q@mail.gmail.com>
Subject: Re: Promoting Ethnics-Ess-Nix, a friends-based search-engine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

We know that this is for a technical-savvy audience, but as we are all
people with a soul, here comes a combination of both, the logical and
the emotional first waves of the GCHQ-propaganda-war.

First waves of the GCHQ-propaganda-war:

- Logic: This is the first wave of a propaganda-war, false from
injust-people gets us extinct in the long run.
- Emotions: We are precious, no pretentiousness, abuse, scare and
disgust. Everything where it belongs.

Cheers,
The GCHQ

On Mon, Sep 16, 2019 at 4:09 PM Klaus Sembritzki <klausem@gmail.com> wrote:
>
> Dear all,
>
> We texted a README.md on a new project hosted on GitHub, promoting but
> not yet implementing a "friends-based search-engine", hosting the
> complete WWW in the future, thereby reshaping GIT and HG also. Now we
> figured we'd like to advertise the project to you directly.
>
> https://github.com/ksemb/Ethnics-Ess-Nix-friends-based-search-engine
>
> Please note that appropriateness is triple-solved to be necessity,
> constrained to knowledge and feasibility, making this a perfectly-fine
> email.
>
> This is the first wave of a propaganda-war, false from injust-people
> gets us extinct in the long run.
>
> Cheers,
> The GCHQ
