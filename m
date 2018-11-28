Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34941F609
	for <e@80x24.org>; Wed, 28 Nov 2018 08:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeK1TrU (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 14:47:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:41861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbeK1TrU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 14:47:20 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ln897-1flQWY1SPd-00hK7b; Wed, 28
 Nov 2018 09:46:23 +0100
Date:   Wed, 28 Nov 2018 09:46:23 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "J.H. van de Water" <houder@xs4all.nl>
cc:     gitster@pobox.com, git@vger.kernel.org, incog@xs4all.nl
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo'
 is working (again)
In-Reply-To: <1543384528-4498-1-git-send-email-houder@xs4all.nl>
Message-ID: <nycvar.QRO.7.76.6.1811280944520.41@tvgsbejvaqbjf.bet>
References: <xmqq1s75u9im.fsf@gitster-ct.c.googlers.com> <1543384528-4498-1-git-send-email-houder@xs4all.nl>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NvMvnFsxU9M1BmXGth6UFYMAwU8RCJDFJ3dxRqtSgsyidgdUc3l
 o4XVYmtwwsg8bgwv4YMM3UINtm1fN4ErhJ8WZeXt3gZQwt/xtTKmJEWFnY3Hf0aw6RIWJwL
 UvW+McRiwPTYsz/NSdd6+v0lLx3W/4R162kPlQ3gyc74WvVT67Xs8Lz3CvH8bdJXq/aPRlh
 c7uamSN6IjHgxhf4JAEcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DGsV4CJ7poM=:EHrI2/wYZOCSykPufspnGm
 fzZ6ZYIqON2S3PWFssnfmDxeuQgtxmFkvdp+zu1pT5YDuTjM54AqDAUX+E2wzDVBYKzg68ePU
 /bsirus5Vjk2pCnMlzSzh/D4K9QbxQFeSq9gfLCy1OAZUcer9DHx+K9/74XhcR6SbHUIUAO3p
 eemm2lAFOerCQj0lRRNTyy6sulUh6E6e9tIy2UoQb0isOkGX7zMfoFKEYpJvXTOI3i/1Zdskq
 7VmBn1cdpTGfD1eQSaiHjXUssdEuttC73pC+NjWEr0FP5b0vLO2H4xvzf1FTIVb58F0LWhciN
 V3M5Q/I1MC7DsS0ZrkDSmEJtqWo+UKYyg460LMv1xN1+m+Bkd9vqtRB5g8Nm7Meidk4EaYyHO
 WbWp5cvml11CCV1vy9eODmFQWWFnZ/oC/ogxZ0NIE9Vv/8SUQETCgQWfd7y5H9b9vHhQSGbbb
 293/q1+sB9bZkzEQRAvTI+GHl6jRTSA9jd0Rh2esk7jGBfZz7K1We+hTx2xdiRBjgmDPN2z/v
 XENT7tHdybk7rRhN7/HiZ6oKuFYB39S8v3EE4itaukDWQ536XUqnF8AkTb3xQEZoTZr+jzO7u
 G6QIAkGxY64o4XNGpg/8pgZe/vVU8H6GYSptG3UtI3yl/V9kw3ypNLw24kRSEwRXYxK6XlA9p
 TnWPNDsrUKTRQKr2LQxFUmd7GSkyEhm8XyWYZKYVCdT4murPQwckl8UpVX/2CEloChTgkvkdw
 BFMMFb2MIr9UpYTO6U2Qx46ikU/T5h68LXek0dS45unBQsfLHmdsbNk164Q7OMGZ1fB7WyB5d
 wlZdZ/Ombi2rHqk5yKBsm2FRQoMzWfvo3CiNEhNaseaJOX1coC9GoxqVV7I3qzCrsXc/Cnvh7
 fD32kW9LJ8K/+puGSIc3jsrCc6C6BhnNHeBisblfUhzlekfTRhNSlTZwYs23JX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi J.H.,

On Wed, 28 Nov 2018, J.H. van de Water wrote:

> > > me@work /cygdrive
> > > $ ls
> > > c  d
> > >
> > > So `/cygdrive` *is* a valid directory in Cygwin.
> > 
> > That supports the code that does not special case a path that begins
> > with /cygdrive/ and simply treats it as a full path and freely use
> > relative path, I guess.  Very good point.
> 
> Please read
> 
>     https://cygwin.com/cygwin-ug-net/using.html#cygdrive
>     ( The cygdrive path prefix )
> 
> .... you can access arbitary drives on your system by using the cygdrive path
> prefix. The default value for this prefix is /cygdrive ...
> ....
> 
> The cygdrive prefix is a >>> virtual directory <<< under which all drives on
> a system are subsumed ...
> ....
> 
> The cygdrive prefix may be CHANGED in the fstab file as outlined above !!!!!
> ....
> 
> To simplify scripting, Cygwin also provides a /proc/cygdrive symlink, ...
> 
> =====

That's all very interesting, but I fail to see the relevance with regards
to the issue at hand, namely whether to special-case `/cygdrive` as a
special prefix that cannot be treated as directory in Git.

I still maintain that it should not be special-cased, no matter whether it
is a virtual directory or whether it can be renamed to `/jh-likes-cygwin`
or whatever.

Ciao,
Dscho
