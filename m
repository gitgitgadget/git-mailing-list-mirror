From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 17:51:22 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801161751000.17650@racer.site>
References: <478D79BD.7060006@talkingspider.com> <86hcheig3n.fsf@blue.stonehenge.com> <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org> <478E3D8E.1090300@talkingspider.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Neil Macneale <mac4-git@theory.org>, git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:52:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFCQd-0003iJ-Js
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 18:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbYAPRv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 12:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbYAPRv1
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 12:51:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:53113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750861AbYAPRv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 12:51:26 -0500
Received: (qmail invoked by alias); 16 Jan 2008 17:51:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 16 Jan 2008 18:51:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Kmr8fq99K+jQH/KqxUwAWddmOTQbSTEqPvKwB4K
	rAtXgprDhWatam
X-X-Sender: gene099@racer.site
In-Reply-To: <478E3D8E.1090300@talkingspider.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70708>

Hi,

On Wed, 16 Jan 2008, Mike wrote:

> Neil Macneale wrote:
> > Mike wrote:
> >> ....  And as for permissions and ownership, rsync takes care of that.
> > Perhaps "rsync --exclude *.git"?
> >
> > It seems to me that you are asking git to be your deployment software,
> > which is a bad fit.
> 
> I'm asking git to get out of my deployment!

But that's easy: rm -rf /usr/bin/git* .git/ ;-)

Hth,
Dscho
