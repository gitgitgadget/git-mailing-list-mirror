From: Theodore Tso <tytso@mit.edu>
Subject: Re: question concerning branches
Date: Thu, 20 Aug 2009 13:37:14 -0400
Message-ID: <20090820173714.GD7076@mit.edu>
References: <m33a7noc3u.fsf@localhost.localdomain> <4a8c51f5@wupperonline.de> <20090819203917.GH27206@mit.edu> <200908192257.23347.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Brueckl <ib@wupperonline.de>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 19:37:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeBZq-0001sw-4m
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 19:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbZHTRhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 13:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbZHTRhU
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 13:37:20 -0400
Received: from thunk.org ([69.25.196.29]:58897 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbZHTRhT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 13:37:19 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1MeBZc-00072N-Px; Thu, 20 Aug 2009 13:37:16 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1MeBZa-0002yn-DA; Thu, 20 Aug 2009 13:37:14 -0400
Content-Disposition: inline
In-Reply-To: <200908192257.23347.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126649>

On Wed, Aug 19, 2009 at 10:57:21PM +0200, Jakub Narebski wrote:
> Errr... you are aware that you can use "git stash save <message>" (i.e. 
> specify commit message for stash; well, the subject), don't you?

I wasn't aware, but usually I like leaving more notes to myself than
just a single lines' worth of state.  I should probably take another
look at "git stash" and see if it's a handy tool for me to use; but so
far I've been happy enough with "git checkout -b topic-name; git
commit".

						- Ted
