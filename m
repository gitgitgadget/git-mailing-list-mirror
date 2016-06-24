Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 132522018A
	for <e@80x24.org>; Fri, 24 Jun 2016 13:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbcFXN3l (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 09:29:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:63407 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbcFXN3k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 09:29:40 -0400
Received: from virtualbox ([87.193.220.130]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MFtf4-1bBQx01vp0-00ExTq; Fri, 24 Jun 2016 15:29:32
 +0200
Date:	Fri, 24 Jun 2016 15:29:30 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	UberBooster <info@uberbooster.com>
cc:	git@vger.kernel.org
Subject: Re: Git Bash Slow in Windows (possible fix)
In-Reply-To: <CAB-vh3v1v4+jfs1cyDS-Ft5_1ibGqLzzzmJK-s7MHjVPR3uYaQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1606241525450.12947@virtualbox>
References: <CAB-vh3v1v4+jfs1cyDS-Ft5_1ibGqLzzzmJK-s7MHjVPR3uYaQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lddMMk/Vu1rxRhLUGtxEcP058cUdoBycWgFG9Rxt5C8EeXMFjG+
 opzPKmHSZaAYozsLP2gvruo5l2qJ9ZMh1JpSjwxMZb3iHr72id+lcE6eGyOXL7nfQOT0XKy
 zsXIxArDDk/J8jwz/jKFrm9pZdLprE88HXhyHmRdYmIXzlhfAzF6Xbk+Mq3peHLyadVBs6c
 T1aRebY6de0iN7bviDOuA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:k3FkaL3gnsQ=:l2rhPoQjBbU3KzHsjIWEIf
 Kw2r7e8eXO/JtLK+Ri8Bz7HIukLg3dDpiH4MwLilZsw4PTCwcUGLMNny9ew5QsNhorNZMc/dF
 uf8MFUZdw9aCLEd9erowTSK3nrRi2YMR1DjERijvyPBS3+ayphftTBuDeL+T0N1QoOfU9ZFku
 ZiCWB98peUMMjdqb2fhQc49auNQbK3yWEfbuSAbh4uOyvRYk5uhrJlKfgheNXLDJRpuqTcpcb
 ZR+W1RSUK4AW26BWX+WcPPO3MYutmSPJhFzFHrynQc20p/OZp+oU6zmsgulbLXamxTiEyCZKU
 Jlc/W//3bmUe0iIoZRohbgBks/2dEa0lSeBxUGapwdW5+OV8ond+J2I8Z++Nzsy13r7xd/GPS
 4VI2hgDbXyBG80s0P0svr/sX0fG9kdhyumYPRz6adgVLqvvXyc4tkWxjBQMBoL8v3+iiICLl9
 eG1XqJh05L/NnUJ5RsC7WNmVDdIIW2QyjkoCmxClX6HuXUVmjfo9VXmQg19yuuS1MYxFje1x8
 K9iZflcbPUssgiSw+pqbSo1OqvPfANnZvhsjYQ0kJkaNAE/7X1opbKAkA8c3THvCfKZe3oVAB
 oCQUKI8mu7bdJwdH25u4vZJnHWVuGRRNG3V/Li6ZPrMOsNjGXHGM4GdpXR/AsHWBX4QNFfYVN
 hHbmEEDGhbKozPwSnuRnVVKg8xau0a6WhXckYRFTIEOSpVbc473RMSsaGntrzFwaZG9vH8/4t
 zsq2uqg6r/ngk4GOWHqyA5UJ6Gm41CPp9c+BApzmy2NYdDeFze66JCkoVqyG2XNrA+2eGyEPe
 m2l2lr7
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Thu, 23 Jun 2016, UberBooster wrote:

> [...] and I also installed MS Office 360.  AFTER installing this
> software, Git-Bash was AMAZINGLY fast.

I suspect you mean Office 365.

In any case, it is next to impossible to diagnose slowness after it
dissipated.

For the record, we do have a wiki page that describes how to find out more
about why Git Bash's startup might be slow (it should not be slow, of
course, yet we had enough cases where we needed to find out more):

https://github.com/git-for-windows/git/wiki/Diagnosing-performance-issues

Ciao,
Johannes
