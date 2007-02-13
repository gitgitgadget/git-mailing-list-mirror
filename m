From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Publishing on a simple HTTP server
Date: Tue, 13 Feb 2007 11:07:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702131106230.1300@wbgn013.biozentrum.uni-wuerzburg.de>
References: <14870.1171311025@localhost>
 <Pine.LNX.4.63.0702130009010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <19695.1171344721@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 11:07:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGuZU-0007cG-SS
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 11:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbXBMKHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 05:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbXBMKHe
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 05:07:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:51543 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751236AbXBMKHd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 05:07:33 -0500
Received: (qmail invoked by alias); 13 Feb 2007 10:07:32 -0000
X-Provags-ID: V01U2FsdGVkX1+0yNFcE+q0MOlP/mYt74jFFXEN2jjtQvDeW1d7/I
	Zk0g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <19695.1171344721@localhost>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39509>

Hi,

On Tue, 13 Feb 2007, Xavier Maillard wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Mon, 12 Feb 2007, Xavier Maillard wrote:
> > 
> > > Cannot get remote repository information.
> > > Perhaps git-update-server-info needs to be run there?
> > 
> > How did you upload?
> 
> I wrote a small LFTP mirror script.
> 
> I will check your tutorial but I am pretty sure I won't be able to run 
> all the commands (I, for example, can't do more than connecting onto a 
> FTP server at my FAI).

In that case, please extend your mirror script to run 
git-update-server-info before mirroring.

And if it works, a small description (maybe as a patch for 
Documentation/howto/?) would be nice.

Ciao,
Dscho
