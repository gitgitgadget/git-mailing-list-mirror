From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH (GITK,GIT-GUI,DOCS) 3/7] git-gui: Support starting gitk
	from Gui Blame
Date: Sun, 24 Aug 2008 22:06:14 -0700
Message-ID: <20080825050614.GC19127@spearce.org>
References: <200808231225.12596.angavrilov@gmail.com> <200808231230.00397.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 07:07:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXUIb-0004Al-KJ
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 07:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbYHYFGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 01:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbYHYFGP
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 01:06:15 -0400
Received: from george.spearce.org ([209.20.77.23]:37308 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbYHYFGP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 01:06:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9736D38375; Mon, 25 Aug 2008 05:06:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200808231230.00397.angavrilov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93595>

Alexander Gavrilov <angavrilov@gmail.com> wrote:
> Add a context menu command to load commits
> that are within a certain time range from the
> selected commit into gitk.
> 
> It can be useful for understanding of the code,
> especially if the repository is imported from
> a VCS that does not support atomic commits.

The git-gui part of this series is now staged in my pu branch.
If Paul is going to also apply this to gitk we can ship it in
the next feature release of Git (1.6.1).

-- 
Shawn.
