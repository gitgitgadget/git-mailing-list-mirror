Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DEAR_SOMETHING,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543A11F453
	for <e@80x24.org>; Thu, 14 Feb 2019 12:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbfBNMhA (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 07:37:00 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:35397 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfBNMg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 07:36:59 -0500
Received: by mail-wm1-f41.google.com with SMTP id t200so5949943wmt.0
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 04:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uASDnsKrq0m6bJd7Bw1l5RfGfPzRLDIrhXEDCHGOnnI=;
        b=eGovvqlrSOnrrH4LF1LW/mXO4NmrzJYxEg17QFgXTzBdS+N+KuKVXvvwZbrNrTgeXy
         3rfi+EpnxlQtmceMlcrza/N73Pw64irRgOLFpdJ/K+F9OWnAXe+bPT8owaMdQIPJSxMQ
         SLgVnsrQrlHmAjPTmdLsK8RDUDMcx9i2jtWSuAi2w/rtmSTSFFmMym67SKIKth9gNpKm
         EhfvlcTHQhWsFIi3ezwlYixigIX6PpOPWTCVZSNwZsbQ5mhBxQSCG0Gadn4yWytpaLg3
         ehsOKYFNTMqhcgfEoZD63c6Qp33pF78aGttTuATmBdhZjYWb/a59WBTUGYORXxz8r6ur
         ItEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=uASDnsKrq0m6bJd7Bw1l5RfGfPzRLDIrhXEDCHGOnnI=;
        b=SvDpvbyX86htcfhuu7rngby9DYrtS1sAt/LgSBxWawsriIZD0ifg4l1CuiFosIVb4V
         rnqZuf2PQA8RELB27uwDcXj7JFUJ+1qd4nEITq0TL1sDjl0Q5xua6u5lBYDhTSGThoqP
         UYW19kSVZWdep2cV40GNmBij/erk/skKAmwLEgFVkzDPoXGiTepig4v1/eveaZQaM6Jc
         jZ1NpK2hIyHvCMCQTO/qMsJfb/Hnj9JkbM1vU03niV+mDq1nWVZJluzQsw6bOuQMSpTC
         diSz2NnAOGldPFoe4EIPoYdv1/6lsRMYEP17LZv6oEyS0iaWVChylJ8edFSAuM+pYBxo
         1tDw==
X-Gm-Message-State: AHQUAub6kaG2n5GcvwjqICtiQEkmtEkYi6k6hp2kDpvzF1n5P+P23zH1
        e1myDpDEyoGYFw62IzxqeJg=
X-Google-Smtp-Source: AHgI3IbpDGtWxEpVgXxKAdsXONg/3JBK8UPGcVgXLaAM6Nr4sU3OpW8kG8yZ5UBKgvRW6IlrfbeGqg==
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr2461015wmj.138.1550147817240;
        Thu, 14 Feb 2019 04:36:57 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id s8sm3356236wrn.44.2019.02.14.04.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 04:36:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Agnieszka Borcz <agaborcz86@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git - logo commercial use
References: <C9D9CE87-105E-4716-BF43-1D64239DD492@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <C9D9CE87-105E-4716-BF43-1D64239DD492@gmail.com>
Date:   Thu, 14 Feb 2019 13:36:55 +0100
Message-ID: <878syik0m0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 13 2019, Agnieszka Borcz wrote:

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
>
> I see that others are already using your logo in a similar way on sites s=
uch as redbubble.com but wanted to double check your policy with you first.
>
> We look forward to your response.

Hi. This would fall under the project's trademark policy. See
https://git-scm.com/about/trademark in particular section 2.5.

I.e. as noted there please contact SFC at trademark@sfconservancy.org
about this.
