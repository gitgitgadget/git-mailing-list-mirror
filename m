From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 10:37:51 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801161036510.17650@racer.site>
References: <478D79BD.7060006@talkingspider.com> <alpine.LNX.1.00.0801152305050.13593@iabervon.org> <478D8717.50100@talkingspider.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 11:38:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF5fL-0002pG-Ug
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 11:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbYAPKiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 05:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYAPKiL
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 05:38:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:44882 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751785AbYAPKiK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 05:38:10 -0500
Received: (qmail invoked by alias); 16 Jan 2008 10:38:09 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp035) with SMTP; 16 Jan 2008 11:38:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SxuplZACSmoM8JZgwh/V4Cw5pxre4qmZZBDlGWi
	C8tL8DWlbJV6+n
X-X-Sender: gene099@racer.site
In-Reply-To: <478D8717.50100@talkingspider.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70649>

Hi,

On Tue, 15 Jan 2008, Mike wrote:

> Daniel Barkalow wrote:
> > On Tue, 15 Jan 2008, Mike wrote:
> >
> > Generate your tarballs with "git archive", which will also make sure 
> > that you don't accidentally include anything else that's not 
> > committed. Likewise for sending to the live site, probably.
> 
> Thanks please see my response to David about why this isn't good.

See Luke Lu's answer to your response about why you're wrong.  It's even 
in the man page of git-archive.

Hth,
Dscho
