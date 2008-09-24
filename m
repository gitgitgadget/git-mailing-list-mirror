From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: A note from the interim Git maintainer
Date: Wed, 24 Sep 2008 08:46:32 -0700
Message-ID: <20080924154632.GR3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 17:48:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiWak-0007QQ-FN
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 17:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbYIXPqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 11:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbYIXPqd
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 11:46:33 -0400
Received: from george.spearce.org ([209.20.77.23]:42338 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbYIXPqd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 11:46:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 64AF038360; Wed, 24 Sep 2008 15:46:32 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96653>

As mentioned recently by Junio, Junio is away on family leave and
a much deserved vacation until ~Oct 6th.  Until he gets back I am
offering up my services as patch monkey to keep us moving along.

My tree is being published here:

  git:    git://repo.or.cz/git/spearce.git
		  repo.or.cz/srv/git/git/spearce.git
          http://repo.or.cz/r/git/spearce.git

  gitweb: http://repo.or.cz/w/git/spearce.git


The usual maint/master/next/pu stuff applies.  I'm basically just
picking up from where Junio left off.

I would appreciate it if anyone who normally tracks Junio's "next"
or "master" branch for their production work can switch over to my
next (or master) branch for the next few weeks.  Something about
many eyeballs and fewer bugs.

Patches can be CC'd to me, or just sent to the list.  If I have
dropped something, please feel free to give me a gentle prod.

I know that I am quite behind on git-gui patches. I think I'm going
to spend the better part of today just on Git to get everything
caught up.

-- 
Shawn.
