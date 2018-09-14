Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E76D1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 18:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeINXxi (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 19:53:38 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:37291 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeINXxi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 19:53:38 -0400
Received: by mail-qt0-f177.google.com with SMTP id n6-v6so9649123qtl.4
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 11:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kw7b7WZUcqMUPFwQ49/Xlnn/P74xDiCqu5wai96+iDg=;
        b=Ik2FGToDGiX532vtVsF44gUx/WAABAzqtYX0EOcINXLdhwhKhz8H4nAwHZhK+Mh6ry
         GJnMR2mmnAizetCgScHcrUPLSqrndsBPtYukP3OqUfe4wQLGD0TX2Bxx5dDAxceIGd05
         VjIIwG2KxLZLyXbM6gJEp7oiq7ovTQ4zMy5E75vvGDuMoGh49tHLsUuajQqnpHTR18TG
         HtTqOOsuwXHICqtspFp0zS+M63Fv08I5vblrCz+gG/eMLKh28tGYnNW4bid9tmUz7blJ
         DwzKH0lzwQKnSnPb8hJYrXYkn5CWWziZbtN1zudkJlrsb3iE/tyog91JMUvMe6b13t5f
         po3A==
X-Gm-Message-State: APzg51DcJvcKkx1mk9ZTvhLxFNxUoW8106mtXfG7ic0m0agAYRTHIa6T
        G4M0EM/EMf6HJSUk+2hJZnu4pjxLCEZaBeiiblY=
X-Google-Smtp-Source: ANB0Vdbarty6hEH26foxZ002t+00Xqo32+zagBT1nS6MsmBrmZfU7WD/H9vquxFical7TwSfwX3Gm/6c6VtMHYwakS8=
X-Received: by 2002:a0c:e5ce:: with SMTP id u14-v6mr9694005qvm.6.1536950275173;
 Fri, 14 Sep 2018 11:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180914144512.1267-1-taoqy@ls-a.me>
In-Reply-To: <20180914144512.1267-1-taoqy@ls-a.me>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 14 Sep 2018 14:37:44 -0400
Message-ID: <CAPig+cRNwdU6QJpbZiiwWcL5e8zqO3V72ex+_p_SxjF77YX3iw@mail.gmail.com>
Subject: Re: [PATCH] refs: docstirng typo
To:     taoqy@ls-a.me
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 14, 2018 at 10:45 AM Tao Qingyun <taoqy@ls-a.me> wrote:
> refs: docstirng typo

Typo: s/docstirng/docstring/

> ---

Please sign-off your patch. See Documentation/SubmittingPatches.

Thanks.
