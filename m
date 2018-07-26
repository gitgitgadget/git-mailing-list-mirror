Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31D81F597
	for <e@80x24.org>; Thu, 26 Jul 2018 08:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbeGZJq1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 05:46:27 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:47033 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbeGZJq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 05:46:26 -0400
Received: by mail-yw0-f182.google.com with SMTP id e23-v6so291338ywe.13
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 01:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpNcymr5oLeKge+M3XYSMe32Sby+I6RRkHItIPDqz/s=;
        b=PsjtUyeYOdKR4PM+EtbD60lcOcOZ0TeOVaUB7ogigq3z+1fRAAWwQaiyBavVNkhTP6
         HNk0yheEfCDTer1eLQ5hVC9o0GD3bSagtHOmiQsGSQJ0v4xALN1YL1SzJQKKVV4JhJE/
         PWpYqWUTBVWXX50jvZvQqai4siNhYI64T1zfYiEUSSq5kEi86Oers9be13JOzP16T8xQ
         Bo6+Oyi1lPA2KxRpQVsslvDTEgWjmYxuYnIZ6saxLRddNHs6R2AToWyzU0JvnCPw2qo9
         SlOY2X17yhB9KgkbpG1jr5e3s7E2xNlBJz9ZInNw8Oc8pSzITdjRH8pv77GqyvBiKClm
         /L3Q==
X-Gm-Message-State: AOUpUlEoqFKrPhD6rZ5PaYk5+kVWIdJr+xptWNwIbD0ns0DLofQBL7Zv
        fAoHPgEbKxVG29DDBJfLnqO6KvQlTNVdzMowUS8=
X-Google-Smtp-Source: AAOMgpcK8CKVwaGn/c6cW8smMyZXAb8epRe2+Znp2hBzfY7Z08Gok/qGEQ3iQI4FbMJeAzuKOS4QsxKcMANS2u80ulU=
X-Received: by 2002:a81:7bd4:: with SMTP id w203-v6mr427669ywc.70.1532593841437;
 Thu, 26 Jul 2018 01:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJhF8Cok2sN4jv4K4PCPk2_Fyc6BHaLbdAvEOuFwg4EdN7Y3Yw@mail.gmail.com>
 <CAJhF8CqxqVts9weOgPfEzb=LJXRPHZc80r3ewWFa_dkA8mxXRA@mail.gmail.com>
In-Reply-To: <CAJhF8CqxqVts9weOgPfEzb=LJXRPHZc80r3ewWFa_dkA8mxXRA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 26 Jul 2018 04:30:30 -0400
Message-ID: <CAPig+cT_cSjwpwxA_WMVV06=3BnYA9i1Lg6KzHbU9nb1_fF7vA@mail.gmail.com>
Subject: Re: Git Help !!!
To:     vkamath2018@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 26, 2018 at 1:01 AM Vishwas Kamath <vkamath2018@gmail.com> wrote:
> I am unable to use Git (version 2.18 latest). Since i couldnt find any help/support/contact email on https://git-scm.com and i couldnt find the solution using Google as well i am directly contacting you as i need to get git working. Hope you can help me.

It looks like you're experiencing a problem specific to Windows or the
to Windows version of Git which is maintained as a separate
project[1]. You may be able to get help for this specific problem on
the project's mailing list[2] or by submitting a bug report[3].

[1]: https://gitforwindows.org
[2]: https://groups.google.com/forum/#!forum/git-for-windows
[3]: https://github.com/git-for-windows/git/issues
