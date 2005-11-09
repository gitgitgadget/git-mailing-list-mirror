From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Wed, 9 Nov 2005 15:36:14 -0800
Message-ID: <20051109233614.GA4051@reactrix.com>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz> <7vvf0r6x97.fsf@assigned-by-dhcp.cox.net> <20050924125001.GB25069@pasky.or.cz> <7virwqwd3z.fsf@assigned-by-dhcp.cox.net> <20051109223303.GG30496@pasky.or.cz> <7v3bm59zxu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:39:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZzW5-0004Wg-8B
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbVKIXh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbVKIXh7
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:37:59 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:50990 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751596AbVKIXh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 18:37:58 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA9NaZJw011820;
	Wed, 9 Nov 2005 15:36:50 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA9NaEHt011814;
	Wed, 9 Nov 2005 15:36:14 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bm59zxu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11442>

On Wed, Nov 09, 2005 at 03:14:21PM -0800, Junio C Hamano wrote:

> > ...; is it safe to assume that the
> > default template post-update hook shipped with GIT will be
> > good-to-be-autoenabled on public repositories 
> 
> Please yell loudly when somebody posts a patch or brings up a
> proposal to break that assumption in the future.

Wouldn't this be a problem on public repositories that are hosted with
DAV?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
