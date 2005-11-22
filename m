From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: 2.6.15-rc2 tag
Date: Tue, 22 Nov 2005 14:34:18 -0500
Message-ID: <20051122193418.GC5628@fieldses.org>
References: <20051121212549.GA23213@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 22 20:36:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeduJ-0007W4-D2
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 20:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbVKVTeU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 14:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbVKVTeU
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 14:34:20 -0500
Received: from mail.fieldses.org ([66.93.2.214]:12241 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S965145AbVKVTeT
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 14:34:19 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.54)
	id 1EeduE-00026s-AI
	for git@vger.kernel.org; Tue, 22 Nov 2005 14:34:18 -0500
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051121212549.GA23213@fieldses.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12569>

I'm still not getting a 2.6.15-rc2 tag with either git-clone or
git-fetch --tags.  Any ideas?  Is the problem with me or with the
repository?

--b.

On Mon, Nov 21, 2005 at 04:25:49PM -0500, J. Bruce Fields wrote:
> Help!  I'm confused.
> 
> 	git-fetch --tags http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> isn't getting me a 2.6.15-rc2 tag.  So maybe there's some delay?  There
> does, however, appear to be a file
> 
> 	http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/tags/v2.6.15-rc2
> 
> Its contents are 7305b5cb045e2c71250b5b7472771ed2620bc514 which isn't
> anything I can find anywhere.
> 
> gitweb, on the other hand:
> 
> 	http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tag;h=7305b5cb045e2c71250b5b7472771ed2620bc514
> 
> shows 3bedff1d73b86e0cf52634efb447e9ada08f2cc6 as the tagged commit,
> which is something I do have.  What don't I understand?
> 
> --b.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
