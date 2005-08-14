From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [ANNOUNCE] qgit-0.9
Date: Sun, 14 Aug 2005 07:58:34 -0400
Message-ID: <20050814115834.GD6844@mythryan2.michonline.com>
References: <20050813121216.15512.qmail@web26305.mail.ukl.yahoo.com> <46a038f905081402049d317e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@yahoo.it>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 13:59:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4H8n-0007cp-PP
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 13:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVHNL6l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 07:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbVHNL6l
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 07:58:41 -0400
Received: from mail.autoweb.net ([198.172.237.26]:32712 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932499AbVHNL6k (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2005 07:58:40 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E4H8N-0006mF-9T; Sun, 14 Aug 2005 07:58:35 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E4H8M-0004h5-00; Sun, 14 Aug 2005 07:58:34 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1E4H8M-0005Th-Lk; Sun, 14 Aug 2005 07:58:34 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f905081402049d317e5@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 14, 2005 at 09:04:19PM +1200, Martin Langhoff wrote:
> Marco,
> 
> How do I get this to build on Debian? Not familiar with scons, and it
> is complaining that it can't find qt and related header files, when
> they are there...

You just need to add -I/usr/include/qt3/ in the appropriate place in the
scons control file, IIRC.

-- 

Ryan Anderson
  sometimes Pug Majere
