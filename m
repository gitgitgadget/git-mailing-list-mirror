From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: attempting to clone the git repo
Date: Thu, 8 Mar 2007 18:33:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703081833020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <2fb03ecb0703080849m41ac8158y4895f2bc811934f5@mail.gmail.com>
 <Pine.LNX.4.63.0703081828500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Kilroy <lemonkandy@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 18:33:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPMUz-0002mw-HW
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 18:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbXCHRdu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 12:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbXCHRdu
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 12:33:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:50224 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752590AbXCHRdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 12:33:49 -0500
Received: (qmail invoked by alias); 08 Mar 2007 17:33:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 08 Mar 2007 18:33:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+MJktHC9KMMlUON+FAgMhiuRq7swkyzx8c9S3J8h
	3TgRsvgxC2/ozY
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0703081828500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41765>

Hi,

On Thu, 8 Mar 2007, Johannes Schindelin wrote:

> On Thu, 8 Mar 2007, Andrew Kilroy wrote:
> 
> > I'm attempting to clone the git repository using git-1.5.0.3 in my workplace.
> > Port 9418's blocked by the firewall, so I'm trying via http:
> > 
> >    $ git clone http://git.kernel.org/pub/scm/git/git.git
> 
> Add a "/" to the end:
> 
> $ git clone http://git.kernel.org/pub/scm/git/git.git/

Sorry. After trying: this does no longer work. Evidently, something 
changed (gitweb says http://git.kernel.org//git/git.git (sic!) is correct 
now, but it is not).

Sorry again,
Dscho
