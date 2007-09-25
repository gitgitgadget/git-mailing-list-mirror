From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Remove 'submodules' from the TODO section of the User
	Manual.
Date: Tue, 25 Sep 2007 16:02:52 -0400
Message-ID: <20070925200252.GV30845@fieldses.org>
References: <20070925191159.GG18370@genesis.frugalware.org> <20070925192315.GR30845@fieldses.org> <20070925194745.GI18370@genesis.frugalware.org> <20070925194936.GU30845@fieldses.org> <20070925195731.GJ18370@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 22:03:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaGct-00018u-G4
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 22:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbXIYUDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 16:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbXIYUDN
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 16:03:13 -0400
Received: from mail.fieldses.org ([66.93.2.214]:49777 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799AbXIYUDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 16:03:09 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IaGcO-0004Cu-EX; Tue, 25 Sep 2007 16:02:52 -0400
Content-Disposition: inline
In-Reply-To: <20070925195731.GJ18370@genesis.frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59167>

On Tue, Sep 25, 2007 at 09:57:31PM +0200, Miklos Vajna wrote:
> i was this in the todo:
> 
> "Add a section on working with other version control systems, including
> CVS, Subversion, and just imports of series of release tarballs."
> 
> to questions:
> 
> 1) does this include documentation about git-svn? i mean a howto similar
> to the submodules chapter.

Could be.  Though when I used it I thought the git-svn manpage was
actually very good, so I'd be tempted to just point to that.

> 2) does it worth to document a typical usage of tailor? we used it a lot
> when converting from darcs to git and once you figure out the right
> options, it's really easy to use it. but maybe it's unrelated.

I think we should try to keep the git documentation mostly confined to
tools that are distributed with git itself.  So it might be worth a few
words just to mention the existance of tailor and how it compares to
other tools, but I'd leave it at that.

--b.
