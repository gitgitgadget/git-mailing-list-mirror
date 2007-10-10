From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cvsserver: added support for update -p
Date: Wed, 10 Oct 2007 14:47:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710101442571.4174@racer.site>
References: <200710101316.03633.jan@swi-prolog.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jan Wielemaker <jan@swi-prolog.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 15:47:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfbuZ-00046R-Um
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 15:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbXJJNrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 09:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755834AbXJJNrb
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 09:47:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:34370 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755821AbXJJNra (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 09:47:30 -0400
Received: (qmail invoked by alias); 10 Oct 2007 13:47:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 10 Oct 2007 15:47:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dnT9ejxTdwdunPqiZ4Xe/2RbyxZobbs4vz3Oeuz
	vhOeCpl0Vxn1aJ
X-X-Sender: gene099@racer.site
In-Reply-To: <200710101316.03633.jan@swi-prolog.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60497>

Hi,

On Wed, 10 Oct 2007, Jan Wielemaker wrote:

> [PATCH] git-cvsserver: added support for update -p
> ---

Proposed alternative for the commit message:

-- snip --
The cvs subcommand "update -p <file>" is frequently used to see the 
contents of a given file in HEAD, sort of our "git show <file>".  It
is not that hard to support it, so here it is.

Commit-message-proposed-by: Johannes Schindelin <johannes.schindelin.de>
Signed-off-by: Jan Wielemaker <jan@swi-prolog.org>
-- snap --

Remember: having such a commit message already at the beginning of your 
mail body makes it easier to everyone reading your email, for a small 
cost (time) of just one person (you).

Ciao,
Dscho

P.S.: Have not reviewed the patch at all, so cannot say anything about the 
merits of it; will leave it to djpig ;-)
