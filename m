From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ANNOUCNE] repo - The Multiple Git Repository Tool
Date: Wed, 22 Oct 2008 14:16:05 -0700
Message-ID: <20081022211605.GX14786@spearce.org>
References: <20081022154245.GT14786@spearce.org> <ee2a733e0810221255u23aabef2i66d878bcbfa11816@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 23:17:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksl5U-0001UL-5a
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 23:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYJVVQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 17:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbYJVVQJ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 17:16:09 -0400
Received: from george.spearce.org ([209.20.77.23]:50388 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbYJVVQI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 17:16:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5CCB73835F; Wed, 22 Oct 2008 21:16:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <ee2a733e0810221255u23aabef2i66d878bcbfa11816@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98914>

Leo Razoumov <slonik.az@gmail.com> wrote:
> On 10/22/08, Shawn O. Pearce <spearce@spearce.org> wrote:
> >
> >  Google developed two tools, repo and Gerrit, and open sourced them
> >  under the Apache License:
> >
> >   http://android.git.kernel.org/?p=tools/repo.git
> >   http://android.git.kernel.org/?p=tools/gerrit.git
> >
> >   git://android.git.kernel.org/tools/repo.git
> >   git://android.git.kernel.org/tools/gerrit.git
> >
> >  repo is a Python application to bind together Git repositories,
> >  something like "git submodule",
> 
> Are there any plans to make repo an official git command (e.g.
> git-repo) or merge its functionality with git-submodule?

I currently do not plan on asking Junio to consider making repo part
of git.  However, I am also not adverse to it if repo development
slows down and there is sufficient community interest.

-- 
Shawn.
