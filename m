From: LordSmoke <dslice@morphometrics.org>
Subject: Sharing nested subparts of large repository?
Date: Sun, 25 Mar 2012 09:38:22 -0700 (PDT)
Message-ID: <1332693502389-7403743.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 18:38:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBqSm-0004sc-8i
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 18:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756597Ab2CYQiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 12:38:23 -0400
Received: from sam.nabble.com ([216.139.236.26]:49318 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756589Ab2CYQiW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 12:38:22 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <dslice@morphometrics.org>)
	id 1SBqSU-00073s-G7
	for git@vger.kernel.org; Sun, 25 Mar 2012 09:38:22 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193872>

I've been using git for a couple of months to get used to the system. Basic
stuff - a few larger project repositories in unique directories, commits,
pushes to a remote repository. Mostly as a kind of backup system.

However, my ultimate goal is to share part of one large project currently
being managed with git with my developers. I want them to have access to
source code and test data, but not my manuscripts, correspondence, whatever.

I also want to make a portion of what I will give my developers available as
open source, e.g., on github, but not all of it. Just the stable,
non-developmental parts. NOT the our development stuff and not the parts
being used for private contracts.

Submodules seem promising, but the examples are not quite what I am looking
for, as far as I can tell. They talk about isolating submodules that depend
on a larger project. I want to make available the larger project while
keeping nested submodules (so to speak) private.

Would someone point me in the right direction to achieve my goals?

TIA


--
View this message in context: http://git.661346.n2.nabble.com/Sharing-nested-subparts-of-large-repository-tp7403743p7403743.html
Sent from the git mailing list archive at Nabble.com.
