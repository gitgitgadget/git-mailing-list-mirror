Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1F811F404
	for <e@80x24.org>; Tue, 24 Apr 2018 08:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756147AbeDXIWv (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 04:22:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:57231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755887AbeDXIWt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 04:22:49 -0400
Received: from [10.49.234.97] ([95.208.59.141]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbuIK-1ejDyt262W-00jMes; Tue, 24
 Apr 2018 10:22:39 +0200
Date:   Tue, 24 Apr 2018 10:22:35 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     Phillip Wood <phillip.wood@talktalk.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v8 06/16] sequencer: introduce the `merge` command
In-Reply-To: <cover.1524545557.git.martin.agren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804241015470.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <ec58f482-ffde-1959-ff4a-9b128905ccb0@talktalk.net> <cover.1524545557.git.martin.agren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-369143892-1524558158=:64"
X-Provags-ID: V03:K1:SwRKyWUWHWYgAAcjAjim/Sw8atpuk2QHx9Mx96p38hOwR10ROFw
 g/9kS03tHw29Bu+jvpP0rb7fDlqHuqqjRgb+zVwNH5hxGOjIhWBtAtU/A3kL7aJtQv2KxNt
 bSPLmM6sGQsx/dicOS60xo6lcdf0PpkYmXb6lxcp3j4KwTSMpZjJYxCKaENgka5MOPc8TQD
 2ihjz2K2ezD4D2NxTTnjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Jxvm0TUDefQ=:vXR79NHaZrrM3dnnMSJOIM
 PBL6c+mDvU/wd9LxhUoVKrd+qbPIxG3+DZCtgh8kUnee8xdNCQDo2KoyrEgvhLUwyYFJd4+vE
 CTSP9/nvFwXPuyi35/7Z+8eC5iAyFaQv0TbcpwrbIW8fo8EvJ6x8TC34scWJ2KwzA1J5u/PPM
 WOJHcKupxrws4elfNdzHZR/3KiKUl1j+l0OXIt0YP0+Ly1XZOAyrSMfve22CqytVKPuNNTAeT
 W1M17/2qs6n6SfEU3pxzOhiIZI1yFtz1En43ryNlk7JL0eeuerm2T0MsPAC9FW2jYpr7T8PXk
 rPoroI7sZTpYIho+FUFUcigAGDtt3JL+yEpnKpPQi0fIuX2d1rekQMp7dc9wwJnbFoMay7OhN
 34hRm6EAaosAwgpRRegIVFNmvsII2s6P7YNld2iA7rA/iWDLHPRa3p7FTVS1nXaPNkwHFHpRQ
 GtJ+qf3a23IjKY5bp/7nDt8o/vjTuc3jKuH68O7ijzKm5lcdnv0fQqI//ENYIWNBcZORbPISS
 v6Q0cmOPhk3UZ/nf1BuUBUJULbMpVBHvXoksV8bt0ZWcIUgc1aqRrcNEf7Zuy9bqIptHfEFmZ
 ZyzPx3FSr0y7twEe74FvHr7xBjtgSyx2FO468e9+v3b06Srud35krMgsviGl2Ub1Vt2kaNI7/
 ozXku6M0VtUhGcU48CDBeqaoNulq+uP7cR+gm42zBC9cLF7vD01+zTAPhZ/i9yR60GKF1maXU
 minlK+3e5YtMuV90mJfQGSRs1gc6UipOwyB50Je8wm4byx5eIomk5NviRnDI4f7gO97DfulNj
 MqB2JJEQAJYobmEjYrh+rQyf4fg7Ce/KXU7QkIm7D5Glxinkd8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-369143892-1524558158=:64
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Martin,

On Tue, 24 Apr 2018, Martin =C3=85gren wrote:

> On 23 April 2018 at 17:54, Phillip Wood <phillip.wood@talktalk.net> wrote=
:
> > I'm fine with leaving it, I've might get round to doing a small series =
to
> > clean things up slightly in a few weeks. At the moment
> > setup_unpack_trees_porcelain() leaks memory as it is called for each me=
rge
> > and allocates new strings each time. It would also be nice if the error
> > messages reflected the command, so it said 'cherry-pick', 'revert' or
> > 'reset' rather than 'merge'
>=20
> This is a small patch series to introduce and use
> `clear_unpack_trees_porcelain()`.

Great. Now I have no excuse but must change the sequencer code to output
"reset" instead of "merge" ;-)

Seriously speaking again: thank you for those patches. This is truly
exciting! I mean, we all touch the same code and move it forward, and
somehow it all works out.

Ciao,
Dscho
--8323329-369143892-1524558158=:64--
