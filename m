From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: attempting to clone the git repo
Date: Thu, 8 Mar 2007 18:29:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703081828500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <2fb03ecb0703080849m41ac8158y4895f2bc811934f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Kilroy <lemonkandy@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 18:30:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPMRV-0001IF-Al
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 18:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbXCHR3P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 12:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbXCHR3O
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 12:29:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:47219 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932178AbXCHR3N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 12:29:13 -0500
Received: (qmail invoked by alias); 08 Mar 2007 17:29:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 08 Mar 2007 18:29:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/YhMOMqJ/KgQS15X8BrzF2v+NW6ig3yDYIMPPG2
	kA9XE6+Cw4e+aT
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <2fb03ecb0703080849m41ac8158y4895f2bc811934f5@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41763>

Hi,

On Thu, 8 Mar 2007, Andrew Kilroy wrote:

> I'm attempting to clone the git repository using git-1.5.0.3 in my workplace.
> Port 9418's blocked by the firewall, so I'm trying via http:
> 
>    $ git clone http://git.kernel.org/pub/scm/git/git.git

Add a "/" to the end:

$ git clone http://git.kernel.org/pub/scm/git/git.git/

Hth,
Dscho
