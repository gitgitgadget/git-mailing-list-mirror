From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: wishlist: git info
Date: Tue, 13 Nov 2007 11:13:59 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711131111220.4362@racer.site>
References: <fhad5q$iia$1@ger.gmane.org> <20071112222106.GE2918@steel.home>
 <4738D8AA.1030604@users.sourceforge.net> <fhaol0$p5r$1@ger.gmane.org>
 <fhbn50$uqu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Neumann <tneumann@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 12:14:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irtj9-0003sS-Ec
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 12:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbXKMLO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 06:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752122AbXKMLO1
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 06:14:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:35783 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751883AbXKMLO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 06:14:26 -0500
Received: (qmail invoked by alias); 13 Nov 2007 11:14:25 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp044) with SMTP; 13 Nov 2007 12:14:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18u2bEs5CIutSbjMuVF5fThl1/GPan7k8dJePjeZm
	4l+eMvvz3YmuCA
X-X-Sender: gene099@racer.site
In-Reply-To: <fhbn50$uqu$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64789>

Hi,

On Tue, 13 Nov 2007, Thomas Neumann wrote:

> Perhaps also project description (if it exists?) one can specify a 
> project description? I did not even know this. But yes, this would be 
> useful, too. In general I think git info should show everything to 
> quickly understand what is currently checked out.

Is slightly troubles me that you put so much emphasis on what I would call 
"remote information".  I understand that in svn, your working directory 
without the server is not very useful.  But we do not have that problem.

> The name of the current branch should probably be included, too.

FWIW I think a much better idea is to have that bash prompt that was 
posted some months ago; there's not even a need to run a program manually 
then!

> I use an alias with the commands proposed by Alex Riessen for now, but a 
> more general command would be nice.

His name is "Riesen", just like in the German translation of the famous 
Newton statement.

Ciao,
Dscho
