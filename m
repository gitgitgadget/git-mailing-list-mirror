From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Deciding between Git/Mercurial
Date: Wed, 30 Sep 2009 18:05:58 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909301752450.14907@iabervon.org>
References: <h9nlhj$heq$1@ger.gmane.org> <4AC33C56.8060202@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: newsgroups@catchall.shelter13.net, git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 01 00:06:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt7Jn-0002t3-4T
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 00:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844AbZI3WF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 18:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754784AbZI3WF4
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 18:05:56 -0400
Received: from iabervon.org ([66.92.72.58]:48278 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099AbZI3WFz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 18:05:55 -0400
Received: (qmail 28855 invoked by uid 1000); 30 Sep 2009 22:05:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Sep 2009 22:05:58 -0000
In-Reply-To: <4AC33C56.8060202@gmx.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129362>

On Wed, 30 Sep 2009, Matthias Andree wrote:

> Anteru schrieb:
> 
> > First of all, what's the matter with git and Windows, is there some
> > long-term commitment to make git work on Windows as well as on Linux?
> > I'm using msysgit on Windows, and personally I'm happy with it, but my
> > co-workers constantly nag that Mercurial has superior portability ...
> 
> That tale is told all over, but that doesn't make it truer. I've never had
> issues getting a Cygwin version of git to work properly (haven't tried the
> msysgit or jgit variants, never felt the need), and integration went smooth.

Git works fine under Windows for people who use Cygwin. Portability to 
Windows is more about working for users who don't use a shell of any sort 
or the "Run..." dialog. I don't know how Mercurial does on that metric, 
anyway, but it's a lot more meaningful that the question of whether the 
software works in your POSIX environment when the underlying kernel is not 
very suitable.

	-Daniel
*This .sig left intentionally blank*
