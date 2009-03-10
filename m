From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [GSoC] Google Summer of Code 2009 - new ideas
Date: Mon, 9 Mar 2009 17:49:35 -0700
Message-ID: <20090310004935.GM11989@spearce.org>
References: <200903070144.17457.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 01:51:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgqBV-00066t-0r
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 01:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbZCJAth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 20:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbZCJAth
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 20:49:37 -0400
Received: from george.spearce.org ([209.20.77.23]:52640 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbZCJAtg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 20:49:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3D38838211; Tue, 10 Mar 2009 00:49:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200903070144.17457.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112773>

Jakub Narebski <jnareb@gmail.com> wrote:
> I'd like to add a few ideas to SoC2009Ideas wiki page, but before I do 
> this I'd like to ask for comments.  (The proposals also lacks proposed 
> mentor).
> 
> I am wondering if it would be worth it to make a separate class between 
> "New to Git?" easy tasks, and "Larger Projects" hard tasks...

Done, there is now a "Medium" category.  Folks should start to
repaint the bikeshed if they disagre with my current choices
in colors.
 
> BTW. some of ideas didn't make it from SoC2008Ideas wiki page to current 
> year page, namely: 
>  * Apply sparse To Fix Errors
>  * Lazy clone / remote alternates
>  * Implement git-submodule using .gitlink file
>  * Teach git-apply the 3-way merge fallback git-am knows
>  * Better Emacs integration
> Was this ommision deliberate or accidental?

Accidental.  Most have been added back.  Of note I did not add back
the emacs integration as we have multiple emacs packages.
 
-- 
Shawn.
