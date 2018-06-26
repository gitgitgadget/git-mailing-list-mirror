Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 377A81F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeFZVok (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:44:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:34037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbeFZVoj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:44:39 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mhej1-1fku2w1jdr-00MxP9; Tue, 26
 Jun 2018 23:44:37 +0200
Date:   Tue, 26 Jun 2018 23:44:36 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     dana <dana@dana.is>
cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>
Subject: Re: [PATCH] rebase -i: Fix white space in comments
In-Reply-To: <nycvar.QRO.7.76.6.1806262331340.21419@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1806262343410.21419@tvgsbejvaqbjf.bet>
References: <614F0C12-7173-48BD-9212-71AD6FBBDAA7@dana.is> <nycvar.QRO.7.76.6.1806262329390.21419@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1806262331340.21419@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:upEBqG9F4lIX6Gx3uItqsTt0DVFKimmWTCz8pCpaqttwnqdD1/V
 grdt8uncDJSk4Y7twb14OenhWT49grbyaKULZrxcUUE5JtpMagP94tciTbjMKbARcAZj3ZO
 f8LDi9h3xsLCaICWwscrLtudhKjWGIKlu5GVa3c/ExfxNrYFy/AP7nh7JhtmYnF/JWVXwDF
 ssbfU3brG3g5pUZmfx3QA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m/I+fDWf7K8=:lbcz87yasp6JELll/892AA
 wK0jNEawVtbP1WbnSBw/Qnn9imgbwchDX+rKBcpnoi7T6guBfrwCd4e8mHqZ9fIoUw2ld05Kc
 pA2r4PIquMibX1YyN58tFpAtoGGIfCqlpzsEobc3RBUnct+kjdin6fcQqdrbTc+vne0cVKiko
 AdFa+/Pp4gQHJhFrKb4feD/OJQlC+AaENL48f0tpku3w7QDiBy6r5g6f14jKSrkZfaxfKJ+BI
 l05oqMvN+w0yZJgUFnlpYp2Y48d1b3Qxpkr4n03iK8tRFSMlyiCMqiTuYYj5iVEbhiLU0qo11
 2Q7vIKVdI/YjV4u+WlLoN5OJuQhctNxrWXzY+jLJ/B95rI4GlWKlGWf6T50mzjTd7zv0wvP4A
 XNYRfx4thNmB37u5QyX5Dio8SxuCxY9Op5+GBKJhI+SHl0qI4Y/6CMq8pyHQTX13NzlsKDJtl
 eK6f0wGVeIS0+hwCkPGr5lCnIYVzfpHc6si8//ecGkSUjmufR716jxkzW//mzMrSMBt6TJN6M
 yX9PCZuYSejGTXzmXafoW/+zToMNBJqK6T0DDdOOxox2o8QpmWLhIcBo2ly2jlpQFSGd0vobS
 WCnoi7PIqRYyVOyAvCz045Wc33D/LHegV9tdsgrZUlZTG7UV+WW+u3KSUInThvZ+JlGSH/sFD
 aczUxe60K1rca5dyukTqW7QQgm+HQmQGHCl6EfKHuzzdr9JnHncNOIYIFKsxpZktk3f8ofzdD
 Flfla+tVNz4NmWspttzDzOPnsoWdbdvPKYuDFWoyu+H0xclDGhMBdta1H7KO3OQ7Bs3rW9c9u
 tM/HYMk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, me again,

On Tue, 26 Jun 2018, Johannes Schindelin wrote:

> On Tue, 26 Jun 2018, Johannes Schindelin wrote:
> 
> > On Tue, 26 Jun 2018, dana wrote:
> > 
> > > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > > index 299ded213..a31af6d4c 100644
> > > --- a/git-rebase--interactive.sh
> > > +++ b/git-rebase--interactive.sh
> > > @@ -222,9 +222,9 @@ $comment_char $(eval_ngettext \
> > >  EOF
> > >  	append_todo_help
> > >  	gettext "
> > > -	However, if you remove everything, the rebase will be aborted.
> > > +However, if you remove everything, the rebase will be aborted.
> > >  
> > > -	" | git stripspace --comment-lines >>"$todo"
> > > +" | git stripspace --comment-lines >>"$todo"
> > >  
> > >  	if test -z "$keep_empty"
> > >  	then
> 
> This does the job, and I am fine with this way of doing things, and there
> seems to be a lot of precedent doing it this way e.g. in git-bisect.sh.

There is of course one other way to fix this, and that is by rewriting
this in C.

Which Alban has done here ;-)

http://public-inbox.org/git/20180626161643.31152-3-alban.gruin@gmail.com

Ciao,
Johannes
