Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A70207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 14:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbcJFOSd (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 10:18:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:64469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbcJFOSb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 10:18:31 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MVZuV-1bO7FY1K0t-00Yy3y; Thu, 06 Oct 2016 16:18:23
 +0200
Date:   Thu, 6 Oct 2016 16:18:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 25/25] sequencer: remove bogus hint for translators
In-Reply-To: <xmqqa8fe6mln.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610061559450.35196@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de> <8314699c144c258ca45094beef5953b612eb7f15.1473590966.git.johannes.schindelin@gmx.de> <xmqqa8fe6mln.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1338996186-1475763503=:35196"
X-Provags-ID: V03:K0:nXh7AbQ9dSQTj0Obp2OjGOdanTFyQlvzjNQ41z/I43iMqyam4av
 hcQsIZ0Si4lgXWd/cCCCKgXAEdHQCU71c6Msrya2OUtzebLKpaN61VflFN7172fntDQpDOE
 9xpzTW0nzUWhpKILhTFAIJh1uMEwSTNjLpAGObhbA/1KaTyVZPdZFAV8/B7KrRcnX5p7QE3
 jRsYT9B4Au5a+iQViYVpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hyAVS2gYE48=:uQB7Cs0SiWq/b2rMH7vq2z
 W8ubrxQ6oNb3b5WPU1Nm842ePtZ2XiCcIq/6VqRnEWgksE7qkd3SDBn8ryzkOsXt0W+kUa/+C
 m29Io1nr+Y5GXhOCQpSFWX2trllcGFzQBhzfGvNi7OXz3NNkcadIlI3BjJb+5UnulA8NZ6Q7l
 CIjRjgh6r8ukt9MU6mcLxtRaXdt8mx/OT5/su3Z99NarElHUb4jMYmclr3r6XMdCTmWSrUaRl
 ykZn2+87/XRRpqfQgIpOxLLIEfwbyIezaJxVXWa9IM9Udf/8wf+mW0ytHPkPzrrLke3ouBJgQ
 RYeRbEKcFNYB+n8pmXwmA1GZ97TH77fszsFaeWSa2os9ogkV1ozq6XdhFes6lp2vf4u7har5I
 qPgCIEUUpdkz9fJ9Kl/Q/uegKCFP9XUbTAavIiz+T3lzZpCtXmp03aamOSPzBkAcE7lx2jjIk
 OD7kp3b+GBYllBOmPpcvofopYwXvLWfYlJM2bsOaGe4Qj2ruCOZBJf3W9zTtSR73ikAX9vOQt
 osg9E2e7UY592FGnZUxxYIz9qUMjx9JwIYSw7IItfK6DB7FTDWZY2CKyJxQZT7iOxkqTTaKv4
 Oo/GIqfjD8WG2oKHLqHZu3Y4sUKSf4m7yy410F8O9yNzwDCM6fFrJntaE9zPN2FBsTLcJTlTP
 2xJhP0VS30EUj5u/cdGOdMpd79zNoPnGoT3gS/DQ61QvzTRHYXqMQ4f41Iln9rzmbzHKmoGcM
 id73P2pxtt8wanPXeOg2vaPn5hBlD/jID+27oXCxlYLUP9dIXk5SXf2TD6ksDC9lmAY+ZjDnQ
 Cz1Vwzz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1338996186-1475763503=:35196
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Sun, 11 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>=20
> > When translating error messages, we need to be careful *not* to transla=
te
> > the todo commands such as "pick", "reword", etc because they are comman=
ds,
> > and Git would not understand translated versions of those commands.
> >
> > Therefore, translating the commands in the error messages would simply =
be
> > misleading.
>=20
> This comes from b9c993e0 ("i18n: git-revert literal "me" messages",
> 2011-02-22) where it said
>=20
> Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>=20
>     i18n: git-revert literal "me" messages
>    =20
>     Translate messages that use the `me' variable. These are all error
>     messages referencing the command name, so the name shouldn't be
>     translated.
>    =20
>     Reported-by: Jonathan Nieder <jrnieder@gmail.com>
>     Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>=20
> This looks like a positive attempt to remind translators that their
> translation must flow with these literal command names that will not
> get translated in place, not a bogus hint at all, at least to me.

Alright, I misread it to mean: "You need to translate these terms".

I fixed it by skipping this patch, and amending the "revamp the todo
parsing" patch: the first %s now actually refers to the much more helpful
todo command rather than the overall Git command.

Thanks,
Dscho
--8323329-1338996186-1475763503=:35196--
