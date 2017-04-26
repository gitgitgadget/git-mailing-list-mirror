Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B4F3207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 09:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1953860AbdDZJqU (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 05:46:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:62236 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1951819AbdDZJ2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 05:28:30 -0400
Received: from virtualbox ([95.208.59.147]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MA9Yv-1dEXe43bqL-00BIUv; Wed, 26
 Apr 2017 11:28:17 +0200
Date:   Wed, 26 Apr 2017 11:28:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
In-Reply-To: <1493165607.29673.31.camel@gmail.com>
Message-ID: <alpine.DEB.2.20.1704261126130.3480@virtualbox>
References: <20170424032347.10878-1-liambeguin@gmail.com>  <20170425044320.17840-1-liambeguin@gmail.com>  <alpine.DEB.2.20.1704252148400.3480@virtualbox> <1493165607.29673.31.camel@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2089543234-1493198897=:3480"
X-Provags-ID: V03:K0:RU6AUwMETnvryK1zLlaA57Ra7ZsoXyyxySNIn5nsDGKPoz+2KmK
 E8a7JghOnxH+xJgZCp5Xz4OqrXOjLwIB1D3Vj135DgcMPWK70pbUPw62IZBWkUeSBM4S/Lo
 cTaZ1bp3TcFX3OfsDMjun2igOvlkI+t5uKywGwxfiX8ZRm0PvLilu3eISnFARV2NeWS8enV
 JMUXSVk2A3WCteC0iq84w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YP/kPZYYajg=:CkDPc2uPOumP7r/727JAag
 CxCfUBkR9CQ7TUS7BFxrh1CDq21McBlwVl7Az1g8mypt93Op3xO9RAuNNEtGEJ/UqrGh4Q5Tg
 t//mGeZ/uIZY0SzDni8g2Z8685zcbL41PWm+g6z7Fu0AnZeSRoookhR7fSkVrFvCB9FG4GBXl
 TL2rk7O9EtzW5bgdk0sx31/aIDdwVJZ3Ho4M5/VDWKlz7t7b+luIWNN9qigmPXNELr2pu2dZt
 CustWfvDgCEGatHTm3mQkAsA3zkZnEiNle23M4Wr9MaVFC4xtbCToPdYkWR84utkvfhOblpO9
 XW2qDE5dfj1R2tJODeYNyDhNf5iLN1XFlSy3j2XBu8RPRvU1h5V/LZFbrqttjIXW8gKZ+jCta
 MUoL3XWoss/TZaPcg7/tEHbkDUs6YxYPHR/A+5b9ad8eKpSm1tRlLzWnAUcPh3dS9fq8r7Vjp
 y/vY6QOmbwYLY4bpe5MmOf/bkmTkSF4WbqCyytFNGjXlF2B9YW4ahg5faD8yXmQPez+HuLXiG
 pf7VjLNl7fCHSO9O5KF3/fiMSEvSwHbjfDGXUoFykureytkvOudqMLjVkDwouGuCPUidlU2B4
 YNt1kPtHgqTwA6Z6VwlgbvRdweRpAkoWJ8YGmpSuxVTJhPSwDNlMwzjYW7huToe+xFJz7lejm
 hhxlKgRzao//UTb+luELi+ASNMMbs1hvWlOfYCWKh0Q7E/p/jqwishDasqovQSOZUvaWTfB/W
 hmzIBGeZ5raVh+XQYWohOuYzG741CJ9lJ8O7pkBNhTuJF6QAtSx3EB+PfSzsjFUQ00QkcYkk8
 NoY9aYq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2089543234-1493198897=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Liam,

On Tue, 25 Apr 2017, liam Beguin wrote:

> On Tue, 2017-04-25 at 22:08 +0200, Johannes Schindelin wrote:
> >=20
> > On Tue, 25 Apr 2017, Liam Beguin wrote:
> >=20
> > > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > > index 2c9c0165b5ab..9f3e82b79615 100644
> > > --- a/git-rebase--interactive.sh
> > > +++ b/git-rebase--interactive.sh
> > > @@ -1210,6 +1210,10 @@ else
> > > =C2=A0=09revisions=3D$onto...$orig_head
> > > =C2=A0=09shortrevisions=3D$shorthead
> > > =C2=A0fi
> > > +
> > > +rebasecmd=3Dpick
> > > +test "$(git config --bool --get rebase.abbrevCmd)" =3D true && rebas=
ecmd=3Dp
> >=20
> > A better name would be "pickcmd", as there are more rebase commands tha=
n
> > just `pick` and what we want here is really only associated with one of
> > those commands.
>=20
> Wouldn't that make it confusing when the patch starts to handle other
> commands?

Only if you use that variable to hold other values than `pick` or `p`. But
you do not plan on that, right? You plan to use this variable only to hold
the value `pick` by default and `p` in case the user asked for abbreviated
commands. Therefore, I think it makes sense to reflect in the variable
name that the purpose is really only to reflect the string used for the
`pick` command (as opposed to any other todo command).

Ciao,
Johannes
--8323329-2089543234-1493198897=:3480--
