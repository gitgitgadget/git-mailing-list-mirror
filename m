X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 14:50:20 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612121445320.18171@xanadu.home>
References: <863b7l83o9.fsf@blue.stonehenge.com>
 <86y7pd6oz7.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
 <Pine.LNX.4.63.0612121908100.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612121352520.18171@xanadu.home>
 <Pine.LNX.4.63.0612121956470.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612121420580.18171@xanadu.home>
 <Pine.LNX.4.63.0612122031450.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 12 Dec 2006 19:50:50 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.63.0612122031450.2807@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34139>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuDeE-0005VU-0u for gcvg-git@gmane.org; Tue, 12 Dec
 2006 20:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932263AbWLLTu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 14:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWLLTu1
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 14:50:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16991 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932415AbWLLTu0 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 14:50:26 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA600JYCF3W91F0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Tue,
 12 Dec 2006 14:50:20 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Tue, 12 Dec 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 12 Dec 2006, Nicolas Pitre wrote:
> 
> > On Tue, 12 Dec 2006, Johannes Schindelin wrote:
> > 
> > > But it would become a non-problem when the HTTP transport would learn 
> > > to read and interpret the .idx files, basically constructing thin 
> > > packs from parts of the .pack files ("Content-Range:" comes to 
> > > mind)...
> > 
> > Woooh.
> 
> Does that mean "Yes, I'll do it"? ;-)

Absolutely not.  ;-)  I know next to nothing about HTTP to start with.
It just looks like a crazy idea that might actually work.


