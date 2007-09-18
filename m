From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [rfc] git submodules howto
Date: Tue, 18 Sep 2007 11:55:29 -0400
Message-ID: <20070918155529.GD18476@fieldses.org>
References: <20070918105538.GL19019@genesis.frugalware.org> <20070918132940.GC12120@fieldses.org> <20070918154734.GP19019@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 17:56:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXfQI-0006Jb-0w
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 17:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760004AbXIRPzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 11:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759040AbXIRPzc
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 11:55:32 -0400
Received: from mail.fieldses.org ([66.93.2.214]:46785 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758999AbXIRPzb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 11:55:31 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IXfQ9-0005zN-6H; Tue, 18 Sep 2007 11:55:29 -0400
Content-Disposition: inline
In-Reply-To: <20070918154734.GP19019@genesis.frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58624>

On Tue, Sep 18, 2007 at 05:47:34PM +0200, Miklos Vajna wrote:
> On Tue, Sep 18, 2007 at 09:29:40AM -0400, "J. Bruce Fields" <bfields@fieldses.org> wrote:
> > > 2) does this worth adding to the documentation? maybe to a .txt under
> > > Documentation/howto? or to git-submodule.txt?
> > 
> > Could you add it as a new chapter to user-manual.txt (probably just
> > after the "git concepts" chapter), and then add links to that chapter
> > from git-submodule(1) and gitmodules(5)?
> 
> hm, i did not know about the wiki page Michael created yesterday. so i
> don't know what's the rule in case: if something is already in the wiki
> then should or should not it be added to the 'official docs'?

It should.  We also need submodules documentation for the "official"
documentation.

If you want to base that work off of that wiki page instead of your
original email, that's fine.  Just make sure you get Michael's
permission first.

--b.
