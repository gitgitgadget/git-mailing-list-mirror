Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646AE20282
	for <e@80x24.org>; Wed, 14 Jun 2017 20:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbdFNUbJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 16:31:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:63396 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752510AbdFNUbH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 16:31:07 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MI5rO-1dP4xg2rU6-003vB5; Wed, 14
 Jun 2017 22:30:58 +0200
Date:   Wed, 14 Jun 2017 22:30:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Rong Jie <loorongjie@gmail.com>
cc:     git-for-windows <git-for-windows@googlegroups.com>,
        git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git for Windows 2.13.1
In-Reply-To: <c198be1d-389d-40f1-ab7f-6c61cdcbc37b@googlegroups.com>
Message-ID: <alpine.DEB.2.21.1.1706142229080.171564@virtualbox>
References: <20170613133510.7688-1-johannes.schindelin@gmx.de> <c198be1d-389d-40f1-ab7f-6c61cdcbc37b@googlegroups.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SsE4kTuG+98QNibxuRdA0ZFDMPrFTcGFtGdvB629ejnkgQ2AZ68
 5DP2PqFhOM56TXuT9ExNy5Sb/APHOK18gwZ1axVQCF8VPdzLxJ1XpJ/A0ptpuRQCj2ECYlL
 9w6RZVqene/RliU45HE8hdOWyVdd4JoyofFhG5+IRACkTSyUq5I3As8ouINGqPBLKfqjbfI
 NhwPg2fZzPWml8xct/33A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2vD+ZSzk8xg=:o1x5DNSySXxszk7I/cEcrr
 r4YgrYzT2D301sOnQLP55lYc+T6cmAqLsjUDKDx/KD5KNh7QQ2z6mkcQIqgd0lRVfJkVO1Hoi
 6b+N4wMrxstWOZ5At2ICGbfXvUlh9HQnhfxZ84Cn4+T8B3g1FfGIfxkTbxbpel5hQo6atrkLH
 oRL5RZ8Iw4RmTXoCLw+FU0QT2KuDBEOtrRwduKpZEKoEy8Tp9oUlHbX0tBxMIkaHIgEmnAXOj
 brYbs72cTyYG4dFUGvLQRhGhbTKTVNFc+oYTdsnEL+rTr880ULpUGPH2F9AtOY/wm3TDrvXyL
 92kGBELIhou8CHrwYSEK6ZeSMM60hhT7s/T3AG3y55t3ANbSaWvu4F/XBzLsERm6bDMX3bXqW
 OJviE6X7rC+H3THqcmU+cN3GqX3tN1AOscXZN95ILBjZXJ4SBQZwYu+dMocEQpOW/s6tvf4r9
 JKBrTpZ+BOFzToUuP3f//WSawM270bU3CQOGKLGG26LM2gRQyXMH9aPW1RhxrIchVxVdw89qs
 vbJwdqkMvVdHGpSyRyz+qZcdYBq3k0v0DHbX+G9FDU3DxhBDH/pEtDqAvVxKGukwrq3ffQ1yv
 jnG1hwZbS+tcXoPqFa8B/dwSQbCkiT20nvn7DLV7AhrWkQ7Asm00lOcaV6e95WpRuaa3KI0My
 Z+AbhgpI2M9XfCQLSoyd7+E7rBpAFJyUI1/JIkp9kSIxSMONpSAbaowv2rGengyUcDPyL3KXh
 4ny5oSfYJNETCGok0ttNK53kiQ0rm2aLHkBhL101rXp8DNb7aKT5LJWEU7+aUf5cp8nioCAE/
 2JHG1xh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 14 Jun 2017, Rong Jie wrote:

> I am getting crash (return code: c0000005) when running git diff. Rollback 
> to 2.13.0 fixes the issue.

Please use Git for Windows' bug tracker to report bugs, after making sure
that the bug has not yet been reported already:

	https://github.com/git-for-windows/git/issues/1202

Also: could you test the latest snapshot? It's available here:

	https://wingit.blob.core.windows.net/files/index.html

Ciao,
Johannes
