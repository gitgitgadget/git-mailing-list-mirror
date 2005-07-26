From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] git-cvsimport-script: parse multidigit revisions
Date: Tue, 26 Jul 2005 00:22:59 -0400
Message-ID: <20050726042259.GG6098@mythryan2.michonline.com>
References: <20050712213531.GA10936@pc117b.liacs.nl> <20050713011818.GM9915@kiste.smurf.noris.de> <Pine.LNX.4.58.0507251544300.6074@g5.osdl.org> <20050725234257.GC5680@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Sven Verdoolaege <skimo@liacs.nl>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 26 06:23:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxGyh-0002ab-Jp
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 06:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVGZEXf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 00:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVGZEXc
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 00:23:32 -0400
Received: from mail.autoweb.net ([198.172.237.26]:21898 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261638AbVGZEXb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2005 00:23:31 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DxGy3-00045L-Nx; Tue, 26 Jul 2005 00:22:59 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DxH6r-0007O3-00; Tue, 26 Jul 2005 00:32:05 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DxGy3-0005Wv-4M; Tue, 26 Jul 2005 00:22:59 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050725234257.GC5680@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 26, 2005 at 01:42:57AM +0200, Matthias Urlichs wrote:
> (Side question - why aren't you doing a direct bk2git import?)

The last time I went looking for a tool to do this, I failed to find it
- where can I get this?


-- 

Ryan Anderson
  sometimes Pug Majere
