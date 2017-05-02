Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6A11F790
	for <e@80x24.org>; Tue,  2 May 2017 15:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbdEBPl4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 11:41:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:62925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbdEBPlz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 11:41:55 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MI5rO-1d51hV2V2c-003yOP; Tue, 02
 May 2017 17:41:47 +0200
Date:   Tue, 2 May 2017 17:41:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Liam Beguin <liambeguin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] rebase -i: add config to abbreviate
 command-names
In-Reply-To: <CACBZZX5MacQZHVjSymWm0_RHjc_Q41J9vhqMuDGwz3L_4LjtzQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1705021740530.3480@virtualbox>
References: <20170502040048.9065-1-liambeguin@gmail.com> <CACBZZX5MacQZHVjSymWm0_RHjc_Q41J9vhqMuDGwz3L_4LjtzQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1946652013-1493739707=:3480"
X-Provags-ID: V03:K0:hv0cwiiezD/VjC3RVp0uINT+X93VSyqPusf5QoGHayh34fA+T+i
 7h4Yk+xlT8PxbBux+RQq9/HhrQ9uXkYXZEAvGhmdZrgtkwUW9foB1XjCxue8CKZm3oUWp4S
 jPRll1tS+G3hptFUn9zrFAXe1QnvBYPgMeif9oCb0UcQY5HAoTKRn9Ohc+Gy7RhPd+jEqko
 stYMDfdi8Gajra4MxPdhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i0tYW3hE+8c=:sgqflM1EC5i+HxMneNbdnF
 +KQQJjOeY+EbpDYG7uZg4j19HBrZtkKaW1lIo9WCiE5fK1XZ1Osmd7pOMRGOPs946LDXTRLYU
 9U/IfNJHU8LvpdsRUoSmnKBEXfooOawBsVM7LuBAT6nmEE4YZQtXvgv2KNuU79Bn06dLDYEyN
 bqqeSVZ/dx+Kv1TMqk7r0sCBdEjemII4AYtdZ2gKzmHrJoXB/EkuCQp8nzKd8otEcq3R0FkCf
 lLEK4xUAMkkIrdu3xzYvTrIB3nrWTgKMZPvkaMbXkChgUOIkq1o09fO3DQLiDbWK5xHtpfZK4
 BdOVT6gSS/f+oDQ9CaFXRFepDOwH1UFJ5HwpSps2XhPDz6FrJ1Q0VzjBYwRnXrV/ofm1Fd9h8
 hVQ1kON9lLVsGeBCTMBP6NmUxk+Vv1mhhmnSeOET2M01XTTFh+Ga/cPMBrGv0kop1eE4gxDH1
 Ao+KsiS3F7cHYgZSheiS2+TTmGGxWDqORWEf4OtvnfHxM2ZWPDSZgFWgVgFBK2PVVoMBwKqm5
 tUPmk3Ef5iLKNhXfOMhHZuVeluoskpKN4vCLjmIoRbFK4Jn1+St9/V5ZL0Ne3CjN/GldEhyHo
 x8ba8qLCJSRetddNHEKdfBjk6qEl3G4EFJrREmvGRx4ED1cOvcDh/V1GS8pagzkyf39rjQ153
 nejZTagksTsyKUkRvPLUU8hFe0tLzRVFZqbsRfPrXENRsXG9TpioWGJBStsyl3fI/Q/8yshPD
 9JTVkdLkofaLBMzmS844+Tibh7iYyANTYgkoGLZ5KkyQVp+ENA5LEre2FpRYuq9saulsYWZGf
 PL/bw4y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1946652013-1493739707=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,


On Tue, 2 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I locally rebased this into just 3 patches, i.e. in this sequence:
>=20
> - Documentation: move rebase.* config variables to a separate rebase-conf=
ig.txt
> - Documentation: use preferred name for the 'todo list' script
> - *all the rest of this squashed*

I think that makes a lot of sense. (I would drop the part about f!/s!, as
I pointed out, though)

Ciao,
Johannes
--8323329-1946652013-1493739707=:3480--
