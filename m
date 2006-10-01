From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and time
Date: Sun, 1 Oct 2006 10:37:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610011034550.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060928022917.29678.qmail@web51011.mail.yahoo.com>
 <Pine.LNX.4.64.0609272232040.9349@xanadu.home> <7vfyec63jx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609281029300.9349@xanadu.home> <7vd59ejokp.fsf@assigned-by-dhcp.cox.net>
 <20060930045037.GB18479@spearce.org> <7v4pupizix.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609301033460.3952@g5.osdl.org> <7vd59d7y8v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609301712340.3952@g5.osdl.org> <7v64f47uix.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 10:37:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTwpA-0004vN-Mj
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 10:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWJAIhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 04:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbWJAIhN
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 04:37:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:40908 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750805AbWJAIhL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 04:37:11 -0400
Received: (qmail invoked by alias); 01 Oct 2006 08:37:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 01 Oct 2006 10:37:10 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64f47uix.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28172>

Hi,

On Sat, 30 Sep 2006, Junio C Hamano wrote:

> I think we cannot get away without honestly doing the first descendant, 
> which is unfortunately a lot more expensive.

... and which happens to be almost implemented in git-name-rev.

Ciao,
Dscho
