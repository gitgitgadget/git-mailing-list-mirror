From: Petr Baudis <pasky@suse.cz>
Subject: Re: Q: How to tag individual files
Date: Sun, 13 Jul 2008 12:20:47 +0200
Message-ID: <20080713102047.GH32184@machine.or.cz>
References: <g5bvte$52j$1@ger.gmane.org> <20080713053537.GA32746@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Poojan Wagh <poojanwagh@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 13 12:24:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHyky-0005ao-VP
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 12:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbYGMKUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 06:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbYGMKUu
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 06:20:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33155 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbYGMKUt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 06:20:49 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id AB31E393B31E; Sun, 13 Jul 2008 12:20:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080713053537.GA32746@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88295>

  Hi,

On Sun, Jul 13, 2008 at 05:35:37AM +0000, Shawn O. Pearce wrote:
> Poojan Wagh <poojanwagh@gmail.com> wrote:
> > The crash course at: http://git.or.cz/course/svn.html says:
> >
> >> You usually tag commits but if you want, you can tag files (or trees, 
> >> but that's a bit low-level) as well. 
> >
> > I've done a bit of searching, and I can't for the life of me figure out  
> > how to tag an individual file. Help from the group would be much  
> > appreciated. Thanks.
..snip..
> So you can't tag individual files.  The comment is a bit misleading
> and gets far too low-level for an otherwise high-level conversion
> guide.

  I have tried to make this less misleading, thanks for noticing. I kept
the mention, though, because I think people should not be misled to
thinking that only commits are tagged, and then get confused when they
first meet v2.6.11.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
