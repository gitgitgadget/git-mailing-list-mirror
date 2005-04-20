From: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Wed, 20 Apr 2005 14:19:19 -0700
Message-ID: <20050420211919.GA20129@kroah.com>
References: <20050420205633.GC19112@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 23:15:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOMXa-00075A-O1
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 23:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVDTVTl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 17:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVDTVTl
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 17:19:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:15851 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261817AbVDTVTj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 17:19:39 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3KLJai08870;
	Wed, 20 Apr 2005 14:19:36 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DOMbP-5Fs-00; Wed, 20 Apr 2005 14:19:19 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050420205633.GC19112@pasky.ji.cz>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2005 at 10:56:33PM +0200, Petr Baudis wrote:
>   The short command version will change from 'git' to 'cg', which should
> be shorter to type and free the 'git' command for possible eventual
> entry gate for the git commands (so that they are more
> namespace-friendly, and it might make most sense anyway if we get fully
> libgitized; but this is more of long-term ideas).

Hm, but there already is a 'cg' program out there:
	http://uzix.org/cgvg.html
I use it every day :(

How about 'cog' instead?

Or I can just rename my local copy of cg and try to retrain my
fingers...

thanks,

greg k-h
