From: Adam Spiers <git@adamspiers.org>
Subject: Re: prevent gitk collapsing tree view when viewing a different
 commit?
Date: Thu, 19 Dec 2013 19:04:01 +0000
Message-ID: <20131219190401.GF23496@pacific.linksys.moosehall>
References: <20131219151507.GC23496@pacific.linksys.moosehall>
 <52B341A7.8050803@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 20:04:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtitg-0006IP-Nf
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 20:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984Ab3LSTE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 14:04:27 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45728 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab3LSTED (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 14:04:03 -0500
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id B512F2E30D
	for <git@vger.kernel.org>; Thu, 19 Dec 2013 19:04:01 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <52B341A7.8050803@xiplink.com>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239534>

On Thu, Dec 19, 2013 at 01:57:43PM -0500, Marc Branchaud wrote:
> On 13-12-19 10:15 AM, Adam Spiers wrote:
> > If I launch gitk, switch the lower right pane from Patch view mode to
> > Tree view, expand a few directories, and then changing to viewing a
> > different commit, the tree automatically collapses again.  This is
> > really annoying when trying to view changes to the tree structure over
> > time; is there any way to stop it, or would it be an easy tweak to the
> > code for someone familiar with it?  I had a look at the code but could
> > hardly understand any of it :-/
> 
> What I would really like is that if I have a file selected in Patch view,
> then that file is displayed when I switch to Tree view, and vice-versa.

Yes, that would be fantastic!

> Unfortunately such a change is beyond my Tcl skills.

Mine too :-/
