From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Summer of Code 2008 project application draft: Pack v4
Date: Sat, 29 Mar 2008 21:50:46 +0100
Message-ID: <20080329205046.GA27926@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 21:58:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jfi7v-00047e-JU
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 21:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbYC2U5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 16:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbYC2U5a
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 16:57:30 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:59247 "HELO bohr.gbar.dtu.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754363AbYC2U53 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 16:57:29 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Mar 2008 16:57:28 EDT
Received: (qmail 28287 invoked by uid 5842); 29 Mar 2008 21:50:46 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78481>

Dear Git community,

Here is a draft of my application for the Google Summer of Code 2008.  I
am aware, that this is a big project, so how might the scope be limited,
so that the work is still useful to build on top of? How about just
rebasing the patches already in the sp/pack4 branch in the
fastimport.git repository?

The application text goes like this:

"
The project goal is to rebase the code and ideas developed for the
version 4 of the git pack format, which showed good promise of making
packs smaller, and faster.

The ideas of a new even more optimized pack format has been floating
around the git world for almost two years, and because of the rapid pace
of development the code implementing those ideas has become less, and
less ready for inclusion in mainline.

Since those patches touch so many of the core functions in git, it will
be a good chunk of work getting them mergeable, and nobody has gotten
around to doing that yet. This will be a good oppertunity for laying the
ground work, and getting the ball rolling again.

This project will not only benefit Git itself, but also the nummerous
projects, and developers using Git as their prefered revision control
system, among them many prominent open source and free software
projects.


About me:
I have been following the development of Git on and of almost from the
beginning, and have been trying to learn from its design, and
implementation, and especially I have been interested in implementation
of the git repository, index, and pack format. I have contributed a few
general clean-up patches, but I have not yet had the chance (read time)
to really dive in, and make a significant, and non-trivial contribution,
although I would have liked to.
"

Comments?

Regards,

Peter
