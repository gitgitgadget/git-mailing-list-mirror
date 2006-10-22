From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: prune/prune-packed
Date: Sat, 21 Oct 2006 23:59:19 -0400
Message-ID: <20061022035919.GA4420@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 22 05:59:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbUUg-0005rq-Qs
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 05:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422953AbWJVD7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 23:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422955AbWJVD7V
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 23:59:21 -0400
Received: from mail.fieldses.org ([66.93.2.214]:9377 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S1422953AbWJVD7V (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 23:59:21 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1GbUUZ-0001DX-W0
	for git@vger.kernel.org; Sat, 21 Oct 2006 23:59:20 -0400
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29708>

Both "man prune" and everyday.txt say that git-prune also runs
git-prune-packed.  But that doesn't seem to be true.  Is the bug in the
documentation?

--b.
