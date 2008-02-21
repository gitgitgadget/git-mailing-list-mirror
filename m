From: Mike Galbraith <efault@gmx.de>
Subject: Re: bisect: "won't bisect on seeked tree"
Date: Thu, 21 Feb 2008 06:39:48 +0100
Message-ID: <1203572388.20492.0.camel@homer.simson.net>
References: <1203571214.24456.6.camel@homer.simson.net>
	 <20080221053307.GA2887@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 06:40:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS4AT-0007es-5R
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 06:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbYBUFju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 00:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbYBUFju
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 00:39:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:60487 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751614AbYBUFjt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 00:39:49 -0500
Received: (qmail invoked by alias); 21 Feb 2008 05:39:47 -0000
Received: from p54B5BA9E.dip0.t-ipconnect.de (EHLO [192.168.178.23]) [84.181.186.158]
  by mail.gmx.net (mp043) with SMTP; 21 Feb 2008 06:39:47 +0100
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX18GbHEwHjUG3HKRnEIc0xM5x+JoGKb3pbiUdURRVC
	mIttH1VO3yCO6x
In-Reply-To: <20080221053307.GA2887@spearce.org>
X-Mailer: Evolution 2.12.0 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74600>


On Thu, 2008-02-21 at 00:33 -0500, Shawn O. Pearce wrote:
> Mike Galbraith <efault@gmx.de> wrote:
> > I have no idea how tree became "seeked", but would love to know how to
> > "un-seek" it so I can proceed with a bisection.  Help?
> 
> I think you are already in the middle of a bisect.
> 
> Try "git bisect reset" first to get out of the current bisect before
> starting another one.

It says "We are not bisecting".

	-Mike
