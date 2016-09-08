Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804101F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbcIHHGq (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:06:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:51783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932252AbcIHHGp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:06:45 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LjIel-1bCOY72gWt-00dTth; Thu, 08 Sep 2016 09:06:36
 +0200
Date:   Thu, 8 Sep 2016 09:06:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Alex Henrie <alexhenrie24@gmail.com>
cc:     Matthieu.Moy@imag.fr, gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 3/5] git-rebase--interactive: fix English grammar
In-Reply-To: <20160908043417.5946-1-alexhenrie24@gmail.com>
Message-ID: <alpine.DEB.2.20.1609080906060.129229@virtualbox>
References: <20160908043417.5946-1-alexhenrie24@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:21JsIpCte7zCahvSKAkucNB9QzIWfxBuGUIekhOlX0XfXDktwCE
 koasgtWaSRN8OrPteGf80ZQv/VsGDXatiZRJ8CGY6iLczdxqaJ0GFs8iMWK6EQn7LY/VckS
 J+axENdZ37NHKCBtqf58Ww3MA8Fa8d6RKlL/BYeBUAXxGxNJQTGJ10RQRS2MZ3wLCipNVO5
 mn3futTmdK68SQrBry6mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zWRjNzkS/ZM=:u080t0PZ/Gtkp3SBiB5Hiy
 obF9y6THSLTjlc/61kLZKLCSyhwMnXBi2/wgYGVUcqhBX5s8QW0d1mHPw0uO2lcXT0CQf2afV
 T0sK5ibVJ5sKtD9wiM9O9I6EIkEQKGBcn50R5BvCMKmrxx4oSRiIGBbF3q8GQyu30M6mHdfhw
 eQVwk96iE/3EdRkcMVMGIfDGPFlyYL5XnE1u+yfQR9+B72ZKlv1l1D/q6xujFkZgyheur3/O+
 6g4LGqECMXb+SV0MorWlG2S/H/iDPcNyByON+c/H15z/NqFGchGMadHDLEz84b1IWxhucO2n9
 7Lu4OFtxIUmm2l9+izPiYU1X6sFCo5eoCEqKhw4LD8GBJ02HX6wCIGZKaTD8dhl2VL3rg7BSt
 WJ6wwZLty2iHybtGOAZcubxkJhaieSyQvp4lTX3X0c9Ce4hU5Jqo3g0Fd5zhJi27C7NmM4mJX
 Z/3zwslfwOM3eECJ0TgLzYXNyquUVVpQR9aSx2FH1+GKrUNws36FqMdFOPRJnDJommNRdiZli
 c9GcepnYRWXCJIN8KgcofudMgkjzdoA920ZNZk3j566RpBgPNQGRaEkL48y26d/Jz1I8x+qkQ
 F7AKnSB1sGibA0vvdPkOLZmjcHx3C1B5fXsW/nt+RyrXuchgRnXAYMIiwXUeADCBRrkDDznzo
 Ke6B3viM3WNTLeSBPGK1xwTsnguYdozbb33aH8SpPxdnDLj0PAK/wS5Cgva3gZjIv/hF9Re33
 WRs2YmfNIo4CRkyMeGiTKAc70fdFr9AZtwVcCMjiLi98r3dC8nB4R72io4YetVt2po2+4ltLG
 9Mz8lBO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Wed, 7 Sep 2016, Alex Henrie wrote:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 7e558b0..6fd6d4e 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1082,7 +1082,7 @@ If they are meant to go into a new commit, run:
>  
>    git commit \$gpg_sign_opt_quoted
>  
> -In both case, once you're done, continue with:
> +In both cases, once you're done, continue with:

Good catch! I ported this into my `prepare-sequencer` patch series.

Ciao,
Johannes
