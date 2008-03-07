From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [ANN] bzr-fast-export
Date: Fri, 7 Mar 2008 13:55:09 +0100
Message-ID: <20080307125509.GA32439@chistera.yi.org>
References: <20080307120347.GA27001@chistera.yi.org>
	<alpine.LSU.1.00.0803071340360.19395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: bazaar@lists.canonical.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: bazaar-bounces@lists.canonical.com Fri Mar 07 13:55:59 2008
Return-path: <bazaar-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from chlorine.canonical.com ([91.189.94.204])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXc77-0002uH-Fd
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 07 Mar 2008 13:55:53 +0100
Received: from localhost ([127.0.0.1] helo=chlorine.canonical.com)
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-bounces@lists.canonical.com>)
	id 1JXc6U-0002e4-1C; Fri, 07 Mar 2008 12:55:14 +0000
Received: from gluck.debian.org ([192.25.206.10])
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <dato@net.com.org.es>) id 1JXc6S-0002dp-Hz
	for bazaar@lists.canonical.com; Fri, 07 Mar 2008 12:55:12 +0000
Received: from localhost ([127.0.0.1] helo=chistera.yi.org)
	by gluck.debian.org with esmtp (Exim 4.50)
	id 1JXc6R-0003VD-8P; Fri, 07 Mar 2008 05:55:11 -0700
Received: from userid 1000 by plumber with local (Exim 4.69) 
	id 1JXc6P-0008Rz-NP; Fri, 07 Mar 2008 13:55:09 +0100
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	bazaar@lists.canonical.com, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803071340360.19395@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76489>

* Johannes Schindelin [Fri, 07 Mar 2008 13:45:28 +0100]:

> BTW is it possible to import a git repository into bzr with git 
> fast-export | bzr-fastimport?

Yes, with the bzr-fastimport plugin written by Ian Clatworthy (not by
me!).

  https://launchpad.net/bzr-fastimport
