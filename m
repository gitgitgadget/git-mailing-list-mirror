From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: EGit is moving to eclipse.org
Date: Wed, 6 May 2009 00:05:33 +0200
Message-ID: <200905060005.33721.robin.rosenberg.lists@dewire.com>
References: <20090505182112.GF30527@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 06 00:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1Slq-0007i6-Ow
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 00:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbZEEWFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 18:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbZEEWFn
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 18:05:43 -0400
Received: from mail.dewire.com ([83.140.172.130]:2177 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbZEEWFm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 18:05:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 24C8F14927A0;
	Wed,  6 May 2009 00:05:36 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ykplOy8QwLho; Wed,  6 May 2009 00:05:35 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 22E6510231B8;
	Wed,  6 May 2009 00:05:35 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090505182112.GF30527@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118316>

tisdag 05 maj 2009 20:21:12 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> The EGit project has applied to join the Eclipse Foundation,
> and recently obtained approval[1] to become a subproject of the
> Technology top-level project.

\O/

> Consequently, in the near-ish future, we'll be moving at least some
> aspects of the EGit project onto eclipse.org.  This is a first step
> towards making the EGit team provider available as part of the base
> platform downloads, like the CVS team provider is today.
> 
> We're still trying to sort out everything, because eclipse.org only
> offers CVS and SVN code repositories... and we have a 1,601 commit
> history in Git that we'd like to preserve.  But we're starting
> to move.

Ah, that's easy. svn add .git  That way it is formally tracked in SVN :D

> Thanks to Robin for doing the bulk of the initial drafts on the
> project proposal, without his effort we wouldn't have gotten
> this far.

Philippe Ombredanne helped out a lot

-- robin
