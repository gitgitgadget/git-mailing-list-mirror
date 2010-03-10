From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Wed, 10 Mar 2010 17:44:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003101741350.3006@intel-tinevez-2-302>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302> <vpqtyso5nfl.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 10 17:45:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpP25-00018H-DL
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 17:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756886Ab0CJQpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 11:45:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:50884 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756853Ab0CJQpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 11:45:08 -0500
Received: (qmail invoked by alias); 10 Mar 2010 16:45:04 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp055) with SMTP; 10 Mar 2010 17:45:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/hNWV1r4nhdb2poVCyrp02Wss09lXTFW2COXPPdH
	129VhW33Blg0r4
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <vpqtyso5nfl.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58999999999999997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141907>

Hi,

On Wed, 10 Mar 2010, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Git Release Notes (Git-1.7.0.2-preview20100309)
> > Last update: 9 March 2010
> 
> I'm adding my thanks to the others already given here. I'm not a windows 
> user, so not using it myself, but it's great to know that Git can run 
> properly on Windows! Keep the great work!

Thanks for those kind words!

> Can you give an update on how much recomandable msysgit is? I mean, at 
> some point in time, users seemed to be happy, but I remember you 
> discouraging people from using it in production because of remaining 
> serious bugs. Do you think it is now stable enough to be recommanded? 
> More reliable than the cygwin version?

I cannot say anything about the Cygwin version, as I haven't used it in 
ages.

As for Git for Windows: I still think that it would be dangerous to let 
users download and use Git for Windows without warning them that they did 
not obtain commercial support, so it is their responsibility to take care 
of any issues they encounter.

While there are quite a number of nice people who are more than willing to 
help (and don't start to count me amongst them :-), nobody should think 
that it is okay to complain when something does not work as expected: they 
should have expected that.

Having said that, I have a number of (almost) happy customers of the thing 
in my day-job project, and that's the only reason why I can get away with 
working a bit on msysGit during work hours.

Ciao,
Dscho
