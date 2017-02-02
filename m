Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3C631F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 09:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdBBJoI (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 04:44:08 -0500
Received: from mout.gmx.net ([212.227.15.15]:57463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbdBBJoH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 04:44:07 -0500
Received: from virtualbox ([217.64.244.213]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ma1pn-1ctlKJ13Hj-00LoCY; Thu, 02
 Feb 2017 10:44:00 +0100
Date:   Thu, 2 Feb 2017 10:43:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] nd/worktree-move update
In-Reply-To: <CACsJy8B3bdokeYVt6aEyZVSzO50PiQRn+0sid9mSDTZ9q-mnww@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1702021043110.3496@virtualbox>
References: <20170202085007.21418-1-pclouds@gmail.com> <alpine.DEB.2.20.1702021015160.3496@virtualbox> <CACsJy8B3bdokeYVt6aEyZVSzO50PiQRn+0sid9mSDTZ9q-mnww@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-248798122-1486028640=:3496"
X-Provags-ID: V03:K0:JwIkhVLu7guKwld4Nb2aNF3LO6blFxg8fn5J0b79jCG2/WJfoOO
 +fdoLx0r4pXqiK9Slpww1G+wuowSNvYU30V6QdmxbEAiaoxMpL7Znu87vIv6sL20HxmKUP6
 wgraaDdNlUOSDxfkGj/HjtUWCqpb3ObRp+mzsmyq9J+TTevs8AoEeYDIAH2xMc4OoYsNX2L
 XlpEphrxn4mVS5c0iL55w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fjFEGFw6w+A=:4o8GyXmdssxEJzxLyytmoP
 qs7tBVBbuGyC+6+wq1GIVC+uh781ajrabxF3DJ2EokXltxSicWakqc5M8e5qKYA5HCZLbRbeL
 hYTXLvfC3Vq8js7C+AgHkOVCvSmYcTUaBxH2wv0lRlpI4cXU63Lluy6TW3Wj7MbjByxSK7bmz
 i/Pi8hta0r7h8PyPctVzHCIVmGpjWy86Sk68aIVxpArJTY5vFxEMWNHP02NMkscke8/xzGZ5B
 kXvHA8jg9hPK3UzqvosgJmTt9kU8WHxgreyVE3oD6LB5ZuhhqdbVASLXu6mJ3P6vXnLQFicer
 2lkWrWQa9U5xR5Q38FpS6STDVE+ZifoWVZ6gdqCaStpyPuQ9DNZaKhRfv88EvXlxPIpcA0sen
 gYjV1hGf5i/361wuYSK5fbKOuNXwPxnkTfewfA3gZDCuIn83Dvv9cpy+OEb3iqUy6uFwo/uGd
 TKm2z5X9xRKp3ecraKfGt/Iq9vmQf9hyLv16qQ8Ul+r/8MVN0DDiKKGseQEOINqoLfKn3OeqT
 XJDNMoZtvRWOzhSW3gUMSzp1QGRdOrvGe2v1fesMVRlGLor5b3fTULNrlgPZgXHiinoMcLEPo
 Psyuv2oafngtLR63woJEG0NabRlwt2hf6COAYVlHFnU8czHwbr97X6NjyCa2aPBo+E9X67hYo
 RvBKAE4nfagigd6ggBBSbbezgNgAXZYyntXNi5BVpQotGWQ/RZ+jVcoYGtXqGwVJOKVKisX6G
 w2uUEjQlnJfVp2VhAahNKvmG5ewYkwnvNxmMdUdgd4XNbeBAvgWdVnQ3tKJczpYjbMlLrqitO
 3Ecbhjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-248798122-1486028640=:3496
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Thu, 2 Feb 2017, Duy Nguyen wrote:

> On Thu, Feb 2, 2017 at 4:16 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Duy,
> >
> > On Thu, 2 Feb 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> >
> >> This squashes two changes from Johannes and Ramsay: [...]
> >
> > Sorry, I lost track of the worktree discussions... Could you remind me
> > which patch is supposed to fix my continuous reflog corruption?
>=20
> The corruption caused by git-gc? It's not fixed. All the changes in
> this series is shown here.

Oh sorry, I meant to ask "and if it is not in this patch series, would you
mind pointing me at the patch series that has that fix?"

Thanks,
Johannes
--8323329-248798122-1486028640=:3496--
