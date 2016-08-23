Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A59D91FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 13:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753904AbcHWNyv (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 09:54:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:55241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751214AbcHWNyu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 09:54:50 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MWwp6-1bfRFP2T4O-00Vu5V; Tue, 23 Aug 2016 15:54:03
 +0200
Date:   Tue, 23 Aug 2016 15:54:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [git-for-windows] Re: [ANNOUNCE] Git for Windows 2.9.3
In-Reply-To: <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608231553030.4924@virtualbox>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox> <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608171507530.4924@virtualbox> <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608181022250.4924@virtualbox>
 <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3NabwPT2n/J0FJ+cUyrbfpVMZz9ppypwZiP++hmhdxkUczqbKfp
 ukaECFRKsHgPAgRrVOxEHvrK+ezizHrDo3mMx8q6u9FacKYSySyAAeJaONN1RxPbwGHoM8A
 h/oeYSW7vrTj75FLWjg4C/BwlxVYrHNZjtONvbYZsN3RGcg6LdcNqQQpMR7tpuoeqjd6C07
 q4lj1ep/tfVD9vUIz2lVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ToBS/UdigfE=:hWGQTHKzldKgKW1dHse/uX
 0t0yuC1RmV0TbiuKlgD9lv6srsy0GORJHrcwXRUrVyuf5YbiByruUDVoZB4bFAsZfi8iEFkfV
 0Nz6KQpjEz68Zm8s3wRWzH8oEEfkKKxTM7a0FP85VL2JQItDALMmqG6K1Mdnd0PzMCmSLbxQw
 +rxlJIgLy5hdJssOBH0BcFxZMEzbUZjqWreE4yGPx3ApeQTJV7AtL1xDIIVZAt9i9O/bC3Ous
 mRxSKowIGFWlrKMhfBnM7bvfBOaBLQsyEJg7UqV1t04bnR5P71dBH/IsPvk6X2PgOPf15kDpQ
 k4pKhNER4C1uIew+vSNsOB3Kf3bk36/02BOZ0c9O36MBo/zWhSZy8yLB3EWmECiMijZUEaebg
 QuRNcV6VPBookGfUgzFNIMN0LKd8Hoz4r84hCLRTDIl+t+IvrJ7k9HvTxRxvfOym05/024pjf
 IJx0ZRF5W2IOnhY35/qreklgv2otvPDsQOt9B1/PtQRNY25ySyJZgnlWkR8phWFMzMc3i9YVf
 3BI+cLWNQRiU+29WtLhry+oYZ0f0BMhrfe50oBHrEIkhoAcGnrrOsfqn0AZaT8tx4RwYAJZw8
 nvBHFCaSdVmRgch7kMI40t0jvoncjmwHil7g6BGMe8dwP7i7fkX5v7/qjQUeSz14vPR/r8uoS
 EPzmwDTCg9QRAXktg3PpY+zlQZ7EfSr5yBHECZbumhiZI5oKoUo7zFeGI1KzRRgR/k2ObqYpC
 nCtzbFQy2JJxBDZ7S+akCStKrQcXNQWIGjUy978Cjlg+4zutvc1ylmhF7CsA+7K9MMWfpwnpZ
 ncjl1de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Mon, 22 Aug 2016, Duy Nguyen wrote:

> On Thu, Aug 18, 2016 at 3:37 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Junio,
> >
> > On Wed, 17 Aug 2016, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >> >> And then your "git cat-file" patch can be upstreamed with the option
> >> >> renamed to (or with an additional synonym) "--filters", which would make
> >> >> things consistent.
> >> >
> >> > Right. I would like to ask for a `--smudge` synonym nevertheless, just
> >> > because I already use this. On the other hand, it is early enough to tell
> >> > everybody who knows about this feature to change their invocation (anybody
> >> > who would know about `--smudge` would be in that 1% of users that have
> >> > read the release notes, so most likely would read the next release notes,
> >> > too).
> >>
> >> It is OK if it were your private edition, but you end up hurting
> >> your users if you need to redo the feature differently.
> >
> > Unfortunately, this is the situation of Git for Windows from its
> > beginning: there has not been a single time that Git for Windows could
> > live with unpatched upstream Git's source code.
> >
> > Business as usual, though.
> 
> Bug fixes is one thing, features is completely different.

Oh? Completely?

So the core.hideDotFiles feature should have forced me to rename Git for
Windows to, say, DschoGit on Windows?

Let's just stop here. This is getting too silly.

Ciao,
Dscho
