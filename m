Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2C320A17
	for <e@80x24.org>; Thu, 19 Jan 2017 20:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbdASUCH (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 15:02:07 -0500
Received: from mout.gmx.net ([212.227.17.22]:55357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751341AbdASUCG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 15:02:06 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsfrR-1cNetx0cYL-012Gj6; Thu, 19
 Jan 2017 20:54:04 +0100
Date:   Thu, 19 Jan 2017 20:54:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Michael Gooch <goochmi@gmail.com>, git@vger.kernel.org
Subject: Re: problem with insider build for windows and git
In-Reply-To: <xmqq8tq8b4mr.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701192032330.3469@virtualbox>
References: <1bddbd50-86ea-6c38-6ab8-08336de2ba72@gmail.com> <alpine.DEB.2.20.1701131300390.3469@virtualbox> <alpine.DEB.2.20.1701181738490.3469@virtualbox> <xmqq8tq8b4mr.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9wKP/XWpmvD/UzIsuUwYw37XYVEskc/lag4zWKRFoAclES2uaWE
 46xSlZOFvEAU2aVuU0Fo/HS4M88C1WWnG8ad+kxMqPQljABbtUKcdjConkgRKt5Obtpzyr3
 bBkllEysq3iALGUCmVttZrJsmYQY1m0TnniDNft1wTBGfcNjW9ud5BNqJ7n/ZylIQVFBLz+
 mq+F8vFE3ESkOfEu1goZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tJ1I7/blmvU=:i+ipbBmKiIsFnRAmNH5vDv
 f9Jglmj+gT+vVj5/5tZZXrBAqicv/660/2Uj8dBIxEgUxCTK+QBp6UPkM23onOug0Zgikjutz
 dVbpK8Fw8n+I84QqM0nkq27Sy5upVpGFG+7eOhS3JWrDDtwtGP86Kq5hBU5dzXg2o4NULLByQ
 xTrZWzrGW464NcUOt7hySqj+Cjfa3FGPmFJRKFDnWCHTL0HUDdNi5fouUITYv4HoxD2y/nieI
 x0HnsMB6e+ePnEqijIm1RwRzWz1es2CjXeuPeCz9uWM0a/8koaZQjxPtBIyDfbI4y7Wh+vZCf
 W5wOeVBA76im49GUZqHV6xNlJcFqkYSyMrdze7blTzh23cJJIpINwSFQtREwOxI6yV7kH4THd
 KEV3qKPIS8xEfRDBIADFrFweBRVNO+8NkMaNT/rfkFv8iNpb2iCwZQxS20iUg28Uoi5esjyzp
 s9DrJhhzP+Y/NDpeIiCU47wlMTdcMtppU9TwGtlM1T0qjUoUuAQmrx5KCMiIFyb0Aeq+vM10K
 xqxF1VycK+c6nrchKJvgq8CKDUPLIZGMZgtR5znNLUzcW7nFJ++ZmRXI6dPgysSL2s8nguP8H
 BsNN6zyor0hUZcSYQs097+g5LQUVIaV9rajEsoymRWZiKCZdXGMK4aBhDejqUX7ALUFDDH0Ut
 AMq4LiAtaJOOHGxphIEIy4Zg+dg1jgF3UVOLNbIqwe77mrIipt14C7b7GC2BAODk6Wm0nZAru
 Gm+XS23fij1BeIJ0dbu4vBkx7SErwS9PilowVc5MbkkHNUhz0yydBPlufw3D0b/J8DTjKT+pI
 Uut6F077utk/B+JrnINr8z/7ei0OzelsuI0xp4ElE5L+YHANiPGBBzbPDlVrXxdDUf2H/xBOA
 bsLWNFHVCnRsVaJgzjHsBv48W8I3V1jOnNvQj4pJbxk8+T3UvO4P6+oepY53RxGIRYkRLEUn/
 JvTqrHbPptWAdWXWpowkwHLmBBYrfKdkN3vh2T4e3Z/+CB0mt0Vvs1QGar3oXo4n0C+zP9p+9
 9sQqVm1uLszA5ELv1o4vWnG6s4uSfBGpOTzwu2vpoytr4bnGwGe639ML7v/7ghxc1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 18 Jan 2017, Junio C Hamano wrote:

> Aside from the "ouch, one topic has merged earlier iteration, that
> was merged to 'master', also now merged to 'maint', and we need to
> follow up on both" you sent out earlier,

I know of one more "ouch" moment where my latest iterations did not get
picked up: my latest version of the "Avoid a segmentation fault with
renaming merges" patch did not output an error message in case of !nce
because the code flow will result in more appropriate error messages later
anyway. I did not provide a follow-up patch for that because the current
version in `maint` is not wrong per se.

> are there any other topic that are already in 'master' that should go to
> 2.11.x track?

Personally, I would have merged 'nd/config-misc-fixes' into `maint`, I
guess, and 'jc/abbrev-autoscale-config', and probably also 'jc/latin-1'.
The 'rj/git-version-gen-do-not-force-abbrev' topic would be another
candidate for inclusion. The 'ah/grammos' strikes me as obvious `maint`
material, as well as 'ew/svn-fixes'. I have no opinion on the p4 topics
(five, by my counting), as I have no experience with (or for that matter,
need for) Perforce, but Lars might have a strong opinion on those.

Having said that, these are the topics that *I* would merge into `maint`
if I maintained Git. I don't, so this is just my opinion, man [*1*].

Ciao,
Johannes

Footnote *1*: While you read that last part of the sentence, imagine me in
slippers and a bathrobe, with a White Russian in my left hand for which I
used milk instead of cream (for the White Russian, that is, not for my
left hand).
