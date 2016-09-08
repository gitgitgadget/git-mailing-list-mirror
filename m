Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6403820705
	for <e@80x24.org>; Thu,  8 Sep 2016 18:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753561AbcIHSTY (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:19:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:63562 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752377AbcIHSTX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:19:23 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MGS9o-1bmRd91nd2-00DIia; Thu, 08 Sep 2016 20:19:19
 +0200
Date:   Thu, 8 Sep 2016 20:19:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     stefan.naewe@atlas-elektronik.com
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git for Windows 2.10.0
In-Reply-To: <3ed6f32f-6330-3453-1581-3a2d4008bbfa@atlas-elektronik.com>
Message-ID: <alpine.DEB.2.20.1609082018410.129229@virtualbox>
References: <0MZD0K-1bNOQ13s6O-00Ku7h@mail.gmx.com> <3ed6f32f-6330-3453-1581-3a2d4008bbfa@atlas-elektronik.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-205081867-1473358759=:129229"
X-Provags-ID: V03:K0:bbK7oXheXcWnmw+AChwRXGfDawHNy7Fi0RO6E9Ry9n7iR95gReK
 iSdR1xYXGFATPoZ9EngSsoGZE9VtweoKwP/5JwvbKwcYP/goZO1EA7VKrN0pqzQJjKJN+s+
 LZe8y8jLdc4Ab/kxmtPQ9b1uDHr9iKvc36jApxlUOSgyUR0oG7HfG5AFR6/6Mb1G5WH8eUe
 +VMTD+w1QkWLiV+UJ76SA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QUkCV65TebI=:2oEhMui9vAzCvo25h3JSpV
 J1l989N7yydXh60mvL5fDZvROEbYLmbg8qjz1f9Uhv+S6AvCXW5KMTFczMUX0N8w2dd1qD3LC
 +PxowNNFoMX1EmHKv7GHWnSQtKNcOB+taCwFRBnloXbrYew+21Y/bJbTF1FJidseuPSsrUAXr
 z7tvExLE8CYbkCh9wpnBUe2ernEbCNE6G9+AFLaqihv2dUl+W80LUQwiT5EAnIGkScowfvnDs
 I27irFQKOdIsk2hJGob65H8TZ0dt886XCJSRgPhUmFhnGrg7rK0nU267qTnYNhuNEy/eTkcX+
 FR7Uxo1kBc2lZ3IyuRX61glu95F/CvPkkgDUe4spbW/TRH0GKoPS2fswuotIy0JrGf96NV/BX
 C853U7EPM6A3977ZFCLWiVK3dwa4YC3A7DbtPaWdgu8JlEf1UpfbvEr3wGI31yF0Beub30I97
 iSVjH58GQbxBJPd0SQSEL562c8FphOw+WYruwwv28EbYz1Dvj5FfcB5a/E31fbXoLPZYX/mMy
 7tcdjCkrj2e+Bfr06WkwRTIyOJxLDDr1yZxsgqsPir/vh8o2QC7fUpIRCLpXhw9/vUNIqn0kl
 quP7EFzQFo7g5xa1HTCrX+IpQSoM1z0J5ByF+SDl9qfiPCKVM/ZNJYJyYFBb2lfFw8VPxsQKL
 kZySldd7UNDI8JjgWwW18S5EBHmZXPHHxKXMk1639EGwGqn05RHQu1SwyDf2kPhuUYuTzejZY
 p9LLsZFvW4Iix04u3VP5Mab7b1a3+7jieo6FMpsYJKlDQLWtthDl8l4W4fWNfXoIsIMmX/CBX
 IQABMZp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-205081867-1473358759=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Stefan,

On Thu, 8 Sep 2016, stefan.naewe@atlas-elektronik.com wrote:

> Am 03.09.2016 um 15:17 schrieb Johannes Schindelin:
>=20
> > New Features
> >=20
> >   =E2=80=A2 Comes with Git v2.10.0.
> >   =E2=80=A2 The git rebase -i command was made faster by reimplementing=
 large
> >     parts in C.
>=20
> I finally had the chance to do a "bigger" rebase and what shall I say...
> F***k, has this thing become fast, or what!
>=20
> Thank you so much for doing this!!!!

I *love* that kind of feedback! *beams*

Ciao,
Dscho
--8323329-205081867-1473358759=:129229--
