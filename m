From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] perl/Git.pm: add parse_rev method
Date: Fri, 30 May 2008 23:05:31 +0200
Message-ID: <20080530210531.GH18781@machine.or.cz>
References: <20080530095047.GD18781@machine.or.cz> <1212179270-26170-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 23:06:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Bnw-0007tV-I8
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 23:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbYE3VFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 17:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbYE3VFg
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 17:05:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49676 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753269AbYE3VFf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 17:05:35 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id A781E1E4C030; Fri, 30 May 2008 23:05:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1212179270-26170-1-git-send-email-LeWiemann@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83335>

On Fri, May 30, 2008 at 10:27:50PM +0200, Lea Wiemann wrote:
> The parse_rev method takes a revision name and returns a SHA1 hash,
> like the git-rev-parse command.
> 
> Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>

Nice, this looks quite sane!

Acked-by: Petr Baudis <pasky@suse.cz>

				Petr "Pasky" Baudis
