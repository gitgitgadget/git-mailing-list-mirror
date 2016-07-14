Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A57C20195
	for <e@80x24.org>; Thu, 14 Jul 2016 07:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbcGNHp3 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 03:45:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:65330 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbcGNHp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 03:45:27 -0400
Received: from virtualbox ([89.204.154.227]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Meduu-1blkzS0sAK-00OGgi; Thu, 14 Jul 2016 09:45:14
 +0200
Date:	Thu, 14 Jul 2016 09:45:12 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <xmqq8tx51hmx.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607140913470.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607120927410.6426@virtualbox> <20160712073912.GA26431@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607121257450.6426@virtualbox> <xmqqbn2267zq.fsf@gitster.mtv.corp.google.com> <20160713020132.GA13918@sigill.intra.peff.net> <xmqqh9bt34n1.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607132048370.6426@virtualbox>
 <xmqq8tx51hmx.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DN8hjNux3a9AEPnB/VmA7eRFqjEpErg8Tulibh55sH4dN9O+eUj
 JvxruiE8pS2AZcBn8Ocu/uRnIiA7M5b54nWYnOXKakGsAb7TJeEBMWfgUgA8Do0mQHoo4xk
 TBelqngbFuymLXOq93u/x9UsAu6fnekyAvLtMxcDkOnUSoLzPAnAEr4mhy6bnIjm8QscGCY
 nkHxX1G5fCB+66t9Q0tRg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:BH+zWnIXytk=:Ufq0zaLX57+meACLJGlfh5
 R3DWsEUPdun9Kcv08KwTDqMGaZ9sDE6yYuJx6g/noEbhrQ3r94MyhOa8NHnJ47IXGCCuKhSiO
 NzyhkHFl4QkTXM0gINnk/s3CiiiMsVVeZASfMB1FsOuFioS0A9bzk6HECGU6XeivRyC/aYf6V
 ey+fOGpIKzYGi2NkfOzmzLDrf+7dGCerQO+dFlYDrPcx5zbcTKmzqdxr8/P1cimJ5BfW8nQBr
 7MoQC7KEbO9dKWmYEtM/HqaN1kHlK8zxRDgNaF2IywqkGk9QSIs83tCuv2RPZa+Jae3H4bQWg
 7Se+smZRkIlTqGPS470tWSzBNF8moA+q791XtQ3LSWI91DsDkjIPIzdpzz1zOZZfDPBlYB/GT
 iyb1o4IH7Ya6t5OuOp7ZAu+vQhsOyTJwu3O90Y5vqMoxCYBuHs5Edw/vAXiX8/m3rPtcjjglA
 exYabxWtJq2DS+nXb1296qbwJj64zdL7LcG6oPRGSJNew0+x9dfgyZLJoU9nF6yT1EOHTL7cI
 QTxXtCIfLQccVIBnNPlFaiP7JRrt2I/r4DPBy8xJ4FhMSVwxL2SrnH3sjByLxvo8ex0XsbmoX
 F+//CSrLt9Ujg7UG446xwYXu084I9MWOdXwu5ORIdwdgwj3gvW5iQmsFbdLBiGxsMUZj0L5i5
 SXHcswDVVRxrRIQFyjl+gaUvK6uA/wofR3sxqDdHpjZ18AUBy5ChpjTgLcq9Ke2hvbmbAJ0sm
 vHMWZJjkFbbigq1PVZfEBd1nHlMvLvBpZ8jWni4i4AypKSlPbok/QSZphYHhhtUP70xT6JC0Y
 CaBkpu9
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 13 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > How about this one instead (which is part of the time_t-may-be-int64
> > branch on https://github.com/dscho/git which I still have to complete, as
> > some unsigned longs still slipped out of my previous net)? It strikes me
> > as much more robust:
> 
> Hmm, sorry, I do not see much upside here (iow, the 2038 test you
> came up with is as robust).

Unless you, or Peff, performed a thorough analysis whether the dates are
always cut off at 2038 holds true, I am highly doubtful that the previous
tes is robust at all. I certainly only tested on Windows and never
investigated how that 2038 came about. For what I know, it might be a
platform-dependent behavior of strtoul().

> When the internal time representation is updated from "unsigned long" to
> a signed and wider type [*1*], test-date has to stop reading the
> second-from-epoch input with strtol(),

It's strtoul(), actually.

> whose property that overflow will always result in LONG_MAX gives the
> robustness of the 2038 test, and needs to be updated.

So I got curious and looked at the man page. It says indeed that strtoul()
returns ULONG_MAX, which happens to translate into a date in the year
2038. It seems that this behavior is standardized:

	http://pubs.opengroup.org/onlinepubs/007908775/xsh/strtoul.html

although it does not say that ANSI C requires that behavior.

I also could not fail to notice that negative values will be parsed and
simply negated, and that return values 0 and ULONG_MAX *can* denote errors
(in which case errno is set, otherwise it is *not* set). Two rather
surprising facts, at least surprising to me, and facts that our code does
not deal with.

Please also note that ULONG_MAX is not required to be either 2^32-1 or
2^64-1. Which means that the 2038 test is really not robust.

> With this "is64bit" patch, you explicitly measure "unsigned long",
> knowing that our internal time representation currently is that type,
> and that would need to be updated when widening happens.  So both need
> to be updated anyway in the future.

Yes, I already update that in my topic branch.

Please note, however, that it is much more natural to update yet another
instance of "unsigned long" to "time_t" than having to explain how that
2038 test is affected.

Also note that the 640bit test is very explicit, and hence robust. As a
consequence it would skip the absurd dates on systems switching to
int128_t for time_t.

> The prerequisite name 64BITTIME that lost an underscore is harder to
> read, so there is a slight downside.

It is not a downside. It is something easily fixed.

> Moving of lazy_prereq to test-lib might be an upside if we were
> planning to add a test that depends on the system having or not
> having 64-bit timestamp elsewhere, but I do not think of a reason
> why such a new test cannot go to t0006-date, which has the perfect
> name for such a test and is not overly long right now (114 lines).

Happenstance. And I was merely imitating the patch of Peff thar I found on
gmane.

> So, unless you have a more solid reason to reject the updated t0006
> earlier in the thread, I am not sure what we'd gain by replacing it
> with this version.

My solid reason is that it is utterky unobvious why the magic number 2038
should do the work. You would have to spend quite some time to convince
the average programmer that it is correct.

Contrast that to the 64-bit test.

Ciao,
Dscho
