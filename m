From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Git User's Survey 2008
Date: Wed, 23 Jul 2008 23:44:33 +0200
Message-ID: <20080723214433.GO32184@machine.or.cz>
References: <200807230325.04184.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:45:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLm9S-0005SG-KZ
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847AbYGWVoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754555AbYGWVoh
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:44:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34828 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830AbYGWVoh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:44:37 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id C9CC1393A36E; Wed, 23 Jul 2008 23:44:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807230325.04184.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89783>

On Wed, Jul 23, 2008 at 03:25:03AM +0200, Jakub Narebski wrote:
>    18. Which (main) git web interface do you use for your projects?
>        (zero or more: multiple choice)
>      - gitweb, cgit, wit (Ruby), git-php, viewgit (PHP), other
>      + should there be a question about web server (Apache, IIS, ...)
>        used to host git web interface?
>    18b.If you selected "other web interface", what it was?
>        (free form)

I think many people "just use GitHub", or repo.or.cz, or Gitorious; for
GitHub or Gitorious, there's even no good answer to the question above.
So I would either make a separate question for these or include them in
the list above.

>    19. How do you publish/propagate your changes?
>        (zero or more: multiple choice)
>      - push, pull request, format-patch + email, bundle, other

I agree about the git-svn mention.

				Petr "Pasky" Baudis
