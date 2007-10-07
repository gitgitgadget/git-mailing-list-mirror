From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] git-gui i18n: Add more words to glossary.
Date: Mon, 8 Oct 2007 00:31:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710080029430.4174@racer.site>
References: <200710052239.02492.stimming@tuhh.de> <20071007180559.GA2137@spearce.org>
 <200710072242.26288.stimming@tuhh.de> <20071007231231.GD2137@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:31:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iefb7-0005CN-MK
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349AbXJGXbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 19:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755822AbXJGXbf
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:31:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:59638 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755006AbXJGXbe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:31:34 -0400
Received: (qmail invoked by alias); 07 Oct 2007 23:31:32 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp050) with SMTP; 08 Oct 2007 01:31:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/McwvQ28/sdV/qg5SIi0F3JPDZ8aItE5TpxC2F3
	ow20VBZouXxnXS
X-X-Sender: gene099@racer.site
In-Reply-To: <20071007231231.GD2137@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60260>

Hi,

On Sun, 7 Oct 2007, Shawn O. Pearce wrote:

> If you are sending a series like that and its all po translation stuff 
> that is unlikely to need commenting on feel free to just dump it all out 
> as a single mbox (`git format-patch --stdout`) and attach it to the 
> email.  Less chance of the MUA mangling the message.

In this case, I suggest just pushing it to git-gui-i18n.git, maybe as a 
temporary branch "for-shawn", and send a pull request.  That's the best 
way to ensure that nothing gets mangled.

Ciao,
Dscho

P.S.: Yeah, I haven't been really good with i18n recently; will try to put 
more work into it soon.
