Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B7F1FDEA
	for <e@80x24.org>; Mon,  8 May 2017 10:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754244AbdEHKnE (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 06:43:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:55145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752709AbdEHKnC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 06:43:02 -0400
Received: from virtualbox ([95.208.59.245]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MK0ur-1d93ZP1KRp-001Qef; Mon, 08
 May 2017 12:42:42 +0200
Date:   Mon, 8 May 2017 12:42:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Eric Wong <e@80x24.org>, Samuel Lijin <sxlijin@gmail.com>,
        Jonathan Tirado <tiradojonathan32@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>, meta@public-inbox.org
Subject: Re: vger not relaying some of Junio's messages today?
In-Reply-To: <CACBZZX42rhmrq8z0u1aRXw87oT22YywwnaFHUMjDYgtE_i56nw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705081239360.146734@virtualbox>
References: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com> <CAJZjrdWYDMFHRrbeFk89p+GebLpWJBUQfnpC6w87aVh8czL5_w@mail.gmail.com> <20170506205041.GA26189@starla> <CACBZZX42rhmrq8z0u1aRXw87oT22YywwnaFHUMjDYgtE_i56nw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1024377429-1494240162=:146734"
X-Provags-ID: V03:K0:4IZQd56QNVmpacOdnYfA9EXndr585KtNw5GTS1sYWPHeHE1YSKO
 xNz8wUom/9IP3D+ttwzB8CV6ZxQwl87HHx7OIE42Y8j1GPcpzAodJR4YGaar1w05YGH1Y1n
 rmA6xss6NdNwCCSe23QhE7X1nrYUOVxoasaIT5lQ5RbyoCiLCW8+MqawV0wrQWEUsAKXuls
 QBy2vUv0XFLLhRUkr/+ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u1MZ1qARff8=:T683aYfrpGvbYeb9f3KN0q
 IticFPOxkYCkajtvXNhEQFPLpTAE9igXUrDxQA6PAKNuaaAtUzfK1Gue2FkoP9BrXdmy0vlPn
 C9c+kUqpkIPhKQZhEKNMLcjsZVWaDjjCBi1h7/7OczN23yuLlf63bRB10kF1LyGv3MpmVxnLV
 RoZ5VM5l3ZCnvZowWamys94pVrsHAI9L58/o/+/8PgjjTdBjBD9NE2mqkU8OYwyuZg/3X2mlf
 2aj/HYl6o2Qb7pJzFWaIFDRrtup3/nY3fDivsBC9/SZG6iY17wBu41Yc9E8d9mnr09t7uwjR6
 AfafXhmI9ksSPnFAA4naRTgdMUQNaOU+TOrThe4iJgzoSQq+FH8Xy80MXP0LHm8ULevx/gy+Y
 +uXAhrwICo2odh/ecJ6z89O+Rf4PxOVQqrOJgQs8LQ86SVywLF9nSeG+XzHz5XI6zgNG/Spqa
 Op6fzyPuJutubo7QKjXUuzSigj9aj4a9FlTPTz1vgIQuqxR0I5uEK9+lOAmOwOFoS/7NzD7UN
 bcIvdsx60sTbXK+5uOuAbIoY5IeXDJsQKQZyc5UFFRG9flMiUhyvqv9sMCsk0XM5RZZ+Xei7j
 u2K37mveZkLYMZ0xZ5wseF5rCFGe7hydZB/epz8RyWD0704jyvd7EalVMRneENwwTYfzXlkbW
 tl0HQnA4Q3ibCGEa/8OtvQMsbLlftx2JJ3RbRKVOQu9EhcXqZI+bQI8RPX9PJMfGpnrSr7Nxh
 2rPlZfK5auddCW3VpMNCjZvC7m3GXrBf602QrExNIqQ8A/fNV70VvR3sGgBPt5IEMiQz2FmOM
 eK4KDWU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1024377429-1494240162=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Sat, 6 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I have one [script] to git am a patch from a msgid, thought I should
> write something to handle a series in some DWIM fashion (e.g. apply the
> latest continuous sequence of patches matching --author) but figured
> that someone's probably wrote this already & I don't need to hack it up
> myself...

You probably missed my previous mails mentioning

https://github.com/git-for-windows/build-extra/blob/master/apply-from-publi=
c-inbox.sh

You can use this script to apply single patches (identified by their
Message-ID), and patch series (identified by their cover letter's
Message-ID).

As I mentioned at the Contributors' Summit at GitMerge 2017: I would
*love* to collaborate on tools that make any part of the
contribution/review process less cumbersome than it is right now.

Ciao,
Dscho
--8323329-1024377429-1494240162=:146734--
