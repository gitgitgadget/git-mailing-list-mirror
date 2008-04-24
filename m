From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] make git-status use a pager
Date: Thu, 24 Apr 2008 09:21:04 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804240920170.26553@eeepc-johanness>
References: <> <1208998668-28770-1-git-send-email-bart@jukie.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bart Trojanowski <bart@jukie.net>
X-From: git-owner@vger.kernel.org Thu Apr 24 10:21:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JowiH-0007e3-MF
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 10:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbYDXIVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 04:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbYDXIVG
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 04:21:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:39354 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751593AbYDXIVF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 04:21:05 -0400
Received: (qmail invoked by alias); 24 Apr 2008 08:21:03 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp037) with SMTP; 24 Apr 2008 10:21:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dJrBy2v5duh3kxqAqm/B9Xm7AyM6W9PddZIIGwd
	mw6Xhl8Iih30HB
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1208998668-28770-1-git-send-email-bart@jukie.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80299>

Hi,

On Wed, 23 Apr 2008, Bart Trojanowski wrote:

> make git status act similar to git log and git diff by presenting long 
> output in a pager.

Heh.  The first thing I do on new machines is to compile and install Git.  
The second is "git config --global alias.ps '-p status'"  :-)

So I obviously like your patch.

Ciao,
Dscho
