Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4917C1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbcHWQgC (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:36:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:60408 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753295AbcHWQgA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:36:00 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LhOO8-1apuyD1ZLM-00mdYf; Tue, 23 Aug 2016 18:05:33
 +0200
Date:   Tue, 23 Aug 2016 18:05:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael J Gruber <git@drmicha.warpmail.net>
cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [git-for-windows] Re: [ANNOUNCE] Git for Windows 2.9.3
In-Reply-To: <alpine.DEB.2.20.1608231736180.4924@virtualbox>
Message-ID: <alpine.DEB.2.20.1608231758260.4924@virtualbox>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox> <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608171507530.4924@virtualbox> <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608181022250.4924@virtualbox>
 <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com> <alpine.DEB.2.20.1608231553030.4924@virtualbox> <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net> <alpine.DEB.2.20.1608231736180.4924@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LQeYRxlq0pxkPCRoVD0kmTcWevlUAOpNUe9u3rNhzx+GhPaueAF
 Y12kZGBSblz1h84OKnNY9AzOK96Wk694sh+hOWTt85E2wu+4M2p4e84eJrH/e+odkHuqwPf
 Q94TM9kJnoxMC9GnIYvlkbhTmrijPJ8WC2L0jLyFSsxiDKQV+IZEsAIqa9xnOZets5VqUQM
 boIY2wbPsFfpQXxQY2sow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EoCeZ78BFFA=:di4iDzpVE1WRq7HnUwhjDP
 vTpf1F6NnRRg/PIZigNTIFtDxszTe3leG1HSb6X+7L9xvZXOzkeaJn7GYwNjjkY3ZTiSe6lnI
 FxE8x998Zpyt3JBqpnituUqu0XrQhzFY3mooO4+oxLwPqM8BZreWTrNA+5Yw6EoXBDyu8mvtf
 Va5k77s4hvicMxY0+wU2px/KBvVcPr1wTwxtTf95JC8dBHoPU0g1bXorD/nz6NAInawjjQfaI
 n6HliT0JrZPMWWN5GHB6AzbFr8reFUAFVmYqsT4dp/32oiQ7FRNUHcmTPXQSpwqeQrO6UWG6y
 TtTz11QDZrB+AnOF1aMuXoLcSi+3HjDQxt1IpZ7qlV075Nj5y1OEx3+ruMDvkAZDJEjgLCHJP
 lxtotEg3wlE0M9ASDW6txzx6w60RFgctZfgLvxi/mnAFRxVEHiCZ0Zrw1tmMQjgYUIHmklcvv
 lXA3bFF5UZ/3gC3MXrZrhpFVdCD3iRdd04zvpUyDBOL2tSpwS8e+OP283VfhIXp9ghIy5z7Gr
 pOTcjbGTHyyrMeE5nKQjy8qSwv5EcpSsqqhuAPcwoTWT5fnaTv0prYkWxrE2rsQ4HtOb0APiX
 yhja1jzutmCbmt0UY1DYL2N3ZGYrQpvW+d0kFn8vhO1qQj7gd8TJn9sU6q8rDlwhSu/EPTbVz
 CtEkdeaXaMQIOwQY6UWbIYDW8G9QDeL06iFzaR/CsaQjkDB81C/bY7JzGhJ/vsChEroxZQJRg
 r5hagm4LVj2NJNBw38LvAjSxlNuS6WvdEPIbtI4XpHqlJFEQomUaMzGVFAGLMp5OioOaBPtqy
 +/SSoaM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Tue, 23 Aug 2016, Johannes Schindelin wrote:

> On Tue, 23 Aug 2016, Michael J Gruber wrote:
> 
> > Maybe you want to re-read what you wrote to trigger his response, and
> > consider adjusting your attitude ("I want this now so I'll release it in
> > Git4Win") rather than the downstream name.
> 
> I am working *very* hard on improving the user experience of Git for
> Windows. And yes, sometimes I have to include something in Git for Windows
> versions that upstream Git does not include in the corresponding version
> number.
> 
> I am really at a loss why you see fit to attack me about that.

In case it is not crystal-clear, let me clarify one very important point.
It seems that some people mistake the work I do for something I do on a
whim. This is not so.

The patch series that triggered this entire unfortunate discussion
introduced the --smudge option, which I have subsequently renamed to
--filters and submitted as a patch series to the Git project.

So it is an altogether unfair misrepresentation to state that I introduce
features that deviate so much from upstream Git as to require a new name.

The feature in question is also highly unlikely to be used as much by
non-Windows users as by Windows users due to the unfortunate choice of the
default setting for core.autocrlf. Basically, Windows users have to use
those --filters all the time, and in many cases, git cat-file --batch
without --filters is simply useless. This is nothing, say, Linux users
would care about, of course, but Windows folks like me care a great deal
about it.

It is this need that literally guarantees that I will get more useful
feedback from Windows users about this feature (and in this context I mean
application developers) than from Linux or MacOSX users. And as a matter
of fact, I got exactly that: great feedback. This feedback resulted in the
addition of the --path option, and of the work I did on making --filters
compatible with the --batch mode.

So I take great exception at this criticism. I think these comments were
not really thought through, and I also would consider this discussion in
and of itself ("is Git for Windows really Git? Should it not be renamed,
despite Dscho's best efforts to get them in sync?") to be much more
harmful than any feature I introduced into Git for Windows before trying
to get it integrated into upstream Git.

Thank you very much for your attention,
Dscho
