Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8448B20357
	for <e@80x24.org>; Mon, 17 Jul 2017 16:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbdGQQGb (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 12:06:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:57938 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbdGQQGa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 12:06:30 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MAhWl-1dMwLD13fv-00Bw9O; Mon, 17
 Jul 2017 18:06:24 +0200
Date:   Mon, 17 Jul 2017 18:06:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?Q?Tr=E1=BA=A7n_Ng=E1=BB=8Dc_Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Nelson Martell <nelson6e65@gmail.com>,
        Brian Gesiak <modocache@gmail.com>, m4sk1n <m4sk1n@o2.pl>,
        Vitaly <vitaly.gorodetsky@gmail.com>,
        "Ying Ruei Liang (KK)" <thumbd03803@gmail.com>,
        babycaseny <babycaseny@gmail.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [L10N] Kickoff of translation for Git 2.14.0 round 1
In-Reply-To: <CANYiYbGyCbzxPuiUUD5XBo2zAfKiZ9XQcEu_=s8XxsMGP1J4Og@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1707171805460.4193@virtualbox>
References: <CANYiYbET27mNrZZTNmn_dKBHLLEb4wJiznZ2O1X=WQ_GtamN7w@mail.gmail.com> <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <CANYiYbGyCbzxPuiUUD5XBo2zAfKiZ9XQcEu_=s8XxsMGP1J4Og@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1938505165-1500307584=:4193"
X-Provags-ID: V03:K0:RZhIQSnFNpocGCCqmS5bum/gzsaasKaAAU/GBxbvJKXsx29ok4y
 e0D4V7irNi5aj/PxOYQ0W8jIKaODcvw3I1J8J3tgieHXWFUPDc0UbQ3zU+tZetdHiiAXNu1
 vrV7kL/RnI7ldIE1TboRpzznvmiuKuJMmRTl+Gjte4yIMBBDFxfzgHZGLlxgsRCAxrcOCda
 lL/8+2hE6znIrYCebUu7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7+tLcmIrVmo=:fHJbVFQdMRKBbLlOsvqbAq
 HsQpIt/Y/u3BhPvrTCVaHioEqWeDL049SvCOPtX5Qs1m4SVVwBX5jcy76t9cxDsVZ+WW1Dkrq
 SEWfePI3vo6Zsi4W8oXisof5q4n2D37u+GGJ27gsIVBrVL2ltotjpv0sBqEd/DOnxMvQe5oCG
 2Z28UDVT2fSy1w/jgaEwLtNY7jxnbuRQhd1jp60qFR/dAmRbAFzAbUOShUbq7HlmJPlXp4bh7
 smiemrC/ZR+wlTx9fv7w0AFkkYxVwMqnIvcsp+EqSHXL+7Jy1OaaCQFzXBXkjqQU2KQ0qO3lZ
 g75mWe53OWvI6ohFGyROgr4Dkwas96/+/+YLfRyaRP5424UEda8ksyhh46IJqbrW89+GtOXBS
 soVSXLJpqISPMgEObxISO8zARiE5j2YlAfinO0KSXp2pqNWJxKhvwmsHhnjH9hwbt26tD4mlY
 RCu2dZ2+97rSAvEZz+3TYzhkLirL0xNYSCMnlOuOYLcdFRasfYKuY63L90TceKu57a/+PYqa3
 9F+BFPJ/OUM84WGhCYjtBnzaRNBUxXBcMoZFF6FSKpHrTqyglExCUB5lXqdCBX71G1CD4OCSZ
 5kS2oiV2m5o6GNH83FHIpqo3LtXKtVekgf+qrn3qi4U4GRUxbCt/2kY2I15W0Apz3ZZf1aZ3o
 74eSyvAUArKA72wuVz8etR+AfDAlsSUbA2niCQ/zQm3+pp6jKwiabhkWTHjO8kgb+cTmkLYg0
 gorpy7HpIekbw/wBayXSJhiYWLVC5IZiKa+JauLqROBukXlBjyYhC0lVLOaKJ1DMM5jpNu3IF
 jvGWd2u4siODG+gJDXDR52/CxH4FvyTGzZDvFC2bk/PjnpSayY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1938505165-1500307584=:4193
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Mon, 17 Jul 2017, Jiang Xin wrote:

> 2017-07-16 3:30 GMT+08:00 Jean-No=C3=ABl Avila <jn.avila@free.fr>:
> >
> >
> > A few remarks on i18n:
> >
> >  * commit cb71f8bdb5 ("PRItime: introduce a new "printf format" for
> > timestamps") does not play well with i18n framework. The static string
> > concatenation cannot be correctly interpreted by msgmerge. I don't know
> > how we can combine variable format indicators with translatable strings=
=2E
> >
>=20
> We can add a new wrapper for raw timestamp like:
>=20
>     +const char *format_raw_time(timestamp_t time)
>     +{
>     +       static struct strbuf time_buf =3D STRBUF_INIT;
>     +
>     +       strbuf_reset(&time_buf);
>     +       strbuf_addf(&time_buf, "%"PRItime, time);
>     +       return time_buf.buf;
>     +}
>=20
>=20
> , and replace macro PRItime in i18n messages with format_raw_time
> wrapper, like this:
>=20
>     -                       strbuf_addf(&sb, Q_("%"PRItime" year",
> "%"PRItime" years", years), years);
>     +                       strbuf_addf(&sb, Q_("%s year", "%s years",
> years), format_raw_time(years));

That would come at the price of complexifying the code just to accommodate
a translation tool.

How do you gentle people deal with PRIuMAX?

Ciao,
Dscho
--8323329-1938505165-1500307584=:4193--
