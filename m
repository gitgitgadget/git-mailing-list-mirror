X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 20:32:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612122031450.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <863b7l83o9.fsf@blue.stonehenge.com> <86y7pd6oz7.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
 <Pine.LNX.4.63.0612121908100.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612121352520.18171@xanadu.home>
 <Pine.LNX.4.63.0612121956470.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612121420580.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 19:32:58 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0612121420580.18171@xanadu.home>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34135>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuDN1-0002kT-0s for gcvg-git@gmane.org; Tue, 12 Dec
 2006 20:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932401AbWLLTcp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 14:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWLLTcp
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 14:32:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:58655 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932401AbWLLTcn
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 14:32:43 -0500
Received: (qmail invoked by alias); 12 Dec 2006 19:32:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp048) with SMTP; 12 Dec 2006 20:32:41 +0100
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Nicolas Pitre wrote:

> On Tue, 12 Dec 2006, Johannes Schindelin wrote:
> 
> > But it would become a non-problem when the HTTP transport would learn 
> > to read and interpret the .idx files, basically constructing thin 
> > packs from parts of the .pack files ("Content-Range:" comes to 
> > mind)...
> 
> Woooh.

Does that mean "Yes, I'll do it"? ;-)

Ciao,
Dscho
