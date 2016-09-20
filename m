Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947D21F4FF
	for <e@80x24.org>; Tue, 20 Sep 2016 18:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbcITSpe (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 14:45:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:52414 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754312AbcITSpc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 14:45:32 -0400
Received: from [136.0.0.139] by 3capp-gmx-bs45.server.lan (via HTTP); Tue,
 20 Sep 2016 20:45:28 +0200
MIME-Version: 1.0
Message-ID: <trinity-6d892636-de41-4169-b9e1-491b5b904a4b-1474397128781@3capp-gmx-bs45>
From:   "Jonas Thiel" <jonas.lierschied@gmx.de>
To:     "Heiko Voigt" <hvoigt@hvoigt.net>
Cc:     git@vger.kernel.org
Subject: Aw: Re: Homebrew and Git
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 20 Sep 2016 20:45:28 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20160920110228.GA64315@book.hvoigt.net>
References: <trinity-9c8f1bd1-d6be-48f3-8575-03be09bd1243-1474213828361@3capp-gmx-bs53>,
 <20160920110228.GA64315@book.hvoigt.net>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K0:/s+8VXhEC/V2W1yJxZbFeQf/XWfyoGzKmxQqG+bk4IG
 804Xm5q/cX8tK5MEPxtnp8cwtm4gDqRW0Pd+r3u8NcckeyEWDR
 w0Ys14StoqjOjPwHfEWCc5ykd8rGZXOHcDHefk3Z69VjheDN/v
 2L3AWEX0Hmm15Mk1qr/slqQxpOFmL7dhdWNTvSAxx4JXdqi4RZ
 NPNM0Z4+cint1vV5d5qrHpR1cRwWzJjZJ0rLz3B5wRJgXcThfU
 WYcDEwXuiHfpamKn0R4Nks7lAHJZt+paBF3toYoJ36BTAW2hv0 1euV8A=
X-UI-Out-Filterresults: notjunk:1;V01:K0:FtybWjquXF0=:UujdBeCGCK0RsnKbvCVBv9
 fkNKH69L68uUHX6nlY7lDwLxuOT/MngjFmkgc6DTZ/v5/BRfHH1mQbWDP9k1fz5tt9E/jafAq
 cpy17ImtCu4QBCPrZZi4z11ksMNmfHvYxCDWO70DNanVzMP3JHYTG6I6VKz+xHBfbYNlQZzou
 +DpX9dvMnc7HIWu/Kkn0qkGptWleCasPQuA2YCnb1UZzM90Ml8jglnH8fVSJbxTTnXJfURjtz
 dy+Q86nDnukA4NGba7Z39CBI7RkO4htQzgH3jGXqJ9Aet+64yTiZiGSpAGJuuYaH7/Xo3jAXG
 XaIOCWrSmiOCIQTTgT+81GEFZFYHv+oeVctVQe3lOPmMq3yimRAuLzEPTEEHvw14bH1+FhG9N
 Knhi6MlNAYXqj+psl0Gsxx9m93TTU+iMTB5mQyV8WQ4m3zPWWAFpkizdohOS9cdc5gNhcADaN
 12BJL8vw2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Heiko,

thanks for your reply on my issue. 

Here are the following outputs you asked for:

git version
git version 2.7.4 (Apple Git-66)

hostname -f
0x6A6E73

whoami
jns

I have tried the Homebrew version of git, but no change in case of the issue.

I just customized my system with the Mathias Bynens dotfiles (https://github.com/mathiasbynens/dotfiles) as well as with drduhs OS X Security Guide (https://github.com/drduh/OS-X-Security-and-Privacy-Guide). Because I reinstall my Mac on a regularly basis, wherefore I can say that one year ago these tweaks have not caused any issue.

Thanks a lot. I really appreciate your help.

Cheers,
Jonas

> Gesendet: Dienstag, 20. September 2016 um 13:02 Uhr
> Von: "Heiko Voigt" <hvoigt@hvoigt.net>
> An: "Jonas Thiel" <jonas.lierschied@gmx.de>
> Cc: git@vger.kernel.org
> Betreff: Re: Homebrew and Git
>
> Hi,
> 
> On Sun, Sep 18, 2016 at 05:50:28PM +0200, Jonas Thiel wrote:
> > A while ago I have described my problem with Homebrew at the following
> > GitHub channel
> > (https://github.com/Homebrew/homebrew-core/issues/2970). In the
> > meanwhile, I believe that I my problem with Homebrew is based on an
> > issues with my Git. I have found the attached Git Crash reports on my
> > Mac and because I am not familiar with reading/analysing Crash
> > Reports, it would be great if someone could give me some feedback on
> > it.
> >  
> > If you have any question, please do not hesitate to contact me.
> 
> From your crash reports I see that git is apparently crashing in a
> strchr() call from within ident_default_email() which is a function that
> tries to assemble a name and email to put into your commits.
> 
> Can you post us the output of
> 
> 	hostname -f
> 
> and
> 
> 	whoami
> 
> ?
> 
> Since it seems you are using an Apple git can you also give us the
> output of
> 
> 	git version
> 
> Since it seems that Apple is compiling its own git (and not publishing
> the changes they made conveniently via git). Have you tried
> installing a vanilla git via homebrew and seeing whether that also
> produces the issue?
> 
> In your bugreport you are talking about modifications you do to your
> system after which the issue occurred. I would suggest to exactly find
> out which step lead to git crashing (if it actually is the issue). First
> to identify an issue we need something that is reproduceable.
> 
> Cheers Heiko
> 
