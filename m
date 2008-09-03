From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Are more and more patches getting lost lately?
Date: Thu, 04 Sep 2008 08:33:43 +0900
Message-ID: <20080904083343.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 01:38:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb1vY-0005OW-6L
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 01:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbYICXhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 19:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbYICXhN
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 19:37:13 -0400
Received: from karen.lavabit.com ([72.249.41.33]:33589 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034AbYICXhM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 19:37:12 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id E8F9DC7B0F;
	Wed,  3 Sep 2008 18:37:01 -0500 (CDT)
Received: from 5341.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id GRD3QYULU0DF; Wed, 03 Sep 2008 18:37:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Tm8+Mn/WEnb3/wcyuqWh2im6FUGEXwa1gbLxYJHi+gOED4z6MPgxuXCta9UsrusIX+Mtr6cn3mtUXrRM0jB1oxCAst2LOzManzz/b3yu+CXvPfiKnhmx2lQRgJ9z9dO9vpCrF8HyjIaVnOiMe3zCBbZQ36lgNXDXIRIuYWIxjC8=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94872>

I noticed that recently there are many patches sent to the list
that are left unapplied (and many of them are from you).  Many
of them look useful or at least promising to become useful.

What can we, the mailing list readers, do to help these patches
applied?  Ask the authors of individual patches about their
progress?


From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] bash completion: Hide more plumbing commands
Date: Tue, 26 Aug 2008 19:11:44 +0200
Message-ID: <20080826171144.21328.82727.stgit@localhost>

http://article.gmane.org/gmane.comp.version-control.git/93772

From: Karl Chen <quarl@cs.berkeley.edu>
Subject: [PATCH v4] Expand ~ and ~user in core.excludesfile, commit.template
Date: Fri, 29 Aug 2008 02:29:00 -0700
Message-ID: <quack.20080829T0229.lthhc94rwyr_-_@roar.cs.berkeley.edu>

http://article.gmane.org/gmane.comp.version-control.git/94276

From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] add a pre-merge hook
Date: Tue, 27 Aug 2008 14:19:42 +0200
Message-ID: <E1KYK3t-0000ZX-3b@fencepost.gnu.org>

http://article.gmane.org/gmane.comp.version-control.git/93888

From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t9700-perl-git.sh: Fix a test failure on cygwin
Date: Wed, 27 Aug 2008 19:09:15 +0100
Message-ID: <48B5984B.4020901@ramsay1.demon.co.uk>

http://article.gmane.org/gmane.comp.version-control.git/93912

From: Marcus Griep <marcus@griep.us>
Subject: [PATCH] git-commit: '--no-status' Allow suppression of status summary in commit msg
Date: Thu, 28 Aug 2008 14:46:55 -0400
Message-ID: <1219949215-10189-1-git-send-email-marcus@griep.us>

http://article.gmane.org/gmane.comp.version-control.git/94111

From: Garry Dolley <gdolley@arpnetworks.com>
Subject: [PATCH/RFC] Clarified how pattern works in documentation to git-show-ref.
Date: Thu, 28 Aug 2008 13:37:16 -0700
Message-ID: <1219955836-10070-1-git-send-email-gdolley@arpnetworks.com>

http://article.gmane.org/gmane.comp.version-control.git/94136

From: "Nathan Panike" <nathan.panike@gmail.com>
Subject: [PATCH 0/2] Use %as and %cs as pretty format flags
Date: Thu, 28 Aug 2008 06:09:37 -0500
Message-ID: <d77df1110808280409o9445f9fybcab2c8d1066a8d8@mail.gmail.com>

http://article.gmane.org/gmane.comp.version-control.git/94176

From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] git-am: Pass the --directory option through to git-apply
Date: Fri, 29 Aug 2008 15:27:50 -0700
Message-ID: <1220048870-97641-1-git-send-email-kevin@sb.org>

http://article.gmane.org/gmane.comp.version-control.git/94335

From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] mention required Perl version in INSTALL
Date: Sat, 30 Aug 2008 19:13:12 +0200
Message-ID: <20080830171312.GE7185@schiele.dyndns.org>

http://article.gmane.org/gmane.comp.version-control.git/94389

From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Correct documentation wording for diff options -S and --pickaxe-all
Date: Mon, 1 Sep 2008 02:03:04 +0300
Message-ID: <20080831230304.GA30480@zakalwe.fi>

http://article.gmane.org/gmane.comp.version-control.git/94513

From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] Support diff.autorefreshindex=true in `git-diff --quiet'
Date: Mon, 01 Sep 2008 23:20:26 -0700
Message-ID: <7vy72bnk5x.fsf_-_@gitster.siamese.dyndns.org>

http://article.gmane.org/gmane.comp.version-control.git/94651

From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Git 1.6.0.1 breaks git-svn with perl 5.8.0
Date: Mon, 1 Sep 2008 11:27:59 +0200
Message-ID: <48BBB59F.9080204@statsbiblioteket.dk>

http://article.gmane.org/gmane.comp.version-control.git/94548

From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Bust the ghost of long-defunct diffcore-pathspec.
Date: Mon, 01 Sep 2008 23:53:54 +0200
Message-ID: <20080901215353.30399.33432.stgit@gandelf.nowhere.earth>

http://article.gmane.org/gmane.comp.version-control.git/94615

From: David Aguilar <davvid@gmail.com>
Subject: [RFC/PATCH] git-mergetool: allow using merge tools for staging changes
Date: Tue,  2 Sep 2008 00:25:49 -0700
Message-ID: <ca72cec5020d847ac7d1577c586772ae22810bef.1220339887.git.davvid@gmail.com>

http://article.gmane.org/gmane.comp.version-control.git/94660

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ignore trailing slash when creating leading directories
Date: Tue, 02 Sep 2008 14:10:15 -0700
Message-ID: <7v1w02jlu0.fsf@gitster.siamese.dyndns.org>

http://article.gmane.org/gmane.org gmane.comp.version-control.git/94715

From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] Documentation: new upstream rebase recovery section in git-rebase
Date: Tue,  2 Sep 2008 22:18:41 +0200
Message-ID: <1220386721-10215-1-git-send-email-trast@student.ethz.ch>

http://article.gmane.org/gmane.comp.version-control.git/94701

From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t9301-fast-export: move unset of config variable into its own test function
Date: Thu, 21 Aug 2008 19:48:49 -0500
Message-ID: <ZdQ6b4vecqtrZ-7Mze6M9UBwrI9qQRUu-BoApXUv0v2zM76stzXd3w@cipher.nrlssc.navy.mil>

http://article.gmane.org/gmane.comp.version-control.git/93239

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
