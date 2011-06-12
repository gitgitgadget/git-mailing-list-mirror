From: Peter Kleiweg <pkleiweg@xs4all.nl>
Subject: file mode
Date: Sun, 12 Jun 2011 20:57:14 +0200
Organization: -= de Laatste Huismus =-
Message-ID: <alpine.DEB.1.10.1106122055210.6124@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 20:57:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVpr9-0006YK-9G
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 20:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab1FLS5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 14:57:50 -0400
Received: from lo.gmane.org ([80.91.229.12]:37056 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476Ab1FLS5t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 14:57:49 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QVpr0-0006Uq-I5
	for git@vger.kernel.org; Sun, 12 Jun 2011 20:57:46 +0200
Received: from pebbe.xs4all.nl ([80.101.76.238])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 20:57:46 +0200
Received: from pkleiweg by pebbe.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 20:57:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: pebbe.xs4all.nl
X-X-Sender: peter@localhost
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-Accept-Language: nl,af,da,de,en,ia,nds,no,sv,fr,it
X-Face: "K~X:~!ydgSdjNy;]_+BCb\OM^pqyg_q*Le84$l46M\-mL=.^,L4B}bDK>`o#r4_>O*
X-Mailer: Alpine 1.10 (DEB 962 2008-03-14), Linux 2.6.18-6-686, i686
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175663>


I added a file that has file mode 600. When I do a check-out, 
the file comes with mode 644. Is this supposed to happen? Then 
how do I control what permissions files have?


-- 
Peter Kleiweg
http://pkleiweg.home.xs4all.nl/
