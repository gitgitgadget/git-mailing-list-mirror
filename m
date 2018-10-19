Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92561F453
	for <e@80x24.org>; Fri, 19 Oct 2018 15:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeJSXg4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 19:36:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:50979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbeJSXg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 19:36:56 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MH5Sw-1gRE7d0lta-00DlQQ; Fri, 19
 Oct 2018 17:30:19 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MH5Sw-1gRE7d0lta-00DlQQ; Fri, 19
 Oct 2018 17:30:19 +0200
Date:   Fri, 19 Oct 2018 17:30:17 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luca Weiss <luca@z3ntu.xyz>
cc:     git@vger.kernel.org
Subject: Re: No --no-gpg-sign option with "git rebase"
In-Reply-To: <22001585.W2CEcL5IrY@g550jk>
Message-ID: <nycvar.QRO.7.76.6.1810191729080.4546@tvgsbejvaqbjf.bet>
References: <22001585.W2CEcL5IrY@g550jk>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:v4pT4Ws5ZQ96f/PDFOpsbXdUjyg1l/k7CuSLc48yiJhI4AS8+mY
 l7VTkb+cIJxuelfR0/Ozf9LkPHpIKWyUpHdYA/iyGy6tIgJdX2CMAvlu/jIjEzC6sAPpIHX
 PwAXyCbqHr3GyYQT2sL9G6tAQpNW/jK1I3dTKXL0tITROEcbE2oF5WZKKC2gzz+Gs2N/+Yd
 uxtfLpBQkFhcahHZFRSkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HdqlJ5Kvfx8=:e34ahWCrMn1EO+b3BOzGfR
 zkuTHfBvDWsE7ztfE6QEV7S0NjPsHO3XS4nz7W2gLd4y+2ZMTUTMP47SuFMoMFFRG4GcFAbAR
 AAQ+VRaaQokcg5ZlyQwj95gBV4yoq2cVzaa48uz+LzTlOx4JszxmT0xIqVutj6lTXSMxQ1FnT
 yvfMkySwzQVXgJnC6tVuIRnfLc4AzATAw73tsBX9ufDdhSxF8y3zNtb0apGLaVd/xuacQH8CY
 WNlLsQryPGMCjuwy3C6PMlglvWtAe+GSxciDMMvVuUvcMyVfDdEoqUpsu8Rz7VBF06dJQEpK6
 c7TBU6vbcHmkuWPuL9cTi2GBR3eXyAakaQcpdvk43O1F+iP2zGXVVsC3kzriGqVAAdmISoku5
 AWSYcyVlt8NBQiS7m3XRM2STWhVk045gWUUFTIEAx9Facvz/PqCGUqAQ9hAhqDdGynPmVx5/w
 bGoDT8bRGxX2r9lGnTdVY7wE5oo64QB6G7MmhSxR7F/T3Q5C/b7c2tHWUsp1q8TRl+v2/894w
 J6WUp+jGRhfVZWHzWHXTuHXykcobzlq5+0Lz9zj+4fOPAoe+ZE0nuBdsnBeF1zdsuQW4cyJ+1
 V5k5S4v3wJl1POlKpzF3PO2ZPeNuqdW45wHpP+fT3rt95uec15tKqknJmVI6+v8IOWUDS/+5u
 bY6H5eTE9TQWVe9Y7acjKEjDy0qcMjYtm2sP4eCxCk9kWe7L5SSUCOaOLG4tyh16uaIXpzoGr
 Db8gK3U5a/riJ5XGbGoq2l2+wxpp8ZuALApBHJ2VhRVUj6fECNLFTrHMbuncNEQVMshbMp7mi
 jeUf6BkVLuhHa2zUDUb4UF/fbFSO8i+FUar1MScTPfG2FPjFek=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luca,

On Thu, 18 Oct 2018, Luca Weiss wrote:

> See subject, would be quite useful to have this. ("Countermand commit.gpgSign 
> configuration variable that is set to force each and every commit to be 
> signed.")

Have you tried the built-in rebase? It's already available in `next`, and
it is available in Git for Windows as an experimental feature.

Ciao,
Johannes
