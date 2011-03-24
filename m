From: Harald Welte <laforge@gnumonks.org>
Subject: Re: Unable to clone via git protocol / early EOF / index-pack
 failed
Date: Thu, 24 Mar 2011 11:30:49 +0100
Message-ID: <20110324103049.GI4534@prithivi.gnumonks.org>
References: <20110324102703.GH4534@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 11:44:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2i1s-0002lS-TR
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 11:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759Ab1CXKod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 06:44:33 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:51476 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560Ab1CXKoc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 06:44:32 -0400
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.69)
	(envelope-from <laforge@gnumonks.org>)
	id 1Q2i1n-0006bY-Ve
	for git@vger.kernel.org; Thu, 24 Mar 2011 11:44:31 +0100
Received: from laforge by nataraja.de.gnumonks.org with local (Exim 4.72)
	(envelope-from <laforge@gnumonks.org>)
	id 1Q2hoY-0001Ux-0N
	for git@vger.kernel.org; Thu, 24 Mar 2011 11:30:50 +0100
Content-Disposition: inline
In-Reply-To: <20110324102703.GH4534@prithivi.gnumonks.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169912>

Hi again,

> since a couple of days ago, I'm encountering a very strange problem regarding
> one of my git-daemon installations. 

What I forgot to mention:  The same repositories work fine using the
'ssh' transport, we can clone, fetch, update, push without any problems
at all.  So I am quite sure the problem is not related to the repository
data/metadata, but specifically related to git-daemon.

Thanks again,
	Harald
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
