Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63F420229
	for <e@80x24.org>; Thu, 10 Nov 2016 21:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935127AbcKJVpm (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 16:45:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:54303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935681AbcKJVpm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 16:45:42 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFctN-1bziNu2Yuj-00Ea1U; Thu, 10
 Nov 2016 22:39:03 +0100
Date:   Thu, 10 Nov 2016 22:39:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>, me@ttaylorr.com
Subject: Re: [git-for-windows] [ANNOUNCE] Prerelease: Git for Windows
 v2.11.0-rc0
In-Reply-To: <B2BEB5B4-5CF0-4CD7-A8E2-50D51E00D2FF@gmail.com>
Message-ID: <alpine.DEB.2.20.1611102237230.24684@virtualbox>
References: <alpine.DEB.2.20.1611051025030.3108@virtualbox> <B2BEB5B4-5CF0-4CD7-A8E2-50D51E00D2FF@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:r9fIWeVMAx7Ztk2HguEpA6nioE+nvmYA34XzgXhzg9S4VPyNuBh
 6mhWxgxFBTy++z9XzZwNDK2j+HlSx8m58nFJRS4fWiyXRnTOsu2WaEXhAFgYMZMVJoDmfin
 NXfItYAkTVmOHFy2X7ZhJW684cC06/ElYN1n56oxCKTKZhpilow4sYTJRULCbj+t6N9Oy3U
 ORDmWwjVoHubaf994JA7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7QCgA9Yf6bA=:Udvo1/qKUmCBFjY4xamBtS
 kD3BJ2q8T9nqK8dixYLElvK5zWcq2CPObm69/267PxV00ifLJZMOf0v685+sPUdicAaiSutzq
 H2ZpqcOX3X0QAtOKOs3XZJ3t8xSuxEnZ8175SXaIIHNXk6GucYtt0eYfaCpXrmPJdHIUHX20f
 Oyyxa114MS5MrvvQTqmumm8MWVJwIX3DrNy6qRZsOD3qkxSH/U7jjXtW8wtNR0G8e3PuO5C8l
 n6q3LiRtJBJHtI56PHrUw3lG4K80cE1kLfK8EhCTzJgVgSJxaksg/X5qFB7zufxFHw2I51BIH
 uU6GqWleMKS0Ff9LOdh9wAmD9puOTxbgyyOvGbwdkwTXdSvXK5zGzTe9/Ew1A9qQBkSA+ii0j
 sBtnrOjC8w+z/K8b2Ijdd+ld/Hj9XjUsSAWdl4Hde5KcGnjcxMBRkdHT4hCXgon5a/kWmE56L
 pNsUyVR9mEtcietZwgnlhg9Lyr2HdDqJV8mERWAwQe2RmMzhntkggHCAb3K4+4OQkViUqd4S5
 DID/QRpdygdUn/T1h1TzDV2fucR7Fn2WLx+rEaUps9E5e+uBfeBa5EIP2EexsHm2c1wSiB9dU
 du/IXoIQgRCAlfzg6GYx+6yZJMXhAyKAKUpiqoqvSyhGgb8IowvkrqeyCIFx7nInqiVeKbZGQ
 pKpjOykqFNb2r9uKNnpjdTj+wKRiHcYPbDKvF6YhbjNkSrdRRURdALKX/PLzu79JFYzIglo2v
 e6zuAVMtDc92ZTR5doOLWwmkObYokjS+zPfabyVt7TfTWKwI/BT/Mupxgj4v0PgCpQpkvsSNk
 Zd8GOht
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Wed, 9 Nov 2016, Lars Schneider wrote:

> On 05 Nov 2016, at 10:50, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> 
> > I finally got around to rebase the Windows-specific patches (which seem to
> > not make it upstream as fast as we get new ones) on top of upstream Git
> > v2.11.0-rc0, and to bundle installers, portable Git and MinGit [*1*]:
> > 
> > https://github.com/git-for-windows/git/releases/tag/v2.11.0-rc0.windows.1
> 
> 
> I tested a new feature in 2.11 on Windows today and it failed. After some 
> confusion I realized that the feature is not on your 2.11 branch.

Oops. That must have been a major snafu on my side, very sorry for that.

I just tagged v2.11.0-rc0.windows.2 in https://github.com/dscho/git and
will make a new prerelease tomorrow.

My apologies!
Dscho
