From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is
	possible to create hardlinks for directories as root under solaris)
Date: Wed, 18 Jul 2007 10:50:55 +0200
Message-ID: <20070718085055.GL25037@cip.informatik.uni-erlangen.de>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716133602.GB26675@cip.informatik.uni-erlangen.de> <alpine.LFD.0.999.0707161001300.20061@woody.linux-foundation.org> <alpine.LFD.0.999.0707161004550.20061@woody.linux-foundation.org> <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716133602.GB26675@cip.informatik.uni-erlangen.de> <alpine.LFD.0.999.0707161001300.20061@woody.linux-foundation.org> <20070716171732.GE6134@cip.informatik.uni-erlangen.de> <20070716180910.GB16878@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 10:51:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB5FL-0000Xo-Sh
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 10:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbXGRIu5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 04:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbXGRIu5
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 04:50:57 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49218 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752709AbXGRIu4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 04:50:56 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id ABF583F430; Wed, 18 Jul 2007 10:50:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070716180910.GB16878@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52844>

Hello,

> > I asked the UFS maintainer to reconsider to fix this.

> the bug is filed.

http://bugs.opensolaris.org/view_bug.do?bug_id=6581318

	Thomas
