From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/1] gitweb: Mark matched 'ctag' / contents tag
 (?by_tag=foo)
Date: Wed, 9 Mar 2011 15:09:40 +0100
Message-ID: <20110309140939.GV24584@machine.or.cz>
References: <20110301190229.11297.17767.reportbug@cassiopeia.kleinek>
 <20110303081904.GM22310@pengutronix.de>
 <201103071900.16126.jnareb@gmail.com>
 <201103091505.03045.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?iso-8859-2?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, "J.H." <warthog9@kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 15:09:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxK5G-00013d-Fm
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 15:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593Ab1CIOJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 09:09:45 -0500
Received: from w241.dkm.cz ([62.24.88.241]:37323 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932288Ab1CIOJo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 09:09:44 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 37B0517000FE; Wed,  9 Mar 2011 15:09:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201103091505.03045.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168732>

On Wed, Mar 09, 2011 at 03:04:59PM +0100, Jakub Narebski wrote:
> It might have been hard to discover that current view is limited to
> projects with given content tag (ctag), as it was distinquished only
> in gitweb URL.  Mark matched contents tag in the tag cloud using
> "match" class, for easier discovery.
> 
> This commit introduces a bit of further code duplication in
> git_populate_project_tagcloud().
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Acked-by: Petr Baudis <pasky@suse.cz>
