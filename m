From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: What to expect after 0.99.8
Date: Mon, 3 Oct 2005 13:02:34 -0700
Message-ID: <20051003200233.GC15593@reactrix.com>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510031522590.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 22:03:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMWWX-00075o-Sd
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 22:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbVJCUCv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 16:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbVJCUCv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 16:02:51 -0400
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:38080 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932683AbVJCUCu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2005 16:02:50 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j93K2YPK016930;
	Mon, 3 Oct 2005 13:02:34 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j93K2YjY016928;
	Mon, 3 Oct 2005 13:02:34 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510031522590.23242@iabervon.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9649>

On Mon, Oct 03, 2005 at 03:43:02PM -0400, Daniel Barkalow wrote:

>  * Accept patches to fetch multiple objects by HTTP in parallel.
> 
> I think this may be necessary to get good performance without rsync for 
> repositories hosted without specific git support.

I have a version of this almost working, but it's a nontrivial patch
that feels more like a post-1.0 thing to me.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
