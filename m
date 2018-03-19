Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3E451F404
	for <e@80x24.org>; Mon, 19 Mar 2018 14:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933522AbeCSONx (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 10:13:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:36179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933518AbeCSONw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 10:13:52 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvUwp-1eWX6T34zb-010e2u; Mon, 19
 Mar 2018 15:13:42 +0100
Date:   Mon, 19 Mar 2018 15:13:20 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     "Briggs, John" <JOHN.BRIGGS@aei.com>
cc:     Bryan Turner <bturner@atlassian.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "git-for-windows@googlegroups.com" <git-for-windows@googlegroups.com>
Subject: RE: getting fatal error trying to open git gui
In-Reply-To: <CY4PR02MB22621A5F713D150BCF4BDE71FFD40@CY4PR02MB2262.namprd02.prod.outlook.com>
Message-ID: <nycvar.QRO.7.76.6.1803191512120.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CY4PR02MB22621DE7751427686029C1B3FFD70@CY4PR02MB2262.namprd02.prod.outlook.com> <20180316195756.GA151588@aiede.svl.corp.google.com> <CY4PR02MB2262A567EE2D2A54316BFE3FFFD70@CY4PR02MB2262.namprd02.prod.outlook.com> <20180316205243.GB151588@aiede.svl.corp.google.com>
 <CY4PR02MB2262A382E033B50B3800A69CFFD70@CY4PR02MB2262.namprd02.prod.outlook.com> <CAGyf7-HmO_URV3kuB2t=PJ7Wf=t9UjAOYbpCLkUNiDPGQ7ca-g@mail.gmail.com> <CY4PR02MB22621A5F713D150BCF4BDE71FFD40@CY4PR02MB2262.namprd02.prod.outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Qg31bEsAr1Efu7ueKeKDEz7G/2NPvpY7aThXlFVx0uGVQ31gOzQ
 jTmRRLbFFVI/sOLeyd+A6Zv6TObVu17XcNhMJ1jL+EjJVywBR0Clj9E11RztTmGutdSH4sy
 Uw8NaIbXPvjO7rygGBWeCD9CCLfK1qrT4Ghk+K2angwDP9YpJWG41CZHTqIKaOqROWJcYFa
 6NQV++iwEyklsK7jouVpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z6ietDH4ONQ=:H8wVYWH8PIASCZ1dnx+oNI
 kvBld6W3qUYMRjxAQMAw09QDOvz5nDJsJN/NzLWc41/Yvht5z8J1s+gVYGvDEIIZfYN18p2co
 hvOxf7kLQK/eCYsa/4+iG71442p4CtZbeW/nhKp6365/QGpBWzytXdOmINnydxvpDv/jdR8F6
 QLVrbV2B6uiMOWtK0K5utzABfrgLljr0xLIq68eSCS+NEzZpDUH2J1LFPnaMzeNkENRzYUF3z
 6fhgV0uDTWJBM3x4pX4BB2hqaYtOsOWbE9QtV9wkYLF/v8yyOwXVavqv/1mPBGaO8Ei+c3woj
 a7OgR0BSOQ96NsaRoGHin1zVGM2bKSsKGSp4VL3sqPjAbp3TjwNrCyoMYs2ws4sasLyWp9VW1
 urGi1EzXP3bW2MR+sZzPZIH2Y0K8iL1Ub+lZLhHiaQP6/rsZ5ua5fE1EKuvBEYUxGIYedMoxu
 E9DcJ9KL990R45ZRdeQ2q9KNCViDpWzzIJU4VUrAWvsTtE7Mg8N5m73GqjU9dz8sc1w/1NtxF
 AMgeJ3zC/XOdSksOHMhXFzRCga0FMLdVzzVcdVj8k32dXq9UNr6BiakFjF22w/dWmIoUmii17
 9OdTp0/MuI++l+rdKYMVEbellWr4PnfKRGOWEkLgwU8dJH2bmVDtd2HJckEVOT805qZiCIWGu
 5nR4IVKCdadYMXzqTjx9mkwRchNFFvT+Pip7286QgT4ZtYn0PrZW728fJJ0X3rJTnHZm0AQoX
 8RYtYa599FX02CnO0lNk3B4s8Tk2I0yj6wELgT4HgwxG1970X+pSg8xM+7ZsmlOlVWs8LxrDN
 kalhJg0wGRLgtK/JiM2SKa0I/6br97Z7xdNREncMIf8r5HJcMA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

On Mon, 19 Mar 2018, Briggs, John wrote:

> I used Git-2.16.2-64-bit.exe to install. I used all defaults except for
> editor, where I chose Notpad++.

If your Git GUI mentions something funny about the version string when run
as normal user, but not when run as administrator, I do suspect some sort
of PATH problem.

Would you mind filling out a full bug report at
https://github.com/git-for-windows/git/issues/new?

Ciao,
Johannes
