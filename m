From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [PATCH] Documentation/git-submodule.txt: Further clarify the description
Date: Thu, 17 Jul 2008 16:37:29 +0300
Message-ID: <20080717133729.GF4379@zakalwe.fi>
References: <20080717121813.GC10151@machine.or.cz> <20080717122911.32334.73465.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: gitster@pobox.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 17 15:38:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJTgk-0001XZ-Es
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 15:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916AbYGQNhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 09:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754718AbYGQNhb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 09:37:31 -0400
Received: from zakalwe.fi ([80.83.5.154]:57749 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754195AbYGQNha (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 09:37:30 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 127242BC39; Thu, 17 Jul 2008 16:37:29 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20080717122911.32334.73465.stgit@localhost>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88850>

On Thu, Jul 17, 2008 at 02:29:20PM +0200, Petr Baudis wrote:
> +Submodules allow foreign repositories to be embedded within a dedicated
> +subdirectory of the source tree, always pointed at a particular commit.
> +They are not to be confused with remotes, which are meant mainly for branches
> +of the same project; submodules are meant for different projects you would like
> +to make part of your source tree, while the history of the two projects still
> +stays completely independent and you cannot modify the contents of the
> +submodule from within the main project.

That is nice, thanks!

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
