Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A0C11F609
	for <e@80x24.org>; Wed, 28 Nov 2018 09:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeK1Ugl (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 15:36:41 -0500
Received: from mout.gmx.net ([212.227.15.15]:60963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbeK1Ugl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 15:36:41 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lhwt0-1ff7Ad15RS-00n80l; Wed, 28
 Nov 2018 10:35:33 +0100
Date:   Wed, 28 Nov 2018 10:35:33 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Houder <houder@xs4all.nl>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo'
 is working (again)
In-Reply-To: <327181b03df8abfd7194389c9bc21256@xs4all.nl>
Message-ID: <nycvar.QRO.7.76.6.1811281033560.41@tvgsbejvaqbjf.bet>
References: <xmqq1s75u9im.fsf@gitster-ct.c.googlers.com> <1543384528-4498-1-git-send-email-houder@xs4all.nl> <nycvar.QRO.7.76.6.1811280944520.41@tvgsbejvaqbjf.bet> <327181b03df8abfd7194389c9bc21256@xs4all.nl>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oRA7xaZDeP4I8RTvgFHEhe1flmdxtQElXy/P5ybHuteng6xAKZL
 6QaWHuMlu0p4oS2ulnHfQOmo0KFqtxZqRwkbsTE/ENXhuJB18MnjZuuDZwpyPJN1YsQ1dgV
 qqAWBkv9hd1Qw4SjL1y6px1G3Tkda8GNFTnHmA8HcNGBcz34EiH5BjFm3GHx3DGKCrUGj8X
 nM0i1gVhPjTh6f/riJ3WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bIPOFoPWsI8=:pe/fSd236tsBI/qK5YffUM
 T4wLHqlo4FR/X3UQjjHat0xrGxqEDPCvso+20084fFqW/PhaHpDeNlNSB63mHSaeI5ZXb0y/q
 WqGIcHhYfjdA4XqmzplOytIncT88V5Yom0jGGcQtpeXnhsdXam+Qx5v5LB6g/Nr1eDBNWbiAR
 NV5oaPM2dYJ3hzx7t+7WQ+MLpy7ef+s4/FTeS3bA+gdyqx6ciTuXEoQlT63pC/3F+a+61edkM
 PtUknX/PLXR3tTFaf2sj9pwum+4gRj+fd6cGm26xjUFE1cA+6YLoMRmuuN0sukGXgZLwPp4n/
 gufCvP2OwsxIHhjjBRyANxySbl6Uu6qjZL0kM45+OH6V/N5xuty9u48LQnFIpw/7t6lE8oNsy
 n/AspRjxI48HNv3RjsgKSPaQWjTuG58LZ9YJog3BVtarECl1bQCvHcRYd0f8ZAOkDcKEG6n8Y
 HIKkTIpiu4cUzdEoJzMxsgyiFds2lDw34wx1C7UalGz4XyXYwRxnHAnpj8hN4D1mUYh5K1lQU
 wsvzgE5LxAVH6f05tJtLm+EQGldlmUt03eoSEo6DFtwEiSEDjzEOI8k8f54FwiJY7huc0B45k
 kbKBf6VQa4WB1dAB6PdIDvQFL28X/454x4PkxFDjqSq5ceUTfyYG98Ltwzw4d0/zDobJjugx6
 nAQ+04x2ynlJiGlefxRaQeQmGGJ+75dcKWb3T5sF3YQ3VRS+HYqbgTBBc3pwL5BY6DutJ0q58
 Jb+2ndyGzQHRqO80faQ8+FFM6lVucZqGrWlStBoGVivOhqkjUwuJK34MuNLbxYSO1w9vfmta2
 xIT0dWZO+xdk37LdexonrEbFXebrYp85XxWFKfLVRZHJfnAyJsylvg4AbApTbzKpLKChBY2E1
 THPhNB9JVlAtHPlzAi4VlAHi8lqx8JqgynASwKd+J0OrRBcR10V9dwh3bBhmcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi J.H.

On Wed, 28 Nov 2018, Houder wrote:

> On 2018-11-28 09:46, Johannes Schindelin wrote:
> > 
> > On Wed, 28 Nov 2018, J.H. van de Water wrote:
> > 
> > > > > me@work /cygdrive
> > > > > $ ls
> > > > > c  d
> > > > >
> > > > > So `/cygdrive` *is* a valid directory in Cygwin.
> > > >
> > > > That supports the code that does not special case a path that begins
> > > > with /cygdrive/ and simply treats it as a full path and freely use
> > > > relative path, I guess.  Very good point.
> > > 
> > > Please read
> > > 
> > >     https://cygwin.com/cygwin-ug-net/using.html#cygdrive
> > >     ( The cygdrive path prefix )
> > > 
> > > .... you can access arbitary drives on your system by using the cygdrive
> > > path
> > > prefix. The default value for this prefix is /cygdrive ...
> > > ....
> > > 
> > > The cygdrive prefix is a >>> virtual directory <<< under which all drives
> > > on
> > > a system are subsumed ...
> > > ....
> > > 
> > > The cygdrive prefix may be CHANGED in the fstab file as outlined above
> > > !!!!!
> > > ....
> > > 
> > > To simplify scripting, Cygwin also provides a /proc/cygdrive symlink, ...
> > > 
> > > =====
> > 
> > That's all very interesting, but I fail to see the relevance with regards
> > to the issue at hand, namely whether to special-case `/cygdrive` as a
> > special prefix that cannot be treated as directory in Git.
> > 
> > I still maintain that it should not be special-cased, no matter whether it
> > is a virtual directory or whether it can be renamed to `/jh-likes-cygwin`
> > or whatever.
> 
> Ok. Sorry about the noise.
> 
> From your post I got the impression that you believed that there will always
> be a directory called /cygdrive on Cygwin.

I know it can be different. In MSYS2 it is set to `/` via this line in
`/etc/fstab`:

	none / cygdrive binary,posix=0,noacl,user 0 0

Which is just to say that I am fully aware of the option to rename it.

> My point: it can have a different name.

Indeed.

And whatever name you give it, Cygwin can handle it as if it were a
regular directory. So we *must not* special-case it in Git.

Ciao,
Johannes
