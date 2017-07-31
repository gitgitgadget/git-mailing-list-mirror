Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26DE820899
	for <e@80x24.org>; Mon, 31 Jul 2017 00:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbdGaABa (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 20:01:30 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34283 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdGaABa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 20:01:30 -0400
Received: by mail-qk0-f178.google.com with SMTP id u139so78202232qka.1
        for <git@vger.kernel.org>; Sun, 30 Jul 2017 17:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rVQdCovVDLoXS1vdLq3oos5cwXueogEaC1TcsZf342k=;
        b=SwsLD7McZj3Rk4ErOEiK9EltVkM6oMGNIjbkh/QLsg1j6p/tM/3yWWHl37OWNMRQsP
         XcZzDXQ9RH3DOf5nKm8N3caGA8Lz8EkJ60B9Arqp5st9si2p+lS/8whaaLuugpyue5bz
         xiXJrekto0RSRGyBVNQRTRH/QnuMPNM+UnsDA2xxvOjlhart4DLRqaec9f6AcERJwbwZ
         Er1/2u/bWv/czB9Zln7LnywyRdNHVdSzsNa7Gy+W/ZPe1nVS+IL6fnzbJ4dB6tEac41U
         Nuv2THC5H8YUluATkSLzcGqGCDeWN8JG99hQtU7aGmOrceCqdhBTm2f1APJ23JktcG+n
         DAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rVQdCovVDLoXS1vdLq3oos5cwXueogEaC1TcsZf342k=;
        b=kPHbUa8V4z6MsENFx7vIguVDXLqx9JAQgE28vHMScwNwY+tbxEWLbdi803jcnUvSgB
         Igv9Lzj8xn+QDjiN3ifGNtQVpzXQQ8mFp+GHyK7hE45VxJvQSvVthrc09kwPVBVhYRyc
         t86hzw2Gz1vy6URITp5GVuwuig520Gibw1kPpzMR+RoR9qL/JP3pfduWImRA93yf01lF
         JQXrsdz76OV2IjCbnYtJwO4a6q4pCslPtI/dVGRylTL6SdKBdOdEHDvwd+YI/jR0BbjX
         EQJ1x6m2IscDkXWZMKs5CZAbieOsdDrKmUpuMIpIFD6Krl7/45UynA9ilVrYa6JxnSpI
         tmvw==
X-Gm-Message-State: AIVw110Kyz+UCO3LnocOpqrPzFCRkXuHZQsKhNlVrHkPo601Xpm3bnZS
        0IrfP/8i8rdjjFr2j/gZ7l/TaEDi6g==
X-Received: by 10.55.140.71 with SMTP id o68mr17967473qkd.18.1501459289342;
 Sun, 30 Jul 2017 17:01:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.39.151 with HTTP; Sun, 30 Jul 2017 17:00:48 -0700 (PDT)
In-Reply-To: <6EF3784A5C1F420699D881AF642F28CD@PhilipOakley>
References: <1501423608.3232.30.camel@gmail.com> <6EF3784A5C1F420699D881AF642F28CD@PhilipOakley>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Mon, 31 Jul 2017 10:00:48 +1000
Message-ID: <CAH5451kzm-gh-7MRYie8nt17+yZdFLgzyPF3ZAwmL74SrR0XvA@mail.gmail.com>
Subject: Re: Contact with Latinamerica
To:     christopher.diaz.riv@gmail.com
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31 July 2017 at 04:01, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Christopher D=C3=ADaz" <christopher.diaz.riv@gmail.com>
>
>> As one of the main problems when getting involved with a community here
>> is the barrier of english language, and few are able to have fluent
>> conversations in that language, as it is a bit intimidating for most to
>> approach an open source community. My community hopes to get in touch
>> with different open source projects throughout the world and seeks to
>> be a midpoint to interact with young developers and communities.
>>
>
> I can see two simple steps toward your goal that may help.
>

Another idea, and I don't think anyone has done this yet, would be to
localise news posts coming out of projects.

For git, one option would be to localise 'Git Rev News' [0].

Christian Couder (cc'd) organised the last few editions, and might
have an idea about how it could be localised if that was something
your community wanted to support.
Regards,

Andrew Ardill

[0] https://git.github.io/rev_news/
