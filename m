From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Clarify documentation of git-cvsserver, particularly in
 relation to git-shell
Date: Sat, 19 Apr 2008 16:45:38 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804191643330.20708@eeepc-johanness>
References: <1208273402-2152-1-git-send-email-scc@ScottCollins.net> <7vve2jx9at.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Collins <scc@ScottCollins.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 20:01:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnFGT-00074s-75
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 17:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbYDSPpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 11:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbYDSPpX
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 11:45:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:35133 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752328AbYDSPpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 11:45:23 -0400
Received: (qmail invoked by alias); 19 Apr 2008 15:45:21 -0000
Received: from R2c2d.r.pppool.de (EHLO eeepc-johanness.st-andrews.ac.uk) [89.54.44.45]
  by mail.gmx.net (mp046) with SMTP; 19 Apr 2008 17:45:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PFm4WZHlPCq3YSceiQBs0WfmG+bu1koZYxKDBgc
	/lbVwktSobFQHe
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vve2jx9at.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79906>

Hi,

On Tue, 15 Apr 2008, Junio C Hamano wrote:

> Dscho, care to comment?  This commit happened while I was away so I do 
> not really _recall_ the discussion that led to it, but I have always 
> thought that was the intention.

Sorry, was out of the loop for a few days.  Private life and moving to 
another country will do that to you.

I commented on the new version of the patch.  AFAIR I tried to get 
"git-cvsserver" allowed in git-shell, too, but that was shot down.  I am 
not sure if we should include that again, for ease of use, though.

Ciao,
Dscho
