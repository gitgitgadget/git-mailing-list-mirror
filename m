From: jidanni@jidanni.org
Subject: bug#1571: only one word about git in (info "(emacs)Version Control")
Date: Tue, 16 Dec 2008 00:15:50 +0800
Message-ID: <87r649za6h.fsf__46395.8336775706$1229499776$gmane$org@jidanni.org>
Reply-To: jidanni@jidanni.org, 1571@emacsbugs.donarmstrong.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: bug-gnu-emacs@gnu.org
X-From: git-owner@vger.kernel.org Wed Dec 17 08:42:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCr3P-0001ab-Ga
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 08:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757603AbYLQHl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 02:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756824AbYLQHl3
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 02:41:29 -0500
Received: from rzlab.ucr.edu ([138.23.92.77]:60818 "EHLO rzlab.ucr.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745AbYLQHl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 02:41:27 -0500
X-Greylist: delayed 1012 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Dec 2008 02:41:27 EST
Received: from rzlab.ucr.edu (rzlab.ucr.edu [127.0.0.1])
	by rzlab.ucr.edu (8.13.8/8.13.8/Debian-3) with ESMTP id mBH7OJGK014034;
	Tue, 16 Dec 2008 23:24:33 -0800
Received: (from debbugs@localhost)
	by rzlab.ucr.edu (8.13.8/8.13.8/Submit) id mBH6MG3P027212;
	Tue, 16 Dec 2008 22:22:16 -0800
X-Loop: don@donarmstrong.com
X-Emacs-PR-Message: report 1571
X-Emacs-PR-Package: emacs
X-Emacs-PR-Keywords: 
Received: via spool by submit@emacsbugs.donarmstrong.com id=B.12293624027814
          (code B ref -1); Wed, 17 Dec 2008 06:22:14 +0000
Received: (at submit) by emacsbugs.donarmstrong.com; 15 Dec 2008 17:33:22 +0000
X-Spam-Checker-Version: SpamAssassin 3.2.3-bugs.debian.org_2005_01_02
	(2007-08-08) on rzlab.ucr.edu
X-Spam-Level: 
X-Spam-Bayes: score:0.5 Bayes not run. spammytokens:Tokens not available.
	hammytokens:Tokens not available.
X-Spam-Status: No, score=-3.0 required=4.0 tests=X_DEBBUGS_CC autolearn=ham
	version=3.2.3-bugs.debian.org_2005_01_02
Received: from lists.gnu.org (lists.gnu.org [199.232.76.165])
	by rzlab.ucr.edu (8.13.8/8.13.8/Debian-3) with ESMTP id mBFHXJNZ007803
	for <submit@emacsbugs.donarmstrong.com>; Mon, 15 Dec 2008 09:33:20 -0800
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1LCHJm-0006Ib-WB
	for bug-gnu-emacs@gnu.org; Mon, 15 Dec 2008 12:33:19 -0500
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1LCHJl-0006HG-KB
	for bug-gnu-emacs@gnu.org; Mon, 15 Dec 2008 12:33:17 -0500
Received: from [199.232.76.173] (port=39849 helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1LCHJl-0006Gu-8E
	for bug-gnu-emacs@gnu.org; Mon, 15 Dec 2008 12:33:17 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:53196 helo=homiemail-a2.g.dreamhost.com)
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <jidanni@jidanni.org>)
	id 1LCHJl-0000av-0Z
	for bug-gnu-emacs@gnu.org; Mon, 15 Dec 2008 12:33:17 -0500
Received: from jidanni2.jidanni.org (122-127-35-251.dynamic.hinet.net [122.127.35.251])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 76E2BD273D
	for <bug-gnu-emacs@gnu.org>; Mon, 15 Dec 2008 09:33:15 -0800 (PST)
X-detected-operating-system: by monty-python.gnu.org: GNU/Linux 2.6 (newer, 1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103310>

In (info "(emacs)Version Control") there is literally only one word
about git, on (info "(emacs)Customizing VC"). Somebody who has used
git for more than a few minutes should add something.
emacs-version "22.2.1"
(I added X-Debbugs-CC: git@vger.kernel.org (lest I use a real CC
causing bug number escalation), but it seems the git list filters
things coming in from the side.)
