From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problems with git-svnimport
Date: Thu, 7 Jun 2007 23:29:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706072329020.4046@racer.site>
References: <Pine.LNX.4.64.0706071639190.12111@www.mintpixels.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: plexq@plexq.com
X-From: git-owner@vger.kernel.org Fri Jun 08 00:32:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwQWh-0005dB-Jk
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 00:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937433AbXFGWbr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 18:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937597AbXFGWbr
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 18:31:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:39926 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S937513AbXFGWbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 18:31:45 -0400
Received: (qmail invoked by alias); 07 Jun 2007 22:31:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 08 Jun 2007 00:31:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19aBMs5b5NaROxy+B7nPqaqZrcyIDoZKB9sVzAtac
	WBt6R8Qn6FSeJP
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0706071639190.12111@www.mintpixels.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49396>

Hi,

On Thu, 7 Jun 2007, Alex R.M. Turner wrote:

> I am trying to import my svn project into git with git-svnimport, but I am 
> getting a bunch of error messages using the following command:
> 
> git-svnimport -C eastcoastmarine -v \
> svn://svn.mintpixels.com/eastcoastmarine-website
> 
> I get messages like:
> 4: Unrecognized path: /trend-scripts/trunk/run_purge.sh

Let's deprecate git-svnimport, once for all.

git-svn should work much better.

Ciao,
Dscho
