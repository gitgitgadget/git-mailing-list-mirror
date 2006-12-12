X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 18:40:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612121839200.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <863b7l83o9.fsf@blue.stonehenge.com> <86y7pd6oz7.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 17:40:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <86y7pd6oz7.fsf@blue.stonehenge.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34113>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuBc2-00017r-JR for gcvg-git@gmane.org; Tue, 12 Dec
 2006 18:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932295AbWLLRkO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 12:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWLLRkN
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 12:40:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:55153 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751312AbWLLRkL
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 12:40:11 -0500
Received: (qmail invoked by alias); 12 Dec 2006 17:40:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp034) with SMTP; 12 Dec 2006 18:40:09 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Randal L. Schwartz wrote:

> >>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:
> 
> Randal> I just got this on this morning's git-fetch:
> 
> Randal>     error: no such remote ref refs/heads/pu
> Randal>     error: no such remote ref refs/heads/next
> Randal>     Fetch failure: git://git.kernel.org/pub/scm/git/git.git

Congratulations!

You are experiencing the Thundering Herd Phenomenon we talked a lot about 
lately (the kernel.org mirroring thread).

Ciao,
Dscho
