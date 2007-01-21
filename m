From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-push through git protocol
Date: Sun, 21 Jan 2007 22:16:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701212215030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17843.29798.866272.414435@lisa.zopyra.com> <ep00nl$mop$1@sea.gmane.org>
 <Pine.LNX.4.64.0701211034490.14248@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Bill Lear <rael@zopyra.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 21 22:16:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8k30-0004wQ-PT
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 22:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbXAUVQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 16:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbXAUVQN
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 16:16:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:49108 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751646AbXAUVQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 16:16:12 -0500
Received: (qmail invoked by alias); 21 Jan 2007 21:16:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 21 Jan 2007 22:16:11 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701211034490.14248@woody.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37343>

Hi,

On Sun, 21 Jan 2007, Linus Torvalds wrote:

> NOTE! "git-receive-pack" is disabled by default, so you need to enable 
> it explicitly by starting git-daemon with the "--enable=receive-pack" 
> command line argument, or by having your config enable it automatically.

This is not a great idea. At least a config variable should be responsible 
for that.

> And a second note: I obviously didn't test it. I'm Linus. I don't do no 
> steenking testing..

Why do you mention that? We know...

Ciao,
Dscho
