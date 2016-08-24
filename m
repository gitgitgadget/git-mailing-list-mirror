Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F951F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 15:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbcHXPmA (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 11:42:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:61071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754101AbcHXPl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 11:41:59 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MZwYd-1br6cx0Sel-00LohN; Wed, 24 Aug 2016 17:41:52
 +0200
Date:   Wed, 24 Aug 2016 17:41:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dakota Hawkins <dakotahawkins@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Duy Nguyen <pclouds@gmail.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Git for Windows documentation, was Re: [git-for-windows] Re: [ANNOUNCE]
 Git for Windows 2.9.3
In-Reply-To: <CAG0BQXmmW_0n4OMQVsVQ5+OKbNVpgXmXeExFUOXqY8nH=sg3Jw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608241740320.4924@virtualbox>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox> <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608171507530.4924@virtualbox> <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608181022250.4924@virtualbox>
 <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com> <alpine.DEB.2.20.1608231553030.4924@virtualbox> <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net> <alpine.DEB.2.20.1608231736180.4924@virtualbox> <alpine.DEB.2.20.1608231758260.4924@virtualbox>
 <xmqqzio3uw31.fsf@gitster.mtv.corp.google.com> <xmqqa8g3uppx.fsf@gitster.mtv.corp.google.com> <CAG0BQXmmW_0n4OMQVsVQ5+OKbNVpgXmXeExFUOXqY8nH=sg3Jw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JUBfGPyMsIy9S5/mxk/4A7p2SB4UCJ435uMEM/5FepylDAk+Bl3
 40j/Rvw8kr9ijUVgiFDArIWvRqDCbLHYpevQcD66yGS89i4AjbHyOQ8mB1rCyF7VfFIkukO
 MEhKHuXfW+BEs4Sbbk8J7SDehjTdVgMSgqnCxcftqe+ZgZ2E6OxttYmvtGumk9I2aPvOEUL
 8TyK2Yvx5ldFjByKamQjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sO5HnpBB+8U=:IoiyHMnG+MfETgmuK/EXBz
 c1dgbpAKtSdOChkJsnaQLNATVYXR/Sdo/jTmT+qQ+yF6l37e4Q2/eX4OFQrgrv835YcNzxPQZ
 mXVzpZBurdEllhn6hZYdToxiVfDKpPdOb+3X2j5aR39n2/qYhXF5gn6Rdq9nAfb6Vwku3dz9T
 oAc1lJ42+B4891GSQn6SRuztlektii2dOzPknXSH+2NgGILEfx3gKRbEvJgHNNo47AnYW2GzM
 5iLfs2Jy+JRhzjC4tOZe20lpsrysU2LjBAcPm9Kj82QMT07v6GgeBHerw6z8r1pi/4zCSEpFC
 p6IcW3HNVSyR5ZawhJ+BvCae8cGI0fkIlq0GfXDa/uQZVbWcDxbqhqiX2T3/g4xribKsSAhhI
 wgYyhjtocyxl99zNKjZPdaUgN3LnpOOwZjKhb2YVoCfV8rwahPUhGA14Odg23Tiit+Ez73+FB
 XpZAQGvhagvM1DBUItQM83xfgkiWuICyZvRvmPvksuGmf7EXo/JibH5Sfzi4pBpDsGlUnjBo4
 L0SmALz16u6VItmODM/LPRBBrK89LMjxT8k/PTtzTz9ML0oE3yp2ohEbrU385HLln7j6xdAVO
 bmDJnes1Aq/H74RH1HXZ9EXVpUFNCaGUHYmr/VSHIfWz4bnMjWiOLa64AsjJVGKWK6WEixX7r
 2p2t2zx6xNEV99zRWjcepM4uye0nfloFmGunOZEPqcJKSVsOoDhE/FB+Mi+IH6ddBGBycq0zH
 egue2MuNtpCIJ0eHQMfHYFV2780USIx7F9jwtBBP7iZ1MTJdszWzVq/zPVY3xt9bEUcqFbThS
 1YwGH6L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dakota,

On Tue, 23 Aug 2016, Dakota Hawkins wrote:

> I use GFW almost exclusively, but I pretty much always consult the
> upstream documentation anyway (because I find it easier).

Oh... I thought that typing "git help git-commit" opening a nice HTML page
in your favorite browser was good enough.

Do you have any suggestion how to improve the user experience?

Thanks,
Johannes
