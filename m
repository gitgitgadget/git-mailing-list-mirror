From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 2 Jan 2009 20:07:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901022007280.30769@pacific.mpi-cbg.de>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <alpine.LFD.2.00.0901011151440.5086@localhost.localdomain> <alpine.DEB.1.00.0901021914420.30769@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0901021045290.5086@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 20:08:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIpNt-0004i8-Rp
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 20:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758815AbZABTHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 14:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758787AbZABTHT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 14:07:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:60850 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758772AbZABTHS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 14:07:18 -0500
Received: (qmail invoked by alias); 02 Jan 2009 19:07:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 02 Jan 2009 20:07:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rEeIMXuVrGWlhrLK8gRXd4mG5OTnxBKV0MK5lZx
	rKubnsN0IBfEtE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0901021045290.5086@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104407>

Hi,

On Fri, 2 Jan 2009, Linus Torvalds wrote:

> On Fri, 2 Jan 2009, Johannes Schindelin wrote:
> > 
> > BTW the "-p" is not necessary with "show", indeed, you cannot even 
> > switch it off.
> 
> I was just switching back-and-forth between "git log" and "git show" so 
> the -p came from just that, and is not necessary.
> 
> And you _can_ suppress the patch generation - use "-s".

Ah, another thing learnt.

Thanks,
Dscho
