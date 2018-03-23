Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D20801F404
	for <e@80x24.org>; Fri, 23 Mar 2018 23:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeCWXhM (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 19:37:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:41503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbeCWXhL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 19:37:11 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lw2dd-1eVVxh3JS1-017nDN; Sat, 24
 Mar 2018 00:37:08 +0100
Date:   Sat, 24 Mar 2018 00:37:07 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Loganaden Velvindron <logan@hackers.mu>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Allow use of TLS 1.3
In-Reply-To: <20180323183950.GA15994@voidlinux>
Message-ID: <nycvar.QRO.7.76.6.1803240035300.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180323182506.GA15493@voidlinux> <87in9my6y3.fsf@evledraar.gmail.com> <20180323183950.GA15994@voidlinux>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-553774356-1521848228=:77"
X-Provags-ID: V03:K0:p5pZLW/nb8hn4hnyz1ad1IabCKQeMqB9M2gidZaLmgYco3CSpdz
 pyPA/DcXx/elbcuUE0geRsrxo2N3x0qZ9/ffHZyaXHYARJuB30WFBKIJGHSFQltzkGNNZLg
 htH68n0puhZIKODEGNoPdVnY+KLJDg4iFWVfp1yv08CCzK7XUNryCPIe8N9aHrW/u3mGxZT
 o2RzEuXTM3ZvhLpz8A5PQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s1pYKCBrZSQ=:bq8ght36PPYrjmGUJ/9j5/
 O2mGhJxLs5RSIGf0SgEP198DKOlsoV///Djb4vmDxr7lVz26GVN5gWWcZkB51H8QI6DnnYQk7
 6BiD8qjWj+923prpc0NuLUyMeqJz0bpbiFJQgmAouMGtWdNHprXGFPPhkYUVpBANp+xGsRLEV
 b57bo38YP4+bsxGl34KYF+qnI9AmQMR3hdKlqjD3bc5aBlTdeSguQcVJXmBz0YePKKWdJz6Lc
 njvPcG6hsPOAzJBGZJC0Gd27ldUTPbJHovWob04cdN6kFEiiPpatAZjEKv3+ZJSzxMJI5fHUp
 y3h4zF7j5whve9HeS7THxm+E9vCs2IQV2CzaqbZpmrGXflLNwRFi8gxHzTYxgE4btw5Kj9r5J
 cxg/5aZLhRHn6KNUjna1TVtxFf3eGBv64eqFXpyL2jUVnkH3TjP50ZZrsFjHntW6PihcZRSrY
 kLs1Y5f9PewL/sB1Rz/qbd0iwNAF0DgBRJrntMu2BMs54GUQASeyZOywnDm950mQW0lez1rOK
 ploqQ97bSOjhgn7Ll0em0J7TSRhDIrC4oHQx435cgQdUMsT7sjyDp3lxrfj+SsYk78zAXb4hH
 XrlGryPiBde660IHXP+Rxz16rRrQI5GzZ14slfryX3ECV9dwbobqjmrwQNnMN6bglbZYPBX0n
 af2A/9IWcAeqUEElhMqcXr36kCyulBOYM40vxpYmHNkCGwv6Y5xypXb33Zen4q4hQWpfqaKyH
 /nptZZ32cwm2YlyPYURhrBwptQ4MVdRsyDIaJSua789zh73cum87NisyWyLhyRYhLFrZJOid4
 AylHyP62aMm4HECZ0tUNZkFfZ94NDDJsuRsSObmZk451/LFE/0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-553774356-1521848228=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 23 Mar 2018, Loganaden Velvindron wrote:

> On Fri, Mar 23, 2018 at 07:37:08PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
> >=20
> > On Fri, Mar 23 2018, Loganaden Velvindron wrote:
> >=20
> > > Done during IETF 101 hackathon
> >=20
> > Hi. Thanks. Let's add a meaningful commit message to this though,
> > something like:
> >=20
> >     Add a tlsv1.3 option to http.sslVersion in addition to the existing
> >     tlsv1.[012] options. libcurl has supported this since 7.52.0.

Can we please also add that OpenSSL 1.1.* is required (or that cURL is
built with NSS or BoringSSL as the TLS backend)?

Thanks,
Johannes
--8323329-553774356-1521848228=:77--
