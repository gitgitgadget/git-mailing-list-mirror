From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to create & switch to a branch after changes have already
 been made?
Date: Tue, 3 Jul 2007 12:10:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707031210020.4071@racer.site>
References: <e2a1d0aa0707021918mb335856j278b3128203a793a@mail.gmail.com>
 <e2a1d0aa0707021949k181f9042j26ebd124f61ca1ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 13:10:16 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5gGu-0005Br-Jz
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 13:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259AbXGCLKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 07:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757006AbXGCLKN
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 07:10:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:53778 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754006AbXGCLKM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 07:10:12 -0400
Received: (qmail invoked by alias); 03 Jul 2007 11:10:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 03 Jul 2007 13:10:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180xisfGU00vhdu5x2Zrm0Xfxcr4tuSEcGfTYsN9m
	FvDx1dPKAJYtxC
X-X-Sender: gene099@racer.site
In-Reply-To: <e2a1d0aa0707021949k181f9042j26ebd124f61ca1ae@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51473>

Hi,

On Mon, 2 Jul 2007, Patrick Doyle wrote:

> Hmmm... One thing I might tell the hypothetical person is to temporarily 
> delete or rename the new version of "somefile", so that the merge could 
> complete with problems, and then recreate or rename it back. That would 
> probably allow the hypothetical person to continue his/her work.

You could also say "git checkout -f newbranch".

Ciao,
Dscho
