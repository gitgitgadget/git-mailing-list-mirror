Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3FAF1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 23:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbeBZXeJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 18:34:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:37143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbeBZXeI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 18:34:08 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpKY5-1eBsjg2b4P-00f92i; Tue, 27
 Feb 2018 00:33:57 +0100
Date:   Tue, 27 Feb 2018 00:33:56 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=22Marcel_'childNo=CD=A1=2Ede'_Trautwein=22?= 
        <c0d3+gitscm@childno.de>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] [git 2.16.1] yeeek ... my files are gone .. by git pull
 <otherRepositoryUrl>
In-Reply-To: <20180223064549.GA19791@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1802270032520.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <741A56BF-93C0-41EA-856F-C1170803F0A7@childno.de> <20180222232031.GE256918@aiede.svl.corp.google.com> <8A26AAB4-E2E5-4681-87D4-0D6727CA423A@childno.de> <20180223064549.GA19791@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2075280518-1519688037=:56"
X-Provags-ID: V03:K0:4wNxj0PsH3qbeC6NLkPiWkOhVsO28P4fdWeAp4s2hhum05QAmrz
 cB+qM/Gx2zD+VFqJXMqRDspGB8AxG2oy3A5oLZ6oL64GQG0J4dd4wTEZGwf6fe+5m2rFwJ4
 ruoZSGSAXXARHs2QxxbO9kSq9p8kl7o4sFZCBR974Cl2SWRSoCYG5JGYamqSDZd4Vm0fJbZ
 j05tImvthxImkS2HmKY3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:buK1Z3s7lWU=:LhykOQHvzMjf6WnfMV3Hto
 qA5ZwUAEx5BqsWXQGQxYf/iKsifpQiM6PEo6VZZEykF5S8lqClgt7Jy51WlR6Wbew21oykN7/
 DDcomFALhN4Ccf+jy1AIvAQYn9z3J8rdMe7kt73K3etsXw12Xw1BfAmzhIoUVQFWg8kszY1xz
 YHhDtxNG9TDitHE9SyP/Yndq4OkhBBikWopcKzSnPeCHtpJ58m0Pj2hc1l2fIhj85AZiW9QHG
 g/Ev529oaUs7+5kxyjd9XHbJEAxM4vEzbI7MZyNaVSioV2OkxcuoVczojcajBOWW3SEy5goPO
 uSwhGS8q02kSnzHIH/VD4/CqwsqmvdALUUGhpZvIKz0P6NbdNT0YebNP2bG8yL7inpE/EiJKi
 dHE3uILXjJOKKjDCcFXMCfOKwl6TvnCit7ciqL7OGjVpGCRaqgp+zmwh+V2YKioUehBRAZ8YN
 GHHqvI/n0T1z94geVK9+urlR6L5qlolyTR5cMidDQYpuNA+srUW7K0LH28zLohx39LENDOg1S
 0h3ZDB7exTE0wQSCg/01iSobTwfj6V1J/dd8pTJvgTjqUPtw/ZAUmdOm4NTnHupepmr5R3Un+
 5fpG6wbPndRZHSMr65/DfWI9AEAKVjnMim3VT4WAQh9HP8vNFcAfKheFEVyzoXW1+FkoEaHQ6
 hxgx86YIo+aX806T2HctwQX1nPlQEihF3oYioPg6tP6oi/b7ksp+4y35cWOE20w5pwiUNvQMz
 1UJTRQDcJw/ZG0gOplSyRyIq11RtCS0UjSasJ57z7R1eJxnr7bRqQq/DPD4/ZQABC2hRpXlny
 JJ6pyhfYUNVRrFotX4IEKz5e/5MI9lFE5l3P+wgcl+VI73L/uulJjF6MrKiOZHTzsGHylKu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2075280518-1519688037=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Peff,

On Fri, 23 Feb 2018, Jeff King wrote:

> On Fri, Feb 23, 2018 at 06:29:55AM +0100, "Marcel 'childNo=CD=A1.de' Trau=
twein" wrote:
>=20
> > shows me a quite different behavior, so solely rebase not seems the
> > full problem BUT `--rebase=3Dpreserve` will .. o=E2=80=99man , really, =
is this
> > intended?
>=20
> Yeah, the bug seems to be in --preserve-merges. Here's an easier
> reproduction:
>=20
>   git init
>   >one && git add one && git commit -m one
>   git checkout --orphan other
>   git mv one two && git commit -m two
>=20
>   git rebase --preserve-merges master
>=20
> at which point we've dropped commit "two" and its files entirely.
>=20
> I don't know much about how preserve-merges works. It looks like in the
> loop around git-rebase--interactive.sh:931 that we mark commit "two"
> with preserve=3Dt, and so we _don't_ add it to the list of commits to
> pick.
>=20
> I think that stems from the fact that it has no parent marked to be
> rewritten.
>=20
> So something like this helps:
>=20
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 81c5b42875..71e6cbb388 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -921,15 +921,20 @@ else
> =20
>  =09=09if test -z "$rebase_root"
>  =09=09then
>  =09=09=09preserve=3Dt
> +=09=09=09p=3D
>  =09=09=09for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
>  =09=09=09do
>  =09=09=09=09if test -f "$rewritten"/$p
>  =09=09=09=09then
>  =09=09=09=09=09preserve=3Df
>  =09=09=09=09fi
>  =09=09=09done
> +=09=09=09if test -z "$p"
> +=09=09=09then
> +=09=09=09=09preserve=3Df
> +=09=09=09fi
>  =09=09else
>  =09=09=09preserve=3Df
>  =09=09fi
>  =09=09if test f =3D "$preserve"
>=20
> Because it at least adds "two" to the list of commits to pick. But
> oddly, it picks it directly as a root commit again. Whereas a rebase
> without --preserve-merges (and even "-i") picks it on top of commit
> "one" (which is what I'd expect).
>=20
> +cc Dscho, as the --preserve-merges guru.

Your analysis makes sense to me. Please note, though, that I would not
consider myself a guru on preserve-merges. I think this mode is broken by
design (you can blame me if you want).

Ciao,
Dscho
--8323329-2075280518-1519688037=:56--
