From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: I've added Dulwich to the Git Wiki
Date: Fri, 16 Jan 2009 23:42:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901162329340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: jelmer@samba.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 23:43:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNxPX-0006Kq-FK
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 23:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765104AbZAPWlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 17:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765071AbZAPWlp
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 17:41:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:59533 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932253AbZAPWln (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 17:41:43 -0500
Received: (qmail invoked by alias); 16 Jan 2009 22:41:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 16 Jan 2009 23:41:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qMCJsCJ+qhAL4xydfpn/rekDTzP9AGxMik6SVfB
	GZzsW87+7+RSeK
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106002>

Hi people,

just got aware of the Dulwich project, which purports to be a pure Python 
Git engine.  I added it here:

http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-762f9c85c62c555dbb88129a127431ddeeb56191

Jelmer, is there a chance you can export the Bazaar repository into a 
public Git repository?  The Bazaar web-frontend does not even allow me to 
download a snapshot.

BTW I find it a bit distressing that more and more projects crop up doing 
substantial and valuable work around Git, but without even bothering to 
mention it on this list.  There might have been a good chance, too, to 
avoid having _three_ Python libraries for exactly the same task.

Ciao,
Dscho

P.S.: In related news, it seems that dotGit -- which _is_ linked on the 
Git Wiki, at least -- progresses rather nicely, which is pretty awesome, 
given that we have _two_ failed GSoC projects under our belt which wanted 
to do the same.  However, dotGit could do with some more visibility on 
this list, too, methinks.
