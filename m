Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 778BE1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 13:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933280AbeGJNJK (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 09:09:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:57039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754101AbeGJNJI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 09:09:08 -0400
Received: from [192.168.0.129] ([37.201.195.87]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Llmcq-1gBw5Y2AtM-00ZT5H; Tue, 10
 Jul 2018 15:08:56 +0200
Date:   Tue, 10 Jul 2018 15:08:57 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Daniel Harding <dharding@living180.net>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3430: update to test with custom commentChar
In-Reply-To: <aa716d3f-6a80-e3fc-0172-1027fb85c792@living180.net>
Message-ID: <nycvar.QRO.7.76.6.1807101504530.75@tvgsbejvaqbjf.bet>
References: <20180708184110.14792-1-dharding@living180.net> <20180708184110.14792-3-dharding@living180.net> <20180708210200.GA4573@genre.crustytoothpaste.net> <1084a573-4ed5-5a8c-a159-7773f7465704@living180.net> <nycvar.QRO.7.76.6.1807092109440.75@tvgsbejvaqbjf.bet>
 <aa716d3f-6a80-e3fc-0172-1027fb85c792@living180.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2Fx2ZcJ+XxNTbTWkIvgnkRZ8JVyq2pPLbzmSTVYJF1ESMF9ehld
 XqanEOjb3UBn9ogUCxULpm6H5hZJGFbwfUlzmdiCKl+2jN6QBD6I9eqmpVK6A15ns+1Gmz6
 i/p90YUsO7pclKWnkyQtOfGbzKECycnr9w8x2/0vb5SvVjR944qBEKVvTNADoVeLXyRPXqm
 LmrlMI8G4MFbc9/I+D03Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xG6uPqbwSX0=:McOqpAHHtmnBFlsoJlL0B0
 9bQCfPxTjsFy/JV2g2YEoYhQtvhVdXJGPbrvRICMI5rFAElYe1PThj4QdR5e84Gi4HIUijB/T
 B+eVt1PgUCSl9/vd3NWluwHcIBTBjPt38i5WJs5dp2dZFGwUyRDe9Zi6E16GaWAJzusAjEws4
 B7dFZhRHEKk9DJdiU74n+FGKcTsDHGd9/ffsKgjcnk9zHNGi3qDWouMjEwJBspCmD6Ey5Mg7S
 zwcsRXG4P456UEftQEC9/VdH3pIo1jOlvU8nUKvrRKNCuJGw5rCHN+Ikhxzo1BOlkdN3xwC9K
 a7mNs2uTKN4QC3u1EsJ88u+p+Zm8WbZQAbyZsueYObGFfDuvQa+/1yUgeHy9jc8QWSwqWoZse
 MgUY/xqisX4bKQS3Wbg+t7Ej8ZVdo4xhyHY1MQuIO1hXZT5Jy2TL7pmcWY6+HGS22/zV6/E1B
 N5hWJPgP2NL8vj2YzFHH4ePrtJYTQgxSVbfE/RJ7fRynjpMuvNFlMEycRhxP1XF+eiPP7KfTj
 acPhpIr8WLK+kqn2mm4ZMl0rR2Ni+QqcTP5BeK6Lcqu7yQKws6XutZ0WSIKKbWrvN+Q+anB1z
 iI/PJJYqnVX5qf7Ripu8JCreB5W58aou0kOXLpfpSpeivQwXIFWNgowh5qe8KFTphtF5h/CgZ
 NxDc6cq0XyKexgKhKB+scCLvehEvTLyo96cc1JW3eTbYnCSTWyPO4McsLpOaeN8Bn1yv7AiyG
 NvirVBBsyHvbgPjdE27W/lAo/wyPaAgiPbl6KAo18K/aeC0HJFBiscih+NerOFwbhGcmnfJ6y
 yGLXPT0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

On Tue, 10 Jul 2018, Daniel Harding wrote:

> On Mon, 09 Jul 2018 at 22:14:58 +0300, Johannes Schindelin wrote:
> > 
> > On Mon, 9 Jul 2018, Daniel Harding wrote:
> > > 
> > > On Mon, 09 Jul 2018 at 00:02:00 +0300, brian m. carlson wrote:
> > > >
> > > > Should this affect the "# Merge the topic branch" line (and the "# C",
> > > > "# E", and "# H" lines in the next test) that appears below this?  It
> > > > would seem those would qualify as comments as well.
> > >
> > > I intentionally did not change that behavior for two reasons:
> > >
> > > a) from a Git perspective, comment characters are only effectual for
> > > comments
> > > if they are the first character in a line
> > >
> > > and
> > >
> > > b) there are places where a '#' character from the todo list is actually
> > > parsed and used e.g. [0] and [1].  I have not yet gotten to the point of
> > > grokking what is going on there, so I didn't want to risk breaking
> > > something I
> > > didn't understand.  Perhaps Johannes could shed some light on whether the
> > > cases you mentioned should be changed to use the configured commentChar or
> > > not.
> > >
> > > [0]
> > > https://github.com/git/git/blob/53f9a3e157dbbc901a02ac2c73346d375e24978c/sequencer.c#L2869
> > > [1]
> > > https://github.com/git/git/blob/53f9a3e157dbbc901a02ac2c73346d375e24978c/sequencer.c#L3797
> > 
> > These are related. The first one tries to support
> > 
> >  merge -C cafecafe second-branch third-branch # Octopus 2nd/3rd branch
> > 
> > i.e. use '#' to separate between the commit(s) to merge and the oneline
> > (the latter for the reader's pleasure, just like the onelines in the `pick
> > <hash> <oneline>` lines.
> > 
> > The second ensures that there is no valid label `#`.
> > 
> > I have not really thought about the ramifications of changing this to
> > comment_line_char, but I guess it *could* work if both locations were
> > changed.
> 
> Is there interest in such a change?  I'm happy to take a stab at it if there
> is, otherwise I'll leave things as they are.

I think it would be a fine change, once we convinced ourselves that it
does not break things (I am a little worried about this because I remember
just how long I had to reflect about the ramifications with regards to the
label: `#` is a valid ref name, after all, and that was the reason why I
had to treat it specially, and I wonder whether allowing arbitrary comment
chars will require us to add more such special handling that is not
necessary if we stick to `#`).

Not that the comment line char feature seems to be all that safe. I could
imagine that setting it to ' ' (i.e. a single space) wreaks havoc with
Git, and we have no safeguard to error out in this obviously broken case.

Ciao,
Dscho
