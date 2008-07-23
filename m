From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 02/12] git-grep: support --no-external-grep
Date: Wed, 23 Jul 2008 21:01:30 +0200
Message-ID: <20080723190129.GM32184@machine.or.cz>
References: <20080723145744.GA29156@laptop> <20080723145718.GA29134@laptop> <20080723145603.GA29079@laptop> <20080723145549.GA29067@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguy???n =?iso-8859-2?Q?Th=E1i?= Ng???c Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:02:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjbb-0006Q8-Ic
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbYGWTBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754402AbYGWTBd
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:01:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47294 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754616AbYGWTBd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:01:33 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 12220393A530; Wed, 23 Jul 2008 21:01:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080723145744.GA29156@laptop> <20080723145718.GA29134@laptop> <20080723145603.GA29079@laptop> <20080723145549.GA29067@laptop>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89739>

  Hi,

  the patches 2, 3, 8 and 10 of your series introduce config options,
commandline switches and environment variables that are not documented
anywhere - can you please include documentation updates in your patch
series as well? It might be worth it to find some suitable place in the
documentation where to explain the concept itself; it took me quite
sometime before I actually realized (I think) what are your patches
about. (Which is also why is it useful to write cover letters for
patch series.)

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
