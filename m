Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4968C20248
	for <e@80x24.org>; Sun, 24 Feb 2019 14:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfBXOVG (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 09:21:06 -0500
Received: from mout.gmx.net ([212.227.15.18]:34875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfBXOVG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 09:21:06 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUI8w-1gX06z2xMo-00Qydz; Sun, 24
 Feb 2019 15:20:59 +0100
Date:   Sun, 24 Feb 2019 15:21:05 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] README: adjust for final Azure Pipeline ID
In-Reply-To: <xmqqa7iloiwl.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902241520260.45@tvgsbejvaqbjf.bet>
References: <pull.128.git.gitgitgadget@gmail.com> <b9997a4a3c7577d745a6084ca007d188ba9ff6c4.1550933361.git.gitgitgadget@gmail.com> <xmqqa7iloiwl.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WoF8OJ+veuI2ZjDRAt1GTIEn3QdV4Sqo8VqZZOBBG6V0tmpBPir
 8+s3TsZQwapRI16G9XewTsto3S9VVYiHxCeOZ4mQRkVPE75BRlZrHhyJTzrQprIYh4i1+wa
 TIjN7IsStubI1/3HZg1dVWYrKLvhZwW9WZx/JAodBMlXPVuF1MNckSsA0im9VD/Sv0fFlsm
 T4pngYQlOMHauHZwAuW7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MI9eLgfOMcE=:+kI6hZdQx1hcz3j4CmdpSF
 IZUOOOvdje4YSyjkXQKB22MKe7xXa10ikw2VmoWvXYajvLNlBx8XSXVW6IOcHMJzq3emSa6VE
 diVsSKyX01NRSibfftDNNfPakrE0ifdVWStP8MlAOV4Sfqk6s5C+z1mzFmM/pY1YMkmUvsgsE
 Ec8ye814yZgLoLdoXtoUWp9wL3UyH5A9/91ewPrto69SlDP0zs2DE0j1j9t+oY6QFt8/KQhn5
 9LTtMaVUrJrcBj2b0wrZZXHJ/0+BfAjH3KfZKl+Q90k54+PNod4fGqggFZBKPZfOayEuFcbEV
 YsWhXHxfOPyAAJYETfZ1csrclNHG3imA/OjgHWHzJsnz4Z5vOe0g4KwTqognngHpDtku/7org
 8JZ0HTmig2G1fs4oSMBqQ4VpDLjfKnGeRnpDN2vTzoNmc+JMY01qbUeU2AezTbqBF7m6eepA9
 65Atgtlsm4dOmK2LSW0AfhyG0jSdH1VWswqOAt4JpnrCny7/1h5fXUYC7j7k+WuRQ4Z9YQO6w
 gheF4hxUabOLmFDpy1tS/tPmdEgJ7eWzzZKjQPoXcloFbFeoHhJdHtzMePh+ZlBlgOK+h1hZd
 OYxE34KizQ9S/Ph8HvSB5LNMMQ7L0vadxMAySpzHxZbGN3zRvVeEnPCXGItKtCN116jmOOM8p
 CXbvC0Sd21h941V07VEoRuG1xAiHX42ulUqQDTX8XO9x9i5s3jGtT/XWXZ7ZA57B90ZkgKMul
 DhhvQ2P/myqgYZ1LfNquPMjQBij/om5iv8XKxJA7NAEBMD3GznB4ncoyUplZ261yvvw/6/l8i
 P0Yc9CS7CEH9hhseQUPI7DW9btt2aEr7cWO4TsojAo2O4nEAJPGHTnhqmmZ6DqJDPfU+ZQpZR
 PHjrJJiDDCuKJ2DFtUAwKVPso5kks3mlmZ6b4XbLsARdYZeBhzIq291ewGcf9f29KzfYaU0aj
 JnPuI5AC7AQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 23 Feb 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > During the six months of development of the Azure Pipelines support, the
> > patches went through quite a few iterations of changes, and to test
> > those iterations, a temporary build definition was used.
> >
> > In the meantime, Azure Pipelines support made it to `master`, and we now
> > have a regular Azure Pipeline, installed via the common GitHub App
> > workflow. This new pipeline has a different name (git.git instead of
> > test-git.git), and a new ID (11 instead of 2).
> >
> > Let's adjust the badge in our README to reflect that final shape of the
> > Azure Pipeline.
> 
> Always happy to see declaration of victory ;-).

Yep! I did take an internal victory lap, too.

Thank you for your help and your patience on this issue!

Ciao,
Dscho

> 
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  README.md | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/README.md b/README.md
> > index 764c480c66..88f126184c 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -1,4 +1,4 @@
> > -[![Build Status](https://dev.azure.com/git/git/_apis/build/status/test-git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=2)
> > +[![Build Status](https://dev.azure.com/git/git/_apis/build/status/git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=11)
> >  
> >  Git - fast, scalable, distributed revision control system
> >  =========================================================
> 
