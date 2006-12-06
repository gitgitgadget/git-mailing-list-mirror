X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvs-migration document: make the need for "push" more
 obvious
Date: Wed, 6 Dec 2006 16:16:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org>
 <45760545.2010801@gmail.com> <20061206.105251.144349770.wl@gnu.org>
 <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <4576D92A.80307@xs4all.nl> <20061206145802.GC1714@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 15:17:07 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, gpermus@gmail.com,
	hanwen@lilypond.org, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061206145802.GC1714@fieldses.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33470>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GryW8-00012C-Pp for gcvg-git@gmane.org; Wed, 06 Dec
 2006 16:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933577AbWLFPRA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 10:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934424AbWLFPRA
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 10:17:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:46465 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S933577AbWLFPQ7
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 10:16:59 -0500
Received: (qmail invoked by alias); 06 Dec 2006 15:16:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp038) with SMTP; 06 Dec 2006 16:16:58 +0100
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, J. Bruce Fields wrote:

> I'd rather leave that introduction as it is--just as a section that 
> advertises the git features without trying to explain much.  And I'd 
> rather not mention push until we have a chance to explain how to use it.

You talk like you'd have an eternity to explain Git. But that is not true. 
A developer, especially those whom Git is forced upon, have an attention 
span shorter than their pub1c hair.

I _know_ that _I_ did not read the whole document about "Branching and 
merging in Git".

Ciao,
Dscho
