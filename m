From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 00:20:09 +0200
Message-ID: <20060629222009.GA9310@cip.informatik.uni-erlangen.de>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx> <20060625184757.f8273820.tihirvon@gmail.com> <E1FuX8l-0001H5-2z@moooo.ath.cx> <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de> <E1FueYh-0004XE-Fg@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 30 00:20:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw4ry-0007uH-4s
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 00:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933056AbWF2WUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 18:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933052AbWF2WUN
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 18:20:13 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:11507 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S933056AbWF2WUL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 18:20:11 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id CE7E230FCE; Fri, 30 Jun 2006 00:20:09 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <E1FueYh-0004XE-Fg@moooo.ath.cx>
User-Agent: Mutt/1.5.11-2006-06-13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22919>

Hello,

> *AND* more than one pattern. (something I miss in normal grep)

so do I, is it possible to use git-grep outside of git for files that
are not in a repository? Or are there any grep implementations available
which bring this feature to me?

        Thomas
