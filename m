Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DEAR_SOMETHING,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D68E1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 19:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389727AbfBMTo6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 14:44:58 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38463 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbfBMTo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 14:44:58 -0500
Received: by mail-ed1-f49.google.com with SMTP id h58so2988790edb.5
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 11:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=gLFMtc80fipfssHjJ6J4I1gB9Z92cbv3bOD9foj2yDI=;
        b=kpaZW6NPreZDp9LCNm8GIOKt3zDO4gg5mdNmDQ18ET78YJc7fhBDWmAODCJ8grt1t4
         3E7xEiPfn9Y5vL8XgTuw1L0jXfaxW2uSgOgjIOTPIbfbCZEm64tMcYYzxoBwIdz84nqF
         6rxDUtjZID3DHQq7OBL3XI+XP9+flZd521OW9ScpJlGm31s2SOom6BwqPTzXOV4drFeI
         QFSMeXBy637oxHJKUa/CyyoGyYm+WW+y4NznzEK3e4hzdE1vQLWYqO/PPm6uh+y2YstZ
         i1tV0u7YVAHrLByneeGSsOYmqYA5pgZxGgPiQGERFHKQHDvz+9JSZ8hwQj2bFAem6zuf
         Prng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=gLFMtc80fipfssHjJ6J4I1gB9Z92cbv3bOD9foj2yDI=;
        b=sNCBPFATf9pmyMJqJlf0v15qJyYx3Yl/qXimxwK6iHbSJnEjQHxN2sZHM0iyaauv2V
         VpClRweuxxSIIHKVmwhcyBDpB9JUaAcZfzDjwL+QtRM8DIxBj9toOCerQSj5cy6QnVoB
         F1BmFTrEH2WvSaTzSjl8hO2Kb/5pc/9UBtu0AK+rDlrd8A+XmvnACKblbvhdE3B1op22
         mgK20or5uec7HSZ3WJYsw5pO2aqmURwA6lZ8LyDvFhgqw6jAXwIrfTP3hH4LyAi2J/oO
         Zvm8/QWdT6CkoqrJjMgexXIZkuVjcgpK+Szubvzrvc6mb2V2croOCBIpWIkZ/O3XWvAG
         sPlA==
X-Gm-Message-State: AHQUAubuzucrOGHh70YC5vBTtIfJztWzkTcibHX0cahLL9B3A7oMfNgB
        FlHXO4mPprd0SjC/g4EMXM/9i8GdHwTEg8NJS/LWrWi5q/I88YtI
X-Google-Smtp-Source: AHgI3IZIpxkxY+RWgN5ElzaInEc151mm5syNHOietG0yOvko5Bt8fQ/2vYDP8m6VaGk0WsrwdwCybT/5S761GgoFPMI=
X-Received: by 2002:a17:906:4551:: with SMTP id s17mr1551230ejq.69.1550087096454;
 Wed, 13 Feb 2019 11:44:56 -0800 (PST)
MIME-Version: 1.0
References: <C9D9CE87-105E-4716-BF43-1D64239DD492@gmail.com>
In-Reply-To: <C9D9CE87-105E-4716-BF43-1D64239DD492@gmail.com>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Wed, 13 Feb 2019 20:44:30 +0100
Message-ID: <CABUeae8iKGg7n9ydRfWfYWQ_so+WaiPXtE252R+7=V8sBsATdA@mail.gmail.com>
Subject: Re: Git - logo commercial use
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 Feb 2019 at 20:34, Agnieszka Borcz <agaborcz86@gmail.com> wrote:
>
> Dear Sir/Madam,
>
> My partner and I are in the initial stages of setting up an e-commerce bu=
siness selling high-quality stickers of logos of popular software and libra=
ries. We would mainly be marketing towards software developers, as there ar=
e many who enjoy placing stickers of their favorite tech on their laptops f=
or display.
>
> We would love to be able to include your logo as part of our inventory bu=
t aren=E2=80=99t sure of the restrictions regarding its use for commercial =
purposes, so we would like to find out what your policy is regarding this a=
nd if this would be a possibility?
>
> We do not plan to modify or alter the logo in any way or claim that it is=
 ours. To get a better idea of how we plan to use the logo, please see the =
following website, as this is very similar to what we plan to do: https://w=
ww.stickermule.com/unixstickers.

I'd follow the following steps:

Go to https://git-scm.com/downloads/logos
Scroll to the bottom
Follow link to Creative Commons Attribution 3.0 Unported License
Read and understand it, or hire a lawyer.

Best regards,
--=20
Mateusz Loskot, http://mateusz.loskot.net
