From: Petr Baudis <pasky@kernel.org>, Junio C Hamano <junio@kernel.org>
Subject: Moving to BK
Date: Sat, 1 Apr 2006 00:00:00 GMT
Message-ID: <200604010311.k313BYeS026266@hera.kernel.org>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 01 05:12:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPWXC-0004kO-Lj
	for gcvg-git@gmane.org; Sat, 01 Apr 2006 05:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWDADMM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 22:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWDADMM
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 22:12:12 -0500
Received: from hera.kernel.org ([140.211.167.34]:17286 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751485AbWDADMK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Mar 2006 22:12:10 -0500
Received: from kernel.org (IDENT:U2FsdGVkX18Pmo0Y+1+kE8K54CSlme9jdf02oPamo4o@localhost [127.0.0.1])
	by hera.kernel.org (8.13.6/8.13.4) with SMTP id k313BYeS026266;
	Sat, 1 Apr 2006 03:11:49 GMT
To: <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18241>

We are pleased to announce that both of us will be working for
BitMover Inc., starting this month.

Petr, the author of the popular Cogito front-end for git, will
be modifying Cogito so that it natively works on BK
repositories.  The superior Cogito user interface will
extensively increase added business value of BK by enabling a
variety of innovative workflows for smooth and economical
developer cooperation.

Junio, the current maintainer of git "stupid content tracker",
will first be working on a gateway to import development
histories stored in git into BK.  This move adds value to BK by
freeing the data so far locked in git repositories and making
them available to the BK users.  He may later work on
reimplementing some parts of the git for BK, but it is expected
that there aren't that many.  For example, the "rename
detection" part is not necessary -- BK natively supports rename
tracking, which is a far superiour approach.

There currently is no plan for either of us to be working on the
conversion from BK to git.  There is no technical reason to do
so, and it does not make business sense for BitMover Inc.
either.

- 30 -
