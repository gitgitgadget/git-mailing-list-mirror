From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deleting remote branches with git-branch and reflog questions
Date: Tue, 23 Jan 2007 15:59:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231558080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701231259.27719.andyparkins@gmail.com> <ep51ie$i23$1@sea.gmane.org>
 <200701231432.24225.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 23 15:59:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9N7D-0004Gv-6e
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 15:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbXAWO7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 09:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbXAWO7J
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 09:59:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:47065 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965224AbXAWO7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 09:59:08 -0500
Received: (qmail invoked by alias); 23 Jan 2007 14:59:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 23 Jan 2007 15:59:06 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701231432.24225.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37528>

Hi,

On Tue, 23 Jan 2007, Andy Parkins wrote:

> On Tuesday 2007 January 23 13:12, Jakub Narebski wrote:
> 
> > The problem is when you delete branch 'foo', and then create branch
> > 'foo/bar'. You can't have both 'foo' and 'foo/bar' reflog.
> 
> Ah; yes of course.  That is a bit of a deal breaker isn't it?
> 
> On the other hand, why delete it instantly?

You mean, kind of like a waste bin? Where you delete stuff, but come back 
and whine that you did not meant to delete it after all?

:-))

Ciao,
Dscho
