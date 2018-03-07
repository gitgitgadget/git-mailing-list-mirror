Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CEFB1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 14:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754557AbeCGOQh (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 09:16:37 -0500
Received: from mout.gmx.net ([212.227.17.21]:41719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751234AbeCGOQf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 09:16:35 -0500
Received: from [172.16.5.73] ([84.88.84.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUm1o-1fCA0F0aey-00YDLw; Wed, 07
 Mar 2018 15:16:27 +0100
Date:   Wed, 7 Mar 2018 15:16:28 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC] Contributing to Git (on Windows)
In-Reply-To: <20180305181333.GB28067@aiede.svl.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1803071516070.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com> <20180302044409.GC238112@aiede.svl.corp.google.com> <xmqq606ee89v.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803031721590.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180303182723.GA76934@aiede.svl.corp.google.com> <663f3fef-30bc-8900-6070-80ac96cccff0@gmail.com> <20180305181333.GB28067@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MIJFBFD7WbX2AGBGMFa2ad6QrkgQMNH0DsGRLPHvOmBzQNKfNlN
 BV1LvI173d+9LMd1pZEdjnE+qwRS+JbVV8T+BJskRAjSqFLOC31+drbqwyuG92KAo86UdW3
 9JBn12SubUIdL2rb4RxERHSq8obTa4XFkYSyynLj2PmgDhnQCYsm4dyNUWy0Srnfnr2OvJK
 WGn/3IQ/rw1GoHd+CEbAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zTaXONxXP6w=:FCVeSJ7hlIHn0Bj35oFy3c
 wPW4wEboN+T/jofpigF0ezoWafyTsJx1EOT4KZmW2JqmvnNmQHeqL6MxxNuLubuQznEcyIt/b
 LnZS03892v57dJ37jVCMqrFgl+G80jmsEwrNMncJZT2ejmDqchdmkbpHiAzA2K2morPTD6EN5
 O94VydMm9Zg3yx5Yrci4IuD7lFY+4GhGjQeAvlqAuTOV+0J6M0YGFGE78B7fu9VdoMNrlxkzc
 Vi16zhtaG/6j/99+gU4r6lhlUlu8sVftfZkY9QrfTEhIfaNtW+enwwNXpE/BmwXdbK22tAJGg
 9UDJ48KmqJZXI7pfV+LmhMVYEAMRP8Ss34fs+FJzM7xZrm6iwpvU6xxpnA8PtreJ2Gm+oLHfK
 N0Z907GPIgxU+GG2qHj2Y9hHEML1izZCVKqjLjcM/E9rs4sqjsvJmx+wtBAOvNpYTAEl49eee
 4GEYu8lF9NA+QukQ0sp83qNDTQuatvMzQL400HxMS94UjaFZwcSHseUMEIsdzrglS1RKoNo2H
 sYEglsyvs9BRAnMf2xN/lXby8ClaB0h5zuDoT1y8hCJSrRaWN8T7pArCKJc5T2OpEC8Osm23O
 d94jQsNImgm4TOvjdh+WHxugYI+9ErvSjg2EuskISN5vW/9rHD80R7UUnViBWCMpMX7GFKWq4
 dLdflqPfMeqNLnqaS9h6my1xicfTQEVkDQxI3zi9pnJof3aoL/xxcVyCY0nKQTVCW3Exe9UWl
 /5wCYIkW7m3oPkvTJj3N2L8hAlcvjLdxV1SB++AE7LHFHLgjGTQmRSZZgcX53cA82ZiHN7E14
 pM3VhBhgfQff10AHShB+HJeFHiJNo3WYo8uua8ZEgfX3E8AtBA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Mon, 5 Mar 2018, Jonathan Nieder wrote:

> BTW, thanks again for writing and submitting this document.  It can't
> land soon enough. :)

It landed:

	https://github.com/git-for-windows/git/blob/master/CONTRIBUTING.md

Ciao,
Dscho
