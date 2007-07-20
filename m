From: Karl Fogel <kfogel@red-bean.com>
Subject: Re: CVS -> SVN -> Git
Followup-To: gmane.comp.version-control.subversion.cvs2svn.devel
Date: Thu, 19 Jul 2007 20:51:28 -0700
Message-ID: <87tzrzivgf.fsf@red-bean.com>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
	<469804B4.1040509@alum.mit.edu>
	<46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>
	<4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com>
	<46994BDF.6050803@alum.mit.edu> <20070715013949.GA20850@thyrsus.com>
	<46a038f90707151805j454b57fbvb4d7ed526e1e64ce@mail.gmail.com>
	<469F52BF.8050300@bluegap.ch>
Reply-To: Karl Fogel <kfogel@red-bean.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, esr@thyrsus.com,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, dev <dev@cvs2svn.tigris.org>
To: Markus Schiltknecht <markus@bluegap.ch>
X-From: git-owner@vger.kernel.org Thu Jul 19 20:51:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBb6E-0002HL-5J
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 20:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbXGSSvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 14:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbXGSSvh
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 14:51:37 -0400
Received: from Sanpietro.red-bean.com ([66.146.193.61]:48188 "EHLO
	sanpietro.red-bean.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbXGSSvg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 14:51:36 -0400
Received: from localhost ([127.0.0.1]:52557)
	by sanpietro.red-bean.com with esmtp (Exim 4.63)
	(envelope-from <kfogel@red-bean.com>)
	id 1IBb66-0000Ih-PO; Thu, 19 Jul 2007 13:51:35 -0500
Mail-followup-to: dev@cvs2svn.tigris.org
In-Reply-To: <469F52BF.8050300@bluegap.ch> (Markus Schiltknecht's message of "Thu\, 19 Jul 2007 14\:02\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53019>

Markus Schiltknecht <markus@bluegap.ch> writes:
> Sure, we certainly need a meta format of some sort (not a full blown
> VCS, agreed, but somehow we need to represent commits, tags and
> branches). And IMO, the subversion based format is not a good one,
> because it treats branches and tags very different from most other
> systems (and from what it should be from a users perspective: an
> atomic operation).

Huh?  I don't understand what you're saying about atomicity here.
