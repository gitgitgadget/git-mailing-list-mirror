From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: jgit and ignore
Date: Sat, 28 Feb 2009 09:26:22 -0800
Message-ID: <20090228172622.GC26689@spearce.org>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 18:27:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdSyf-000364-3F
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 18:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbZB1R0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 12:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbZB1R0Z
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 12:26:25 -0500
Received: from george.spearce.org ([209.20.77.23]:39777 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbZB1R0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 12:26:24 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id BFED438210; Sat, 28 Feb 2009 17:26:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111777>

Jon Smirl <jonsmirl@gmail.com> wrote:
> I'm using jgit in eclipse. Works great for me.
 
Yay!

> I have a couple of generated files in my working directory. There
> doesn't seem to be any UI for ignoring them. Is it there and I just
> can't find it?

EGit doesn't (yet) honor the .gitignore files like it should. Someone
(Ferry i-forget-the-rest-of-his-name) is working on adding ignore
support and has patches in flight for at least some of it.

-- 
Shawn.
