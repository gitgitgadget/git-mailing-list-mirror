Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92031F516
	for <e@80x24.org>; Tue, 26 Jun 2018 22:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeFZWIW (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 18:08:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:34903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeFZWIW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 18:08:22 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3i8r-1gOwG82TYX-00rFqv; Wed, 27
 Jun 2018 00:08:17 +0200
Date:   Wed, 27 Jun 2018 00:08:17 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org, joel@teichroeb.net, gitster@pobox.com
Subject: Re: [PATCH v6 3/4] stash: update test cases conform to coding
 guidelines
In-Reply-To: <2fe77c0946231dd9235d88922e4d56dd7f5c66c7.1529943789.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806270003150.21419@tvgsbejvaqbjf.bet>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com> <2fe77c0946231dd9235d88922e4d56dd7f5c66c7.1529943789.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PkxTMElL9WOPEnDqKp1KyjBFhQuSsTrW12OCfJtDfA3qaLVKToP
 GZfLukXZDfQhDYx3oYC4r7tMQxbyF+ztbk2dtttIy2ps2QqKM+Y3vGzmt9l4bGvM0lDGvP3
 UBi4JVr6bZUO2WxjoWG7AT7QzC2ROQTzdGdznuKcF9CBpesXnv/wZXv9QSPcWhwN1HcmDvT
 qh6YlSc0at3Tr9UNV6W8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ajw+iJd9Qvo=:vGoH4TfosIIvYl8p6Np16E
 mkh2DzCTLDn1e+7IiyB5ZzwPpl4VuoO1HDk8Bvd0ewPKAnujIJjKIQUT7AKVJkWl5WpaBuvUr
 MAcj28KKLPWQcjSwkTELuQsie+cW20Rh/vZSgywLnO65vXkqvytmlG73CvADZgGHJw/glQl1w
 xgi5upkyE4qQCSDk14ntvbViOfkVdp6O0JAmeOltTPTmeLYO6/WD54cW6rwdsCacHKziuJscZ
 GPjvGrJVYiTqGg3obqEhhmcNbRuxde1SKYM94Z6kQqrg/2L+rQ/iqxTzf9xSrorgL+ToU+eCL
 L44FWmyKQ0TMO0tOhUNCFFq/qAAI0+uVofyowQpBnU/7TEHhJ0MNSDvnFHOR2EU805EmJAt8L
 E1jHjBmIIa/2mq8Ck7I1xxCGTmPEDoSfdX/v2iAPAiKsDz5MrWhDnnJiMYpxwR/VHHy9wTyVQ
 HjeTDXWV6gUDF0MtF+djG5qWUvY5F24LVSWjvyTkHXrOjy1go/fPvhMf1CuMLZeN4cnsnhVAt
 8gpY7W5ivp8zqXU/iHCYsZMshokzGFmpNSGMSExEc/1GlfUsPO8z0WrxMV3z9b0JOHPtK9yNG
 9wdM57VLEpginJM1+qvQanzvfrqdK1bbOfLSnFoli1tZMODkFKrjNxPNDokIRfOwnQvVr4YZA
 ZgI3ayqisRszKPcXW1M9dEsakts9k4PUvVcqegyGtTONZYxywGv6E+QP/bONwFbIuuO6deCM2
 wJUO8onMz/ljT/dwIMfysRBiKLyU8jGG+hkqMN/LZG8jDzdGBgDlcY5s4j7cAA77Et3PcNe9t
 sNx5EBb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Mon, 25 Jun 2018, Paul-Sebastian Ungureanu wrote:

> Removed whitespaces after redirection operators.

That is accurate a description of what the patch does. Let's add the why
(and change the tense to present tense, as is the custom in our commit
messages):

	This adjusts t3903-stash.sh to conform with our coding conventions
	better, by removing whitespace between redirection operators and
	their file names.

The patch does two more things, though: it breaks at least one long line,
and it renames at least two non-descriptive files to the much better name
`expected`. Maybe you want to mention that in the commit message, to?

Thanks,
Dscho
