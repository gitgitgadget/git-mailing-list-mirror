From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: git-svn and u-boot broken.
Date: Sat, 14 Oct 2006 15:13:26 +0200
Message-ID: <00f701c6ef92$88b84840$1267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Randal L. Schwartz'" <merlyn@stonehenge.com>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 14 15:15:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYjMb-0006Aw-NX
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 15:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422627AbWJNNPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 09:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422628AbWJNNPe
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 09:15:34 -0400
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:2790
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1030309AbWJNNPd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 09:15:33 -0400
Received: from Jocke ([84.217.9.178]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 14 Oct 2006 15:15:31 +0200
To: "'Eric Wong'" <normalperson@yhbt.net>
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AcbvWfivBqbYme0pTJKSKDrjbad7VwAGQIJAAAfASpA=
In-Reply-To: 
X-OriginalArrivalTime: 14 Oct 2006 13:15:31.0638 (UTC) FILETIME=[D353B560:01C6EF92]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28876>

> > Also, which version of git-svn are you running?  Also, which 
> > version of
> > Subversion (client library, and server (if possible) are 
> you running?
> 
> git 1.4.2.3
> subversion 1.3.2-r1
> 
> I will try upgrading to newer subverison.

subversion 1.4.0 didn't help

PS.

I can't find the dcommit command in git-cvs, has it been removed?
if so, then the docs need an update.
