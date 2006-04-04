From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: HTTP repo referencing stale heads (can't clone)
Date: Tue, 4 Apr 2006 05:10:57 -0700
Message-ID: <20060404121056.GB14967@reactrix.com>
References: <443146EC.7060704@gentoo.org> <7virpqefp1.fsf@assigned-by-dhcp.cox.net> <20060403180929.GA14967@reactrix.com> <20060404100035.GM27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 14:11:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQkNP-0001S6-Km
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 14:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWDDMLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 08:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWDDMLJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 08:11:09 -0400
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:37953 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964988AbWDDMLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 08:11:08 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k34CAvBS014828;
	Tue, 4 Apr 2006 05:10:57 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k34CAvW5014825;
	Tue, 4 Apr 2006 05:10:57 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060404100035.GM27689@pasky.or.cz>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18389>

On Tue, Apr 04, 2006 at 12:00:35PM +0200, Petr Baudis wrote:

> Well, what is the actual advantage of DAV compared to
> git-update-server-info? Why would I prefer enabling DAV?

In theory, things should work the same either way.  It seems that in
practice though, the server info files continue to surface as a source
of fetch problems.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
