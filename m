From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: [ANN] bzr-fast-export
Date: Fri, 7 Mar 2008 13:03:47 +0100
Message-ID: <20080307120347.GA27001@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: bazaar@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-bounces@lists.canonical.com Fri Mar 07 13:11:59 2008
Return-path: <bazaar-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from chlorine.canonical.com ([91.189.94.204])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXbQc-00043O-U8
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 07 Mar 2008 13:11:59 +0100
Received: from localhost ([127.0.0.1] helo=chlorine.canonical.com)
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-bounces@lists.canonical.com>)
	id 1JXbQ3-00010X-A7; Fri, 07 Mar 2008 12:11:23 +0000
Received: from gluck.debian.org ([192.25.206.10])
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <dato@net.com.org.es>) id 1JXbPb-0000xV-VM
	for bazaar@lists.canonical.com; Fri, 07 Mar 2008 12:10:56 +0000
Received: from localhost ([127.0.0.1] helo=chistera.yi.org)
	by gluck.debian.org with esmtp (Exim 4.50)
	id 1JXbPT-0005c2-QM; Fri, 07 Mar 2008 05:10:48 -0700
Received: from userid 1000 by plumber with local (Exim 4.69) 
	id 1JXbIh-0007fn-Cz; Fri, 07 Mar 2008 13:03:47 +0100
Mail-Followup-To: bazaar@lists.canonical.com, git@vger.kernel.org,
	Ian Clatworthy <ian.clatworthy@internode.on.net>
Content-Disposition: inline
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-BeenThere: bazaar@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar discussion <bazaar.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar>
List-Post: <mailto:bazaar@lists.canonical.com>
List-Help: <mailto:bazaar-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-bounces@lists.canonical.com
Errors-To: bazaar-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76482>

I was needing a bzr frontend for git-fast-import, and as there wasn't
one, I wrote it.

It does all what I need, so I'm not atm much interested in spending more
time on it, but as noted in the README, Ian Clatworthy (the author of
bzr-fastimport) is willing to take ownership of it under the bzr-fastimport
umbrella.

The current (fast food) code lives at:

  http://chistera.yi.org/~adeodato/tmp/other/bzr-fast-export.git

I'll update the README file in that repository once it gets integrated
into bzr-fastimport.

Cheers,
