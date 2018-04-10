Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96F21F42D
	for <e@80x24.org>; Tue, 10 Apr 2018 22:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932807AbeDJWl6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 18:41:58 -0400
Received: from mout.gmx.net ([212.227.15.19]:56513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932131AbeDJWl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 18:41:57 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lhwgc-1ekfYo3qzq-00n6HQ; Wed, 11
 Apr 2018 00:41:53 +0200
Date:   Wed, 11 Apr 2018 00:41:37 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: git-gui branches, was Re: What's cooking in git.git (Apr 2018,
 #01; Mon, 9)
In-Reply-To: <xmqqtvsi214p.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804110040240.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1804102301200.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqtvsi214p.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NbMKUiHEioRZoZ0lT3AvivXFfiuX3YRV7/BVk0W7VGDzJ7aIOk+
 rWE257QlhCSDvtvlV0nq4DxqQyad0uJAxICihlk59RX5EJYvy8nHo3JAz4/mrstG9FIuEX0
 jnmkWVcTka7dyLNp4JK6tVR3KI7jnAwGY5zNlK1QmdWLuuIqprP7EDsrUvVELPOcVEcRSx+
 KrzdInofXbl+oXpERfyZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FsPct6NC1ZU=:58np8C58cKzWc8raok6vvf
 XpIbYWpbw4Ec7bMv/oTTOyCjMvJZXQtlYgi41aG9f2ilHxSp3G2PPfEB4z85ABlsn+0YTVD9D
 ADHtGQT/rYw1U+MUQGrO/N/HeAY/O40okVg39+EX0qHVY6vvgZOhOGOJTRy5Ee++So2bLPknq
 DiCtI1AF4GT+zNg+8UercPtwUBJXTKSJeJVuSAVim9RbfnAAAxrXUH1P3wVUdxIFQZLdxAcFg
 kWJQhqsBCSvanfh3OP000fMP6e5Ty5jF9NUd1u13Sw+F878WpzH8dxjTglWtVgQFSfY6iFQsM
 0NGp8Vz9ubluHiEUtoYsk1zYFA9BbbYCE/NusQobQBVEeKEMBTeUOm8e+0DvUWx+/MtJEG5KN
 fqumj9fxSaPQAicyGQEKe6HTD97E+5jU4fiS0WrTCx3B3wKzh/YhoSrCDAdR6S88vjrqb5Ksw
 nxnvQwmjvwZckwRJHYDaD0l/hGHjoqOWMN3RbzcuKLcQ7/MLe1pNzG6XVj48Z5RAa+3M/c+DX
 o950xykWLf44D8mJXMJnfGIiaNydt6M/K+rcXnV8DGzylWP9KFujqUtsnTwLOnXtHEo+zLQ8a
 lP+CYso9l9ExKRMLMqRvT2ONyOQGaEzHD+u0brd2UBnmEzUmUzEXN1wN2OdgaEJ1xLst82xzz
 PghCoJ2B2UslLdgoB2521OzuuJNW0biPZrJaJi0u8i8OgbMftpuWIKnrGgh60pfjll/yGV63x
 Z6HGujWSkyrmBozUZScZ4L7ZhXuUIsalKcCt5eP3KyaJ1BhF4tk3dcSMVR9liFW+fMwRChwyY
 CMSxoEx9fO4CkBMtMfWUA2fEOCjmnqzDIJVcybZs0T3AAyrws4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 11 Apr 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 9 Apr 2018, Junio C Hamano wrote:
> >
> >> * bb/git-gui-ssh-key-files (2018-03-02) 2 commits
> >> * bp/git-gui-bind-kp-enter (2018-03-02) 2 commits
> >> * cb/git-gui-ttk-style (2018-03-05) 2 commits
> >
> > What is your plan with those? I thought they were on track for v2.17.0,
> > but now I see that they are not even in `next`...
> 
> There is no plan. I was waiting for somebody to raise noises, get
> irritated by lack of active subsystem maintainer(s), which would
> eventually lead us to find a replacement for Pat.
> 
> I can play patch-monkey for git-gui part but I do not want to be the
> one who judges if proposed changes to it are good ones.  Have they
> been reviewed by git-gui competent people?

I would call myself "reasonably literate" in Tcl/Tk, not "git-gui
competent", but for what it is worth: I remember having reviewed those
patches and AFAIR they looked fine enough for inclusion. Certainly the
ssk-key-files one.

Ciao,
Dscho
