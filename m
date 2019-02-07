Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36F3211B5
	for <e@80x24.org>; Thu,  7 Feb 2019 19:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfBGTlC (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 14:41:02 -0500
Received: from mout.gmx.net ([212.227.17.21]:48563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfBGTlC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 14:41:02 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMkgl-1gkyBf04bP-008dEc; Thu, 07
 Feb 2019 20:41:00 +0100
Date:   Thu, 7 Feb 2019 20:41:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Giuseppe_Crin=C3=B2?= <giuscri@gmail.com>
cc:     tboegi@web.de, angelomelonas@gmail.com, git@vger.kernel.org
Subject: Re: Possible minor bug in Git
In-Reply-To: <20190206221759.338-1-g@evil.localdomain>
Message-ID: <nycvar.QRO.7.76.6.1902072040360.41@tvgsbejvaqbjf.bet>
References: <20190202063828.4kjtdmrsm7g4eyg3@tb-raspi4> <20190206221759.338-1-g@evil.localdomain>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1298356534-1549568460=:41"
X-Provags-ID: V03:K1:oPJqtOmm4wcrcQDvUOUX0LsgxxFy/3WFwV1zdDiKG5Q1MX3LnpC
 80mCzVy39Um+UAk4rqyQb+5NV0h1bSly+HimE2jPwLT5SQ2Dc3YhLL/yxOXl1HGh6dqv3QN
 /x6b/NUxyu9UAw4YktUecqlQnahSJUW+JnBFRe7o9HU/0kRU0HpXJ2plOBwosdJU1CJzmjp
 k/Si5t50IIQicT7ApAL7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:50etOWkaPYw=:+DjE/w8VeDzE3TaMCIFEq3
 b6a/ecw3yc5UnpB1Rk9dhP9keHtzKiJ41Zx5hV41du25+hSR0tKyKTS/3DOFeuMdJs/GSpIVU
 VVWC1C1wWRU6KDIT8BNSVLWlVW27yhGwMf/MgBl3q0rsa+lOc3hvmrYHqHVLBM3xDAceyOJbP
 vcgx3gxcImaZvjEpBw/gOiR3fa8dDLyh0Oummdrs8fd+woYExigO26G+BzQUgxyhEL4HRJfeT
 qGn9WN1UqR6EgpPLdVaqDsj+fuRlR4cZA3tLCatRu7C3fADHuYToO8UBAjz8eydFAUH2ExNvy
 wl9/bONE54R7UsRVdL6wTUBNqZm40iDhijxR7v5csfTOxHsuSUqBnddbQofwYWdOf6MAz7DEO
 jXOZoECbJmM/z7GwH1nlVxxuGT4HtLHm7Tsz6Dw7KPU1Fe+/jaSNFOPNlHu8CfbEmPfr3oqHB
 bN481T8najGU23BYzjdB01FDbnQgzaNcS5msVGHTcjESJcwkPqSOnfWL0l1sL3bFUgQaLA1Ea
 1Ld3bB+93D8zS+xAhl1/McM0Vc8kwEFzRC2vJiaiPb6tHBXH/wQE6rN4ICWYMu/EJMXja1CS4
 dR1mB/oeOUEF2hPMifSvnVOEqcQc+ZHCmUwijfXp57eGpwjUY5APmcAIW4ziMiCSLQgD03+2r
 7ypywYbpwJ6C0+ujtdI92xAYq2ofVq3eqWr1/n/Wkcv1+F1vNn1cvGrRv1DjHJDcpAbJyhjGH
 Rs1MNeaWA7UBmFKKX7IzQ4ybU4KIJWwVopGm91/8KjnKP9j7JPUr9PEG2W79SsP2+RKiGjy35
 bnJJp32J7FQPndfZMZQV5sap32iaP8cCm86zmm0trc/A+3GZYIOZYY2IaPrQAvkK9BF03EY+J
 clmrQmVbhABycZiRRZ3OL6JQGBmf9Kgb2g7yL4fvdrWB3YQBvYIQed9bSk+UnobUCvgBdnKfU
 HSV2bV92yxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1298356534-1549568460=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Giuseppe,

On Wed, 6 Feb 2019, Giuseppe Crinò wrote:

> I wanted to have a look at the bug, and I can correctly reproduce it using version 2.20.1.windows.1.
> 
> To start to even think of fixing this bug I need to build the source for Windows, but I got lost on how to do that.

Does this help?

https://github.com/git-for-windows/git/wiki/Building-Git

Ciao,
Johannes

> 
> Is it correct that I should cross-compile from a POSIX system (GNU/Linux), using x86_64-w64-mingw32-gcc and Gnulib to produce a static executable?
> 
> Am I missing something? How does people here build for Windows?
> 
> Giuseppe
> 
--8323328-1298356534-1549568460=:41--
