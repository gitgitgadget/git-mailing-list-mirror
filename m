From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH 1/3] Support for SSL client cert
Date: Mon, 26 Sep 2005 11:36:18 -0700
Message-ID: <20050926183617.GA11382@reactrix.com>
References: <20050926175156.GB9410@reactrix.com> <20050926182341.GA26340@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 20:37:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJxqA-0004Ds-FG
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 20:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVIZSgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 14:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVIZSgf
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 14:36:35 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:11022 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932464AbVIZSge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 14:36:34 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8QIaKI9011495;
	Mon, 26 Sep 2005 11:36:20 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8QIaIuJ011493;
	Mon, 26 Sep 2005 11:36:18 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050926182341.GA26340@pasky.or.cz>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9320>

On Mon, Sep 26, 2005 at 08:23:41PM +0200, Petr Baudis wrote:

> Could we please have at least --sslkey, if not having 'ssl' prepended to
> all of them? You never know when you'll want to call something else like
> that in the future... ;-)

Makes sense - I wasn't comfortable deciding what those parameters should be
so I used the curl command-line options.  Who gets to make the official
call on that?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
