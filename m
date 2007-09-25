From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Remove 'submodules' from the TODO section of the User
	Manual.
Date: Tue, 25 Sep 2007 16:13:06 -0400
Message-ID: <20070925201306.GW30845@fieldses.org>
References: <20070925191159.GG18370@genesis.frugalware.org> <20070925192315.GR30845@fieldses.org> <20070925194745.GI18370@genesis.frugalware.org> <20070925194936.GU30845@fieldses.org> <20070925195731.GJ18370@genesis.frugalware.org> <20070925200252.GV30845@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 22:13:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaGmr-000529-TY
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 22:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbXIYUNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 16:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753078AbXIYUNe
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 16:13:34 -0400
Received: from mail.fieldses.org ([66.93.2.214]:33344 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbXIYUNe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 16:13:34 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IaGmI-0004Ml-7L; Tue, 25 Sep 2007 16:13:06 -0400
Content-Disposition: inline
In-Reply-To: <20070925200252.GV30845@fieldses.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59168>

On Tue, Sep 25, 2007 at 04:02:52PM -0400, bfields wrote:
> I think we should try to keep the git documentation mostly confined to
> tools that are distributed with git itself.  So it might be worth a few
> words just to mention the existance of tailor and how it compares to
> other tools, but I'd leave it at that.

So in fact it might be that what's needed isn't any new documentation on
the available tools with their features and limitations.

I know that when I recently had to deal with a svn tree the hardest part
was figuring out where to start (git-svn?  git-svnimport?).  I seem to
recall threads here suggesting this is a general problem.

One exception--the "series of tarballs" thing--I think it's cool that
you can just unpack a bunch of tarballs and string them together into a
git history.  It gives a good sense of how git works, and I don't think
it's documented explicitly anywhere.  I think that might be kinda fun to
write up.  But I haven't tried.

--b.
