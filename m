From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Errors cloning over http -- git-clone and cg-clone fail to fetch a reachable object...
Date: Sun, 6 Nov 2005 20:37:38 -0800
Message-ID: <20051107043737.GI3001@reactrix.com>
References: <46a038f90511061354k5378a92ckc427841f90ec8b4@mail.gmail.com> <46a038f90511061852h5cdf9539o34f69b4deb9f041a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 05:38:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYylg-0000AS-Ju
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 05:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVKGEhm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 23:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVKGEhl
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 23:37:41 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:850 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932444AbVKGEhj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 23:37:39 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA74bctD018792;
	Sun, 6 Nov 2005 20:37:38 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA74bcTh018790;
	Sun, 6 Nov 2005 20:37:38 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511061852h5cdf9539o34f69b4deb9f041a@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11253>

On Mon, Nov 07, 2005 at 03:52:41PM +1300, Martin Langhoff wrote:

> > I'm getting errors when cloning over http
> 
> More info on this.
> 
> git-fetch-pack (invoked by cg-fetch) bails out because it thinks it
> got a 404 fetching one of the packs:

Does it always error out on the same pack file?

Which build of git are you using, and which version of curl?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
