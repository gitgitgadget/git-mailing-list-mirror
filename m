Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 365CE1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 14:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753748AbcKUOWs (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 09:22:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:60155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753032AbcKUOWr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 09:22:47 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ldq55-1cYZWM3fCl-00j1D9; Mon, 21
 Nov 2016 15:22:41 +0100
Date:   Mon, 21 Nov 2016 15:22:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] i18n: Fixed unmatched single quote in error message
In-Reply-To: <721cdca4d000627fa163da15c515a50fd9529a62.1479644251.git.worldhello.net@gmail.com>
Message-ID: <alpine.DEB.2.20.1611211522280.3746@virtualbox>
References: <721cdca4d000627fa163da15c515a50fd9529a62.1479644251.git.worldhello.net@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Q5k97fFn0Bqe4swYDDw3Mo01oanOKGZBma5RUVMkcpwrQQPp4PO
 X/P3GRM99htShlKPmq20cz27y8tLes1wblJbXthzRDqRT9xuRS1sFdXMyC2ZdAw6DzBvw3h
 LtsV32a9rhuTyIOe1QZArkS+sewg0cKj4U8ZDH7UafYCtxXAolAW70C99Y7CbqtxqSh69Hz
 oEihv+l45GSWnFXLGFarg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3HRe4xr5kb0=:F2JBwUNFYhAP78JJairEVG
 YAHWqBpDO3sSwlRlY5ZuazzXbwbB1gmciZAc+IHlKz6x+bvUBPy+79+wr5rAdny2VY9hgOkYJ
 qUDhU2WJjuc81p6yfFSkZFr0WUJ6wFyz2WwMkB9ahnRerJYKMJhfQlxcOKeh4hWmdZ6wIH6LT
 kSAB1Sh/GjCV/rLinbBtaWqeYwEQYICC3Fr7vJbaEyuM6PFe1kbY5K3PB/b3BwcJsoKs4zMoO
 LusqLFdFO3+1AceqjNabXAJXw+fSRMbZyYgRmQs2ZLgx0Lso37rbqxemz5M7AsLLdmIzxJW3D
 kXG394AZRbmM9PQiYASqoryZ35OWj4ifGOPL5QmTA21R6BTUkdu/Pbwg+d0mmI/YW+M1pe9V9
 PSNGIwpqy8fEqhOX0SZLidqPeGmH2bzR+h4ssf2RrdJARUiQc4mfQxq0A+oA5lliMGjpc90L5
 ASqFSAU9amxj7jvCcxy/bK7XqtftAcCqBdkMGTzYSTEaRuMQTBc20Jpure/tzTjOmyQFOc6yc
 r05/tPquW8kplmGLKHu0Rd3RAVGLbGxlOH+A7eDSMGqtg5fpQrVqMDDF6Gw2yfv2tvveOiaaS
 8WbBH6TjUgP3emFkR41+Eexr/j+ww8YJAseUeuk6olyqejGQbCQ2I9jTovQgHKfJg/RTJAE2m
 pKK67/WmWhivQjaSTwa03aQpY7UM7TWFHj32tWF7cCuyVKn09qKoFD3rRYD0P3TJFGlZf0U9i
 aYMz+enE1q/UDmyUFz8rj8NrqzaFj77LxiGq9PaS8aXZCifmlkMiUKcjDwYl7kUCbCoa7HRA3
 E3oqMrF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 20 Nov 2016, Jiang Xin wrote:

> Fixed unmatched single quote introduced by commit:
> 
>  * f56fffef9a sequencer: teach write_message() to append an optional LF
> 
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

ACK!

Thank you,
Dscho
