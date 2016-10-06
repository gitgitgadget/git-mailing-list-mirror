Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4A320986
	for <e@80x24.org>; Thu,  6 Oct 2016 10:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754739AbcJFK2b (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 06:28:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:52490 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754295AbcJFK23 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 06:28:29 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MSv6D-1bQtrH39M5-00RuPh; Thu, 06 Oct 2016 12:28:22
 +0200
Date:   Thu, 6 Oct 2016 12:28:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] wt-status: begin error messages with lower-case
In-Reply-To: <615ff493-5de4-5d73-dd6f-2ff818ac9ac1@gmail.com>
Message-ID: <alpine.DEB.2.20.1610061227470.35196@virtualbox>
References: <cover.1473580914.git.johannes.schindelin@gmx.de> <cover.1475586229.git.johannes.schindelin@gmx.de> <1d2639277473010731ace0af8358bafd3c622a8d.1475586229.git.johannes.schindelin@gmx.de> <615ff493-5de4-5d73-dd6f-2ff818ac9ac1@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1986105689-1475749702=:35196"
X-Provags-ID: V03:K0:HFkfWNjlmEyQvH6FU6SaHNKgHV3q4wCzGjh14KDJUq6RtU5ocCc
 Me83HgIX/5xeIujs0Qf5fRQekkJlIaRt4Ozy1xMQdOkwo68BoifTUelwYeoPEW+TJq8Adpl
 71oYyAW9EAjo7HTjfMT6GS5wTdQRzU93xWCP8fon68Tdi6exiWHOJKe/avsKE284kLubdd0
 Z9YPrF8QEpkogs6+tm/vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qZ+wzJaCS/s=:iHKpT0aQ0LZ3mXNRrF/snj
 NKRTcBKPMEmVOyLXgpWQBwX/4DRpzq7Mdsa43jyzwGGjey6F1OW9YwpRWwSvyxA6F7pxE4ZIm
 4hEXCH1jJeMZGJJETusYTVjIWwBj+B4+oM0/OU6oTo/u8Flkc7ysn6Vq/U8fDB14HhMqX7un2
 Bx7tVMJ1sEernZYtf5GvhcB/q+I8+Rfw827Lw1fx5rSWCN+8etFm4J0qYb3QVS4xRjeZGPggJ
 kJYXXIqBa9LX1qwv96GTJ2zCzalWCwziiJ5Y/tQumb3p/DcuuabNMFdi8zlrvy5qRQAWLoYcv
 yvymaJenItogRIGif0g8bcMebn2W74yKQM8uN00V3Ph+vxMXd2DTfPWzSJA5TaiYylAW0SqM2
 sEovmGHOaLmLg+GXpPBc+rYGc5qm4BArZFWepx2NwjhoWAWkjyZZfV1YGyg4A16t5jL1BhG43
 Y2LlE7NtKaNYNQNhplKsPGJgujI2Duy3D5oPKd0OmnnmPiOZ6TuCbofRbMf6iTQgBUmqvvSdr
 VWUMRwwab8OzggETR8qm/g2bb16u7bwBc60yPv/5RizrDdIPvjDpd4TCrj0p68PZcg4a4Bt2g
 XMIIGg+p6lAA8ZqlClTOD/Ixl5k7k1GdCdq7P5DscUzGYGvDFH03XANzA+tNPwlh0tLRbsAn3
 gdxw/0FoQ0CNEtTjESwSUbuy/zgK72GXpgnV+wIiDTSP3qgRpmEU+2X5Y2vTHAwFqF+0iskd6
 yM/ORtqg2pfIv4BrvkjoZEPgDHqtYZ6a3mVTTag/vhwZIAu/W06YPJT1SVZpERA9vZofRxHyC
 nop/n2/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1986105689-1475749702=:35196
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Wed, 5 Oct 2016, Jakub Nar=C4=99bski wrote:

> W dniu 04.10.2016 o 15:06, Johannes Schindelin pisze:
>=20
> > The previous code still followed the old git-pull.sh code which did not
> > adhere to our new convention.
>=20
> Good to know why it used its own convention.

Yeah, I figured that it is late, but still a good thing to explain this...

> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index c639167..0bf9802 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -810,7 +810,7 @@ int cmd_pull(int argc, const char **argv, const cha=
r *prefix)
> > =20
> >  =09=09if (!autostash)
> >  =09=09=09require_clean_work_tree(N_("pull with rebase"),
> > -=09=09=09=09"Please commit or stash them.", 1, 0);
> > +=09=09=09=09"please commit or stash them.", 1, 0);
> > =20
>=20
> Shouldn't those also be marked for translation with N_() or _()?

Of course!

Thanks,
Dscho
--8323329-1986105689-1475749702=:35196--
