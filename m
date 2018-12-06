Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34310211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 22:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLFWUb (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 17:20:31 -0500
Received: from mout.gmx.net ([212.227.17.20]:60449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLFWUb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 17:20:31 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRocn-1gt00f2j7J-00SyvT; Thu, 06
 Dec 2018 23:20:08 +0100
Date:   Thu, 6 Dec 2018 23:20:07 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     William Hubbs <williamh@gentoo.org>
cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, chutzpah@gentoo.org
Subject: Re: enhancement: support for author.email and author.name in "git
 config"
In-Reply-To: <20181206191737.GA31091@whubbs1.gaikai.biz>
Message-ID: <nycvar.QRO.7.76.6.1812062318570.41@tvgsbejvaqbjf.bet>
References: <20181206181739.GB30045@whubbs1.gaikai.biz> <CAN0heSp2g0A82YYvMw-RaERESXFtj3TgPKA3RysC07Lf=tHBcg@mail.gmail.com> <20181206191737.GA31091@whubbs1.gaikai.biz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1209197589-1544134808=:41"
X-Provags-ID: V03:K1:lD0aTrzkGrCWODKpOKzNG/CdqnmEobrGIiEUtVtfFqhTooDHJaj
 aO5RhKiyRDxp5Dubfj9HEJm1QsQPL8V5+e1SB2OYJ5xUU8CvWj5KWSJ79PfpfyNkOO9geQi
 Mn05wenGMemUUEgw6XsUPrYpv1tK5TEcHnlp4wrsEEBpft1fQRIejH+cpWNfeAsH0XlmX7K
 e+6oYLFbMgz+isgtEoZ+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kN7/cplLQM8=:8gvOu9K3ZfFbA2odicUuzr
 g+4BaRUemZqrdwv4SBEbPWRcUgRAR7NIWk5Cu0F4c54PkaI2KiI9UWDZFzU1zqDor69lUmeZU
 3vr9fqPOE3crc1iItB+9e9vMVp6fA9NbFbH40nOg8MU0xbcgEHcg7ID1AHkQOCPBeFb81ziCT
 rnISpxy0i7R5fJE6lmOqfGLZj835GPNa0Y3NZZNaCLTnl0Ue9hZOzjZoaP6voV6I/OWuWQop2
 5uRZkwg/mT9ADC+eKdIawNZXZ8kcU7thsqYNtgufjM0WvqXV59bBW9RaDdCSw2OA+VPEqFTzd
 SusIsQQOa5m7fj52L1dakTrk8xfHAwxMsJoFTt1pJfsjDU+dW8OK/6vvR0kr8Ivye+LHC6AaX
 aPMH5IlhqkOU+7R9q61L8Peuqf8nkoXOZMMQjb3cZxjn2M86245bNdy8MOPKXEodnuQhiNcz2
 xMMDBMCs2RDBGvWdk1jWVy8gAGXQrV3hLnssV+nK9MxyjmpKKja3DUM/0PIgBU52kQrzyD94D
 mYsNY1YWWN66BOWDNXSRui/Fu25g9H3n5YxvyVIzLl2XgWY9QXA+Mn4wT5gJUo3q/L7EIaHhE
 I14Av4cwgzOULl4dsjA76aPANUCrwKRWN1Jg/fFJae6T5jtN9oLafO0CW8+cRoPHe1HsN4ao+
 zjMsVt9wzHYDICBJz36BOYhXgcDEJ6n2g5cApw9NVrlVI0c+gA1gkhYYPh+bVBuE7QRtb0rMd
 zDAzNxQqQDymgt30h8kLW5hRSqru+vpYyv1yFPZX4aZ+YBNBoX++psB1KC2eWq3nXYDng2Aft
 FdG1TbjlD6F3wOHxJ1tKTqomEP32+cxdwYKLEngQOO2OiJzvOvSI4kRF0QxOCtkR0F+q3AF02
 CU78GDpYA9GvckYgiGXZBOKvB35VlqFLDK/PBZp6PSAyYx/8Xkzs+KlNGnLHUDuP9b6X5OQRk
 WDGHqs3ou7A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1209197589-1544134808=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi William,

On Thu, 6 Dec 2018, William Hubbs wrote:

> On Thu, Dec 06, 2018 at 07:38:08PM +0100, Martin Ågren wrote:
> > Hi William,
> > 
> > [...]
> > 
> > This idea was floated a couple of months ago [1]. Junio seemed to find
> > the request sensible and outlined a design. No patches materialized, as
> > far as I know, but that could be because Eric suggested a tool called
> > direnv. Maybe that would work for you.
>  
>  Yes, this design would solve the issue.

There *is* a way to get what you want that is super easy and will
definitely work: if you sit down and do it ;-)

Please let us know if you need any additional information before you can
start.

Ciao,
Johannes
--8323328-1209197589-1544134808=:41--
