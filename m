From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 11:52:14 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801081151450.10101@racer.site>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <20080107224204.55539c31@jaiman>
 <Pine.LNX.4.64.0801081150010.25629@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Jan 08 12:52:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCD0p-0000Sr-7g
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 12:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbYAHLwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 06:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756114AbYAHLwa
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 06:52:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:37802 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756045AbYAHLw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 06:52:29 -0500
Received: (qmail invoked by alias); 08 Jan 2008 11:52:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 08 Jan 2008 12:52:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19nYTwMoW9nhWWdWPOhpMYwecMekClL25stsbJ8HW
	pTF6MKTI/bjV79
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0801081150010.25629@ds9.cixit.se>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69867>

Hi,

On Tue, 8 Jan 2008, Peter Karlsson wrote:

> Thomas Neumann:
> 
> > as a user, I expect a SCM to only modify a file when I have
> > explicitly asked it to do so.
> 
> As a user, I exepect things to just work. With RCS/CVS/Subversion, it 
> does, because it differentiates between text files (internally encoding 
> NLs with "LF", but I couldn't care less what it uses there) and binary 
> files (which it doesn't change). With git it currently doesn't since it 
> treats everything as binary files.

<tongue-in-cheek>Hey, if Subversion does what you want, why not just use 
it?</tongue-in-cheek>

Ciao,
Dscho
