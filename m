Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCE9D2018B
	for <e@80x24.org>; Wed, 20 Jul 2016 11:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbcGTLNs (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 07:13:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:63121 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbcGTLNq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 07:13:46 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lskr7-1bEeJK1PdR-012IzY; Wed, 20 Jul 2016 13:13:43
 +0200
Date:	Wed, 20 Jul 2016 13:13:21 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:	Shreyas Mulay <shreyasmulay23@gmail.com>, git@vger.kernel.org
Subject: Re: 500 Internal Server Error
In-Reply-To: <578F3AF7.4030702@gmail.com>
Message-ID: <alpine.DEB.2.20.1607201312450.14111@virtualbox>
References: <loom.20160720T061853-541@post.gmane.org> <578F3AF7.4030702@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-948702099-1469013202=:14111"
X-Provags-ID: V03:K0:2Wn2zUXO82KQkvb8HLaYqsf++v4yjXOv+Z54l0rALAdlS3bX0MQ
 2raWBUw7p7krreZRkP16QdF3E4sBJgxiv8QsX5obXMGkXyfX6UeqRsW94YmOaBMWRVVaQ3m
 9PymenN3ul3UFyTeqy3bMbWe02eaZeidG4gE1owSRF2iq2hMGsmb12KM/xtXGOjLtXiURGA
 QSr2PSgypCdjvB2/bUGCg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:fxCS3H3W91M=:S0at9kxlv3VuTD4ZUte687
 O2K70w3lZkVv2AnOYpBGyUA0GoopqXw+P8ljfssGMbyqbtNlMY0Hz0bOVP7k+gWvMs1EkorAL
 buHD4UJwcJwvFyBG1aFDOEMlsHrFDS30bYv+rAUOhGjDuEcsL1IWEtpU6ivffZ2/IuWLpsizv
 IQqRzrczSF2sHN5h3SFDJ9OGCy22Qmfmk+vJAT/Aqn1TxDOHcTUambgnX4XuRoIDNjnWyRn4l
 aurmzDqiyUOZY2tGaevuta6bM+lxqqHd0koBA0qXGpGOHAGtnIx7xHXZ1vQdimeSe56rofsVb
 gFqx1wKAr8C0wNcHo3zZud0Z1oXClgho4P8V7xrGRM/igiFOiS4YYcpYrBpSoLjEhq1yN21QL
 X10swWkBqlTwLESsDjyMYI5OXrk3OWR1fdTvL+INqEkZ7ycWzp76QyQNZtH4m4q7EANOnQAft
 wZf2huV8Beq6OgQxwm4T9/Mll6/HcwxIlawCnTgXvicsrHJgF3uVLcyu3u/Vml0wk8hQjfHUC
 m+EypBps+nI8xf1bieE59NzDX5Y50zfsmm0EKedy28pBdJn+y7zUFY1Z3gqcTNMqCD9bNe4mN
 urg5AbgH03q3/oZ0zfbfUjQrlu2Y98EI0L0q0OsM8FQdx0TFSqFzVD3kDTFL76YGyq/4z/Neb
 6yCk8BP9h9RepmmqK1ZjllpL5bn/kRd6MEr6oPwItuwDX/eDTsdAqGKhX9N6mX3MbQC5RGqRK
 f+t7dEWdFr5vjxuhd0PmWMd83WEGVapGZR05rdiFEfWhyFJtOAuKwMcnquChJfFGpdg30P8cT
 PG2IMzT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-948702099-1469013202=:14111
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 20 Jul 2016, Jakub Nar=C4=99bski wrote:

> W dniu 2016-07-20 o 06:22, Shreyas Mulay pisze:
> > Hi team,
> >
> > Great work on the documentation provided for GIT on https://git-scm.com
> >
> > But found an error on the same, to just for testing, I switched to Hind=
i
> > Language (Clicked on Hindi link on left panel) as for reading the
> > pages/book in hindi language, I got 500 Internal server Error.
> >
> > I hope you rectify this issue.
>=20
> The git@vger.kernel.org mailing list is for a development of Git itself;
> the bugs on Git Homepage (https://git-scm.com) should be sent to
> https://github.com/git/git-scm.com/issues -- as you can find on the
> bottom of the page... though it is not obvious.

In addition, I believe this to be an invalid bug report. It seems at least
that

=09curl -i --header 'Accept-Language: hi' https://git-scm.com/

does not reproduce the purported issue.

Ciao,
Johannes
--8323329-948702099-1469013202=:14111--
