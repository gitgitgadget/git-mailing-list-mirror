From: Abderrahim Kitouni <a.kitouni@gmail.com>
Subject: Re: rebase-with-history -- a technique for rebasing without trashing 
	your repo history
Date: Thu, 13 Aug 2009 21:31:04 +0100
Message-ID: <3d6b0edb0908131331l5a3177d1t3d1e1858fc139b2e@mail.gmail.com>
References: <4A840B0F.9060003@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bazaar <bazaar@lists.canonical.com>,
	mercurial mailing list <mercurial@selenic.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: mercurial-bounces@selenic.com Thu Aug 13 22:31:10 2009
Return-path: <mercurial-bounces@selenic.com>
Envelope-to: gcvmd-mercurial@gmane.org
Received: from waste.org ([173.11.57.241] helo=mail.waste.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbgx4-0002eN-0g
	for gcvmd-mercurial@gmane.org; Thu, 13 Aug 2009 22:31:10 +0200
Received: from waste.org (waste.org [173.11.57.241])
	by mail.waste.org (Postfix) with ESMTP id 138A65C810F;
	Thu, 13 Aug 2009 15:31:09 -0500 (CDT)
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by waste.org (8.13.8/8.13.8/Debian-3) with ESMTP id n7DKV4kr015511
	for <mercurial@selenic.com>; Thu, 13 Aug 2009 15:31:05 -0500
Received: by qw-out-2122.google.com with SMTP id 5so322443qwi.11
	for <mercurial@selenic.com>; Thu, 13 Aug 2009 13:31:04 -0700 (PDT)
Received: by 10.229.37.74 with SMTP id w10mr1170547qcd.73.1250195464196; Thu, 
	13 Aug 2009 13:31:04 -0700 (PDT)
In-Reply-To: <4A840B0F.9060003@alum.mit.edu>
X-Virus-Scanned: by amavisd-new
X-BeenThere: mercurial@selenic.com
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: <mercurial.selenic.com>
List-Unsubscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=unsubscribe>
List-Archive: <http://selenic.com/pipermail/mercurial>
List-Post: <mailto:mercurial@selenic.com>
List-Help: <mailto:mercurial-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=subscribe>
Sender: mercurial-bounces@selenic.com
Errors-To: mercurial-bounces@selenic.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125869>

2009/8/13 Michael Haggerty <mhagger@alum.mit.edu>:
> I've been thinking a lot about the problems of tracking upstream changes
> while developing a feature branch.
Isn't this the purpose of pbranch [1] (and I beleive bzr's loom[2] and
git's topgit[3])?

Peace,
Abderrahim

[1] http://arrenbrecht.ch/mercurial/pbranch/
[2] https://launchpad.net/bzr-loom
[3]http://repo.or.cz/w/topgit.git
