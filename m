Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F971FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 18:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbcLJSSy (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 13:18:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:50273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752259AbcLJSSy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 13:18:54 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mam2Q-1bwSxq2qhW-00KRwv; Sat, 10
 Dec 2016 19:18:44 +0100
Date:   Sat, 10 Dec 2016 19:18:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Klaus Ethgen <Klaus@Ethgen.ch>
cc:     git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
In-Reply-To: <20161210093230.26q7fxcrs2cpll6g@ikki.ethgen.ch>
Message-ID: <alpine.DEB.2.20.1612101918040.23160@virtualbox>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch> <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net> <88bed7c9-4d5d-45d5-5d13-6a8ae834e602@kdbg.org> <20161210093230.26q7fxcrs2cpll6g@ikki.ethgen.ch>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fk+wSjF87AN74SvoNXu2H05bVhlzfIM8p+3q/i0kIfmrDWdJyK2
 49gcMgQOhDIL45RiVKmgYLXvbz8vkd1Taw9Cynrh239szCM1rh0EpmGN2LzdveS0x/q1X1I
 cDHbx0SFFKuSfQ3771WbhcqlNQSM99pNyq2oXka3XvUp8TfA2inZbvLjlvN9Jwm2P4T6hGe
 HWEVeHoveJ2zeQyasEhsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6ZkqrquEmY4=:HF1o1AA5f6ezikxP0V88vE
 5jhmnzqYkXc9e6HKREFd7tSJTN973+3UYclyoFKUWRR8G7k7yZL5whtUCy0tFaAYn7mAr9d30
 MENbYMeIMgsXTKXWlsuvfzVvouj7phgSyQNd8cFV/qe89j2JfZf+2pXfhWnR5lmuAUb110GBq
 zrwz6kbGo4fLdv3STwBGAReg+dozQJKnecKkBfzMd2l0HuQGzDMdfNX7LcO+O/HzMSBja6zcj
 +mMiGdMPvjftb6Vg3ierFAUtu9bHkojGSOlD44JTCMdHxLGPc3/6mzOUIhqegyE6YMkTVgowJ
 O4J4hKV7uG4aeCOHINsbdeM4CLEiY3jqpA2WR0GndA7DyzkVfaLNO3mLfhfVwm6PWvDqZa7ca
 +vvMd86GSZDwd7lJPVFDrItaIHs0AJXyXTOkoNjnOW4xCdVQkRuMyAncF0vpKJLtUY4w2TPsA
 MAe0gezz9QqujFagW1OTn9CHU9rkzXT2d9kJcNUGpnJQkXM3Wp1y4sBtJoVyMOmogX61UdK5T
 t3e9orZCzDXNT5fguFsuWWE11bevKTPuncx5hx/rztGMqp0Is2AQ+y638hNua7JaizfswV1S+
 +lXtKv3KxDZN1LgWfIGxYWgO098MQF+ekrfEF9vaWn3OLEuY6W9aJxLhefvivCWA6VK/2psxi
 4YrJcv28s9qguwJTBX0OS/C4S08uOL8xOYSdVBeqp7zzlWRF1jhfJ6NKYpkXQWsd7NQxmSKDX
 zzFtigOO6AQoJHaCsEZS5p3KjbPSFg0PE6Vsy6peD31ydjsjShkDuKAd2veTMOdtKIFJA+Z3Y
 OmZskx7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Klaus,

On Sat, 10 Dec 2016, Klaus Ethgen wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> Am Fr den  9. Dez 2016 um 22:32 schrieb Johannes Sixt:
> > There are too many systems out there that use a backslash in path names. I
> > don't think it is wise to use it also as the quoting character.
> 
> Well, the minority, I believe. And only the minority where the command
> line git is used anywhere.

Please provide evidence for such bold assumptions.

Ciao,
Johannes
