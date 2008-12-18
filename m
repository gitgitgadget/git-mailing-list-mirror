From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-edit-index.perl
Date: Thu, 18 Dec 2008 17:24:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812181723340.6952@intel-tinevez-2-302>
References: <20081217204749.GA18261@janet.wally> <20081218043734.GD20749@coredump.intra.peff.net> <alpine.DEB.1.00.0812181446430.6952@intel-tinevez-2-302> <20081218140411.GB6706@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Neil Roberts <bpeeluk@yahoo.co.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 18 17:25:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDLgi-0004Ik-62
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 17:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbYLRQYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 11:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbYLRQYF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 11:24:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:56341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751281AbYLRQYE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 11:24:04 -0500
Received: (qmail invoked by alias); 18 Dec 2008 16:24:00 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp033) with SMTP; 18 Dec 2008 17:24:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/FtpFf0s/ThM8MA4T3xGgy0lc+L7cTxKdxc+Pkm
	Ke/tUrL7HR7aHA
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20081218140411.GB6706@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103468>

Hi,

On Thu, 18 Dec 2008, Jeff King wrote:

> It _would_ be a nicer workflow to say "I don't want these changes yet" 
> and selectively put them elsewhere, test what's in the working tree, 
> commit, and then grab some more changes from your stash. But we don't 
> have interactive stashing and unstashing yet, which would be required 
> for that.

git stash -i... Yes, I'd like that!

Ciao,
Dscho
