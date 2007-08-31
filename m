From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] git/gitweb.git repository
Date: Fri, 31 Aug 2007 02:01:49 +0200
Message-ID: <20070831000149.GK1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com, ltuikov@yahoo.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 02:01:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQtxU-0006VJ-6N
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 02:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521AbXHaABv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 20:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756179AbXHaABv
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 20:01:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41141 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755974AbXHaABu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 20:01:50 -0400
Received: (qmail 23895 invoked by uid 2001); 31 Aug 2007 02:01:49 +0200
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57096>

  Hi,

  due to popular (Junio's) demand, I have set up a gitweb-oriented fork
of git at repo.or.cz:

	http://repo.or.cz/w/git/gitweb.git

  It is meant as a hub for various gitweb-related patches and
development efforts. So far it is pre-seeded by the patches repo.or.cz's
gitweb uses. It is divided to three main branches (StGIT patchstacks in
reality), where master is what Junio is gonna pull to git's master.

  Please feel encouraged to make random forks for your development
efforts, or push your random patches (preferrably just bugfixes,
something possibly controversial should be kept in safe containment like
a fork or separate branch) to the mob branch.

  Have fun,

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
