Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC9E1FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 12:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751490AbdFGM5S (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 08:57:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:55672 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751203AbdFGM5R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 08:57:17 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LtJAR-1e1iNd0Fyd-012nn2; Wed, 07
 Jun 2017 14:57:14 +0200
Date:   Wed, 7 Jun 2017 14:57:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Konstantin Podsvirov <konstantin@podsvirov.pro>
cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] Help > About Git Gui = crash
In-Reply-To: <463191496776595@web26j.yandex.ru>
Message-ID: <alpine.DEB.2.21.1.1706071454310.171564@virtualbox>
References: <227151496770459@web10m.yandex.ru> <CAGZ79kbAwqb87nOm2sG7=uOO2jE6Rkgqofy5iYuZQrg1Jc2okw@mail.gmail.com> <463191496776595@web26j.yandex.ru>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-86331634-1496840234=:171564"
X-Provags-ID: V03:K0:+SnGjihqhFRDQ7wiOXVbZDvY4tkYV3EYkWtUPS6dTCFrj9N3PsT
 VRxlgWKXcXeoHcu5EoewuUyU1x6sz1j2hFVd1i3/XL3UxY+LRCRowWXFScbZhqjT6afFlsX
 1Sc+6XlArOTDZ+ZdILM2ZyUK13WgbNbEjnlpKES3oA+DBAYspd/DeP/5/NrDHGNKWkciCw5
 v71wNUTS4R6d04CmSQ20A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r/jkdCN7AIE=:OYkwy+2xsViBrZ9e8GioK1
 WAfvkdJJJ4xakqCFU2sj7/bFVoHY4qOK8gf8I+Lk7G77YLvaEsFwhVrkkgdt7SPQ3oDqAoEyz
 lx9p2TYMxki+yiijYKQka/WKNl3cZhtYia9/sYplT1DrxdUCnbwbztice0/GwnR7I4Zp9HRhq
 ZiLeikZeahYJT1gbbfBrAo9ichlCRXssad4adSMQgbJftBWVY7phfld4xwqlFwGEPcDmWSbIu
 /Jtc2b4r5rGZ6OOYfEelxFoMcJFQR6VxelERC0XBSHY8klbAa+5Nv2n77omuMYQS5rq4llddX
 u6tGvqVYa8FjeufJgO0alm+nOPA1QtYmMeWbcyHwMZA2REbOrRunYJhfqM54Q+iD7ekenDPbB
 9z/m7XIoWysVMK1X+QWmtiRax1YrLFfZ0rGMMjO1DEg6bKntoDaEPWtq8FZQqDHVRzvSMrr8/
 u2ONr2QWH2DL/my1Js/F6/e6QcHTS6Y6WswyBCQlX9FML+7ptTIrGx9dOj7dxOkjaWqyY2rWG
 wSX2F96mwgC2iBIXPi+seEpwFj7W4T5i7DSfoseEHhuFK9P4NaGE0fYYlzaYWA9hz4+1v7UQ9
 kgNnnF/5fZdjLNmkAQAZkuxDq0+1O3doVd9fM7cCo1MclqkDBAC1FiidVy6SZUFzqehMpJTxn
 Gward8/Hwlcn7sftAOawS8foRKiEqiovF6DRqRoVASfMz3wqJbzTRBnZiVvpWIvbZdnrXh1Es
 H3ORDjxShyN5tzj055RU7iA+qtJFjOIHo761jnk3R08BhyfJAIH0fS7Aj1+Q3/Za8z/FWuXXt
 10OZbrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-86331634-1496840234=:171564
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 6 Jun 2017, Konstantin Podsvirov wrote:

> 06.06.2017, 21:25, "Stefan Beller" <sbeller@google.com>:
> > On Tue, Jun 6, 2017 at 10:34 AM, Konstantin Podsvirov
> > <konstantin@podsvirov.pro> wrote:
> >> =C2=A0Reproduction:
> >> =C2=A0- Start git gui
> >> =C2=A0- Go to menu panel: Help > About Git Gui
> >>
> >> =C2=A0Output:
> >> =C2=A0error: git-gui died of signal 11
> >>
> >> =C2=A0Environment:
> >> =C2=A0Debian 8 jessie amd64 KDE
> >
> > Care to also share the output of
> >
> > =C2=A0=C2=A0$ git gui --version
>=20
> git-gui version 0.19.0.2.g3decb8e
>=20
> > =C2=A0=C2=A0$ git --version
>=20
> git version 2.1.4
>=20
> >
> > as I suspect this to come from git and git-gui not working well togethe=
r.

FWIW v2.1.4 was released almost 2.5 years ago.

The crash does *not* happen with the version I am running here on Ubuntu
16.04.2 LTS with

=09git-gui version 0.21.GITGUI
=09git version 2.13.0.windows.1.460.g13f583bedb5

=09Tcl/Tk version 8.6.5

Ciao,
Johannes
--8323329-86331634-1496840234=:171564--
