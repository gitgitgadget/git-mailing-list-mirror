From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 0/5] jgit diff
Date: Thu, 1 Oct 2009 11:47:21 -0700
Message-ID: <20091001184721.GR14660@spearce.org>
References: <alpine.DEB.1.00.0909030846230.8306@pacific.mpi-cbg.de> <cover.1251974493u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 01 20:47:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtQgZ-0004SK-AR
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 20:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050AbZJASrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 14:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755694AbZJASrR
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 14:47:17 -0400
Received: from george.spearce.org ([209.20.77.23]:57849 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758AbZJASrR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 14:47:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6DD06381FE; Thu,  1 Oct 2009 18:47:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <cover.1251974493u.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129407>

Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> This patch series provides a rudimentary, working implementation of "jgit 
> diff".  It does not provide all modes of "git diff" -- by far! -- but it 
> is robust, and should provide a good starting point for further work.

I have rebased this patch series on our new JGit history, and then
opened a bug at eclipse.org to get it through the IP review process:

  https://bugs.eclipse.org/bugs/show_bug.cgi?id=291083
 
-- 
Shawn.
