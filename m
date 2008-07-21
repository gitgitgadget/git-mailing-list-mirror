From: Petr Baudis <pasky@suse.cz>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008
	projects?
Date: Mon, 21 Jul 2008 12:40:32 +0200
Message-ID: <20080721104032.GI32184@machine.or.cz>
References: <200807080227.43515.jnareb@gmail.com> <200807210029.31543.jnareb@gmail.com> <1216601739.6523.48.camel@maia.lan> <200807211223.45707.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org,
	Joshua Roys <roysjosh@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 12:41:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKspj-0003z7-4Z
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 12:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757539AbYGUKkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 06:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757559AbYGUKkf
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 06:40:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54683 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755769AbYGUKke (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 06:40:34 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id A9CFD393B308; Mon, 21 Jul 2008 12:40:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807211223.45707.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89336>

On Mon, Jul 21, 2008 at 12:23:45PM +0200, Jakub Narebski wrote:
> [*1*] "the current implementation is quite slow (requiring two calls to
> 'git-cat-file' for each object)" <-- why you don't use '--batch' or
> '--batch-check' options to git cat file: see also Git::Repo and friends
> implementation send by Lea Wiemann to git mailing list as part of
> "Gitweb caching" project?  BTW. by keeping discussion off the list,
> you are off the knowledge of git community, too.

I concur. Only now I realized that this project might be an important
Git Perl API user. Can you please reconsider having a separate mailing
list for discussions etc.? The traffic seems to be very low anyway, and
I'm not sure what benefits does it actually have at all.

				Petr "Pasky" Baudis
