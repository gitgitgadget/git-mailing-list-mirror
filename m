Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F04820188
	for <e@80x24.org>; Tue,  9 May 2017 10:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbdEIKLI (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 06:11:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:55540 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752264AbdEIKLH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 06:11:07 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbMb0-1dsge81Bxy-00kyYz; Tue, 09
 May 2017 12:10:50 +0200
Date:   Tue, 9 May 2017 12:10:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Wong <e@80x24.org>,
        Samuel Lijin <sxlijin@gmail.com>,
        Jonathan Tirado <tiradojonathan32@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, meta@public-inbox.org
Subject: Re: vger not relaying some of Junio's messages today?
In-Reply-To: <20170508170136.GB179149@google.com>
Message-ID: <alpine.DEB.2.21.1.1705091207580.146734@virtualbox>
References: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com> <CAJZjrdWYDMFHRrbeFk89p+GebLpWJBUQfnpC6w87aVh8czL5_w@mail.gmail.com> <20170506205041.GA26189@starla> <CACBZZX42rhmrq8z0u1aRXw87oT22YywwnaFHUMjDYgtE_i56nw@mail.gmail.com>
 <alpine.DEB.2.21.1.1705081239360.146734@virtualbox> <20170508170136.GB179149@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-984654987-1494324650=:146734"
X-Provags-ID: V03:K0:nQJ1QI5tZV7LqAfxSiMiDi+D0mQ4ktM8WZEw5Pl/052lPLVTn/A
 xRcBdaURubzzpPtVa4JZ3sWIsDO9mLNjDZ+ScJevLwh0yHeQOS2z5c/af3U7KqHgx36TXCy
 EUjHbI+Tsb9KZhi1LhGtkcwDu54ETG6UcTX3gzJ5Zu4OOzSPLln6sxo9Q3n04+CjAvpaWl1
 GH5GbWw+/lQ3sROF1II7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T4QM8HHaPF8=:MbZpWJ+SVN73vTLplLcV8T
 SuJCEpt4Bn4MtWGM2M4VHOlclQwy7hwIt8HHQ+oCk8KTjMTm+sS8ENt9Ptv5tBXi3siDWhfB+
 mfX1wmS2R8g/YkypDxtfJcmEukOQO5aGVF78Ef2i6HOcIrBwigexyjncdcWMU0UxS4Ls7zKcr
 gTC5qxlG29m/RNH1qqhS3o/Dy7PyA8QYCtrNPK6ova9tAva0b/pcHFw0oPRCvyFKjAKRUS8Es
 QK0Xs6fe9VMnyr/lvTIc/MkwQIREM3hifH2oB2LIrKzCAn4eR8Z6QNHpCEVS/QhlFvpxpUhD/
 6kJxUz4NF6Kr9rvGrd9ok3+XTK5m2mTjWFcVm39+Ozfyd+RxU/T1cf4Pj1nSFRsacwazLpT15
 fJcKfIhIzCIIfrLecc0J6lHC6rm3KxAlEuiuuXCaZyDhYZ0XC3geB4mAWfqSENqAJ8OY0tMtB
 QejS6R1PpHTfzfl26Ti27gAyiQK1/eZfefb4liJ7GrfoKho3dItX0RJH0k6geJHwHs7N8+hJG
 QaEoHPqYzGSRwGyGJlcuCm/zHfwEPxbORj/HHCJbwtqkVVPKZyK2hEg7hPpf+4W8nc9exNzTk
 wJQq0l4DyOrVS7UhuezFfS9elqPsSrrl6KQcXpkDW8avf4Q1Qkz7OzE7CSoGt+KF2z9HuHilz
 y4pUttKSLSJ07w47TUtOnZbCnJXWYR35Qq4MdXyykk/jeCdJVKLUdExVeUVJ1qoygx5hfHf2Q
 9lcygWmmwx78z2DR4llTL0xw/UEG98iLEJBrcgPx5GL5vcW2C07D63F/kcmcj/pP72gRMw7r0
 KdWevOy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-984654987-1494324650=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Brandon,

On Mon, 8 May 2017, Brandon Williams wrote:

> On 05/08, Johannes Schindelin wrote:
>=20
> > On Sat, 6 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >=20
> > > I have one [script] to git am a patch from a msgid, thought I should
> > > write something to handle a series in some DWIM fashion (e.g. apply
> > > the latest continuous sequence of patches matching --author) but
> > > figured that someone's probably wrote this already & I don't need to
> > > hack it up myself...
> >=20
> > You probably missed my previous mails mentioning
> >=20
> > https://github.com/git-for-windows/build-extra/blob/master/apply-from-p=
ublic-inbox.sh
> >=20
> > You can use this script to apply single patches (identified by their
> > Message-ID), and patch series (identified by their cover letter's
> > Message-ID).
> >=20
> > As I mentioned at the Contributors' Summit at GitMerge 2017: I would
> > *love* to collaborate on tools that make any part of the
> > contribution/review process less cumbersome than it is right now.
>=20
> Yeah its not the most streamlined process.  I'm sure everyone writes
> their own scripts (like I did) tailored to their workflow.

I am sure you are right. What a waste of time, for everybody to come up
with essentially the same sort of scripts, just to be able to participate.

> For example I just tag a bunch of mails in mutt and then have a scripts
> which 'git am's them on a branch/base of my choosing.  But its specific
> to my workflow so idk how useful it would be to others :(

Hmm. So it looks more and more as if you *have* to use mutt in order to
be rewarded with the option for an efficient workflow.

I'm just so used to my good ole' Alpine. And others may be so used to
their Thunderbird, Outlook, GMail, whatevs.

But hey, maybe the vger woes will eventually become so bad that even mutt
and NNTP users will be affected negatively. At that point, we may look
into alternatives.

Ciao,
Dscho
--8323329-984654987-1494324650=:146734--
