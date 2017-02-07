Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9CCA1FAF4
	for <e@80x24.org>; Tue,  7 Feb 2017 11:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753813AbdBGLv0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 06:51:26 -0500
Received: from mout.gmx.net ([212.227.17.21]:56021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752595AbdBGLv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 06:51:26 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lxdfb-1cLprK1Ttz-017DQ6; Tue, 07
 Feb 2017 12:51:17 +0100
Date:   Tue, 7 Feb 2017 12:51:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Tim Pettersen <tim@atlassian.com>
Subject: Re: Google Doc about the Contributors' Summit
In-Reply-To: <alpine.DEB.2.20.1702021007460.3496@virtualbox>
Message-ID: <alpine.DEB.2.20.1702071248430.3496@virtualbox>
References: <alpine.DEB.2.20.1702021007460.3496@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TguS5D9u4HjJ6x9mv04qgnmnuEbsozq0R8gY3Mh5uYxhLM2hJby
 xF9xDgzGW9NR76ITYLrN9E4CbOyqXkseETUuTOdZz6YkoJnatvCrDKBhqcZI/o5cAkhIbb5
 lxGZwvCqWjM5pjAGLd5zci0DioJXblOrRlOvFJ+xRNeMSBY+UY19mayoRND27B1Zha7bSdL
 dXAslyJqhqX005tmgyChQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q4Ww9lQEgWY=:ZMtkCVqFOL/lPUQn65uF81
 2EOkPGnVHh/aO2umplKHDu3auzyQRz2ZCfrjDnpdQg74rwMsczXvTvnrE4fGn5xa9rGQLerH2
 DXnRfZvBo86GP+L50d7QMBbg6Zq6xAIIoubnzmn/pNtQe2UrfFIP7qt7k718NGBf2XpgXrG3P
 l3BPyowMh9p9Aqe0/LEZ5+E93BMABNPEHMYxJmKaQnJmDH/dcuGNENjQ4UcYjmP68bjzF+PlF
 tu19YD2Lec/LBGXmbwnCJQrJwxrVJyXEY4XVqReKUH+Klm6hkbG9OWYg2OvddMUtQhTQS4glp
 eDstpoPErmwGVNgsu3ovE2ZVcFKoE1wpClOTfYkmwnQXTKuKT/mfawTyg7WKArkmB87p6LUqg
 EuQ/0PvgIe+OQenj3JYeOoEMEcR20z0eMQFO2MAkGt1TOSKHgWWpYfTZ8V3w3LCF89w+P8Q+N
 8TL76rh6UHGlfyWwBZl+2pHu77yDGeEDvtmDZuatPnS8qr+tW9WbOgGUjKIXW2rZXefro8nPN
 GZwUDYx/gqpS6MwfiNd/9V2Km9o8BIO3GWNpJHlIdqbgvX3Szqvgm0KrDYGQdovHedPQt34qK
 ievPNW4wsTJjGv3bEwapCtBm6RmC+uPrb4tHgYmvv55sc90R5GVYZwm0+lSs03oIXox6fNYq/
 SqFo11MaFrYaw65uJVIgXRkVk0Sk9bYvc3KWTaL4bx35z6zmB0qAevRgDomA40Dics/6BUnhH
 wEhlD5JiQCUrjbgeD5J3nUHKULdN+QT7x6qHU9vBA2DqlaLMvZEZ6PM3JcPlcUUP0E49J7GjW
 apujXOrXPjjT95AJ0W9ibcQZQX6W04oQaVsc4sxeZCOyy67qPhMeAqNeHEV4ssTlUos0xwe7M
 iLHKtoD21aT71B5DOa1rjxGsdwQuQz9PwBboPYsmr6DjQQDxFbDzmtwtohDSeIL9HXzVxfgb3
 9W5JBAbsx3OfjXbYfsRseY64zUStvjf4BdOUwndcYVbESL/Z2RnclBthZWUg/IM6PZmOpIZ3L
 LT7JJ7KXPFZbGExdnru26fs/bza9P1uCVUh+TPagNEUrO0sj6GU95OOaZOznkDV3jw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

On Thu, 2 Feb 2017, Johannes Schindelin wrote:

> I just started typing stuff up in a Google Doc, and made it editable to
> everyone, feel free to help and add things:
> 
> https://docs.google.com/document/d/1KDoSn4btbK5VJCVld32he29U0pUeFGhpFxyx9ZJDDB0/edit?usp=sharing

I am terribly sorry... yesterday I simply tried to restrict editing so
that nobody would just spam the document, but in my haste I even disabled
viewing.

The link is functional again, sorry for that.

Thanks, Tim, for reporting the problem!

Ciao,
Dscho
