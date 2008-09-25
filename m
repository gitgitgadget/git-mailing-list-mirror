From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: shortlog now also obeys $hash_parent
Date: Thu, 25 Sep 2008 17:44:59 +0200
Message-ID: <20080925154459.GN10544@machine.or.cz>
References: <1218204731-9931-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 17:46:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kit2n-0003yk-EJ
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 17:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbYIYPpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 11:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbYIYPpE
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 11:45:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41082 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602AbYIYPpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 11:45:03 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 807533939B2D; Thu, 25 Sep 2008 17:44:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218204731-9931-1-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96781>

On Fri, Aug 08, 2008 at 04:12:11PM +0200, Giuseppe Bilotta wrote:
> If $hash_parent is defined, shortlog now limits the list of commits at
> those between $hash_parent (exclusive) and $hash (inclusive).
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

That sounds like a useful feature.

Acked-by: Petr Baudis <pasky@suse.cz>

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
