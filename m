From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [gitk] [PATCH] 0/2 Merging master into dev
Date: Wed, 11 Nov 2009 17:52:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911111751370.19111@intel-tinevez-2-302>
References: <871vkbw7x2.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 17:53:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8GRu-0001zb-Te
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 17:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757990AbZKKQwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 11:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758005AbZKKQwq
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 11:52:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:57047 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757510AbZKKQwp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 11:52:45 -0500
Received: (qmail invoked by alias); 11 Nov 2009 16:52:48 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp036) with SMTP; 11 Nov 2009 17:52:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18FrEl/P20FHNji8IjOoA/kPxYfXMuR84m3oxenNV
	K32SWF+yONRauQ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <871vkbw7x2.fsf@users.sourceforge.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132672>

Hi (especially "Hi Paul"),

On Sat, 6 Nov 2009, Pat Thoyts wrote:

> I've merged the current changes for gitk master onto the dev branch and 
> fixed some conflicts and then modified the default colour assignments 
> for windows to use the system colours so that it will pick up the stock 
> colours defined via the windows property pages.
> 
> However, I'm not too certain how to post such a merge commit. Usually I 
> do 'git format-patch -M' but in this case that emits all the commits 
> that were merged. It looks like 'git show -p' is producing a merge patch 
> so I am posting that for 1/2 and a normal patch for 2/2. If there is 
> better way let me know and I will redo.
> 
> Note: these patches are for the gitk dev branch.
> 
> Hopefully this themed tk version is suitable for merging up to master 
> soon as this will significantly improve the look of the application in 
> msysGit.

I have no illusions about the priority of msysGit-related patches for 
gitk, but it would be nice to get this going again.  (And I want to avoid 
forking gitk just for msysGit.)

Paul?

Ciao,
Dscho
