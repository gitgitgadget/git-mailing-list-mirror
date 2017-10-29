Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49059202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 12:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdJ2Mbs (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 08:31:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:53185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbdJ2Mbr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 08:31:47 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJGFi-1eBWZu498M-002naI; Sun, 29
 Oct 2017 13:31:45 +0100
Date:   Sun, 29 Oct 2017 13:31:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Alex Vandiver <alexmv@dropbox.com>
cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v2 0/4] fsmonitor fixes
In-Reply-To: <20171026013117.30034-1-alexmv@dropbox.com>
Message-ID: <alpine.DEB.2.21.1.1710291331250.6482@virtualbox>
References: <20171026013117.30034-1-alexmv@dropbox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dfl03hRApvKWJqOMOF6eNn/Xhdm5jHLkW3R2PpS4q1gCVL90p/h
 NpVNz5E4ccAT4VsW820w5f3FK6C71XdgGxE/tPIKJh2Kuysn+gUGwnGrzhjoMxM/qO/sY5q
 jRKyzTpdhruc6AzUtHvBMC3/SUd3tyDt1Dz7SKXsZvinY32MxxWGtV/+5nZXTHCwPReG0IX
 8GdZg9ckYtnjAqRG2wq+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SRmED61uzcw=:uZonvMN8pqFahzMDRuLF0f
 nWRd7dy9e712kX1N2zHAEgDz8vhTxzJevd79Xz0KS1uY2ol1Kx9BkGPZeoioouP1dA18KpblE
 I/u1I9j3ek6VqstPPNA+Uc/FFmWzDR1tBnIqQ1KuUtPknYH4eR6HiSwQSOk8rBxOIwC7VFxeg
 r3FPqIJLcqBxao8aAhDTQxa0jlanIoNTY2qvR2saKeF2TXRIN6YIcfMpvNajfcBlqIFHnDI80
 BHtp9tM1jVpBZu9WE+2LHr1sZtnpghoQRpV6JHKyo15JZmAf46/G01bSmH5ulZUeVONOxnr/Y
 gq1yFQQKv7x2WfkEROpxO5dGF88MOybKUzxPRShvgHIlSpIiXq6bxq+4aKs+5m9MU9OQHJZbS
 dTx+dVo45Wk+BHNSUqRkws0bzz8GUhO+DqbLi2ArJYhdUKD3Ye1M2w24xEklfVFxyHI6H+uXM
 h51gpEAdLci7qg+JuIX4pRgZahwdAA+oeSKT6V2qfr5VmCT4gzzAcNH3lvwoNNZpFCEKQMsST
 6edD9yh7zOgG2BDG8WZjnLkqLYYhHz0ENBxP1w0lIGPyPAQ+8UJMiIKdLZ7ZpDpeLQRwvaKU0
 9V3Vg+mJJCxw9hTyyaBFTSufd5zgINT7Uxwv8JpzaOmTYHspp2uUD2qOudDobIAkfDnE49s8Y
 FXoaraNJiGvoWX7vlTOgbaIterXw+nkLWO3NypMsHqsMHqBUN2NmCFXF4+MXDFSxf2I3NgTTd
 7lZVaFvsuUUAbBrbkE7YAgLf4/cO8iiAuX0WMBrKkAAwV9FJsYa4ed9OoSu0T4ty9wQl9pdbu
 GFJzxgCFe064+O3t8zCXL+tdlIj2HqvfO3jzUkO2VaTBeWMAXNbLiqAkvpGDUEuNot6teXN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Wed, 25 Oct 2017, Alex Vandiver wrote:

> Updated based on comments from Dscho and Ben.  Thanks for those!

Thank you for this excellent improvement.

Ciao,
Dscho
