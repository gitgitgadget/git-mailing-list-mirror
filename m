Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB7D81F424
	for <e@80x24.org>; Fri, 20 Apr 2018 08:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeDTIex (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 04:34:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:52195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753957AbeDTIew (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 04:34:52 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lz0aC-1eMxc30KuG-014ADy; Fri, 20
 Apr 2018 10:34:43 +0200
Date:   Fri, 20 Apr 2018 10:34:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v7 07/17] # This is a combination of 2 commits. # This
 is the 1st commit message:
In-Reply-To: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804201027010.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1523362469.git.johannes.schindelin@gmx.de> <cover.1524139900.git.johannes.schindelin@gmx.de> <f3d13a304aa8586dd49a19947f09c00966590340.1524139900.git.johannes.schindelin@gmx.de>
 <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PvWZGeA0OzwimMbfo+xfANz6TqNDQ6gT2pmNF7V6ATecUHKN0Wh
 rSIupYiZHIQtvxTbVH/OoWEHJ3fbHOV3HPlSx/bLYc98dAQ0nI2fp5uscKwFW71JvDpJK68
 Q0g7QzYjlVdaf58eeMq0WDhhEmBFfCSrd2NlQqsdRPr1KkHSTYVeEtgAu1zL7nYfNBbI9hf
 AcNTSPxk4I5nCdoidDzIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/XCYhSFbpss=:d3RINvliYhXhwe8bkkthBs
 McpZhrrsF6hVzjC+iQOa3f6uE8kJ6w+iRJ3kBmZ0m4+y0LiWne02gTu9mP8ibCZwRjemQI8OO
 VTXVUeix1AhZ8EhB68QNp+aADOqgj7sCBWHDQ14DtWJDtQ7FPIr+nJRz9H+R7H+47C8YffopH
 HOrqBaxTvQkSqjN9qa9G87zKHmHWGrv3w/kjSaK0NLq3IzVO84W9LkluGsETpPXc6re3Z31nU
 LV7HKHZyd+YU+w+oDMm4DTY1xd46d7q80RPmVT8ZIYiEk4TdJkZh3uItVTo1kzsYo79+GuASY
 ChdJcLXOBswCvzp7gvKnPz166u2M6u6K1kiDpNO3ofbwECRj4FLj6zulT+kHKP1T0EMpl95BH
 JqKbQ12W7Z+a6mGyzBptF4a3V5+TjrXoiu5GSjSFNKQOGClFGHl4Ut53ZryP6l+JxX3JGOWom
 VkF4NTLsqyH7UdORzsH2U8donfFAN0eNoiYcjygCpApowDr1H0Fogyo6g4kvM/VNIa2UVczNN
 QHza6Z5AMzuzyK19rqP2I1PUKiTpwdBrWBua0QTZaTT3FG3vzwSebwxw8Zo8HGLVdE0ixC5G1
 3eNyA9Wy7k4Xvn9/dDbuLUyeRu2CU5+q6uQsOtVrVgtd3LAGTGyKwS2n0+ob2pOld7uZUTaSQ
 bB10jfYeMV8SpJgMlwWz3RcZlAePKxJBxjoKv0zGSv+Nmq5OiTNyeAiFtCIZb0yPnXwVUgQ4X
 PYzdVIdspcGA1d6osH67p401P4a4piCPbAGdVMrQl8kZseXUk48GUfOuCmpowJ3x1BbFRwqrK
 ajy70bmKgon9PnnIDvDXSgz0+oQnrgRaEGQmgws6UEUlxhFC6E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 20 Apr 2018, Eric Sunshine wrote:

> On Thu, Apr 19, 2018 at 8:20 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > # This is a combination of 2 commits. # This is the 1st commit message:
> 
> Botched squash/fixup?

Sure was!

> > sequencer: introduce the `merge` command
> >
> > This patch is part of the effort to reimplement `--preserve-merges` with
> > a substantially improved design, a design that has been developed in the
> > Git for Windows project to maintain the dozens of Windows-specific patch
> > series on top of upstream Git.
> > [...]
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > # The commit message #2 will be skipped:
> >
> > # fixup! sequencer: introduce the `merge` command
> 
> Bloop.

Obviously, this was not processed properly (I certainly did not have this
in my editor, otherwise it would have been stripped). This is not the
first time this happened. I think there is a bug in sequencer.c (i.e. in
my partial reimplementation of git-rebase--interactive in C), but I do not
have time right now to investigate further... Will try to find some time
soon.

Or maybe I'll just install a post-rewrite hook that notifies me of this
problem so that I can investigate right when it happened...

Oh scratch that. Now I am too annoyed with what I perceive a bug in *my*
code. I'll hunt it down.

Thanks,
Dscho
