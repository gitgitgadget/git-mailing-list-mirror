From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Use "-script" postfix for scripts
Date: Fri, 12 Aug 2005 18:27:16 -0400
Message-ID: <20050812222716.GD22778@mythryan2.michonline.com>
References: <Pine.LNX.4.63.0508121526050.25606@wgmdd8.biozentrum.uni-wuerzburg.de> <7vwtmrxjbb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508121451590.3295@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 00:28:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3i09-0006z8-BF
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 00:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVHLW12 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 18:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVHLW11
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 18:27:27 -0400
Received: from mail.autoweb.net ([198.172.237.26]:36525 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932112AbVHLW11 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 18:27:27 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E3hzh-0007R5-4b; Fri, 12 Aug 2005 18:27:17 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E3hzg-0005IZ-00; Fri, 12 Aug 2005 18:27:16 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1E3hzg-0003D4-Fz; Fri, 12 Aug 2005 18:27:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508121451590.3295@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 12, 2005 at 02:55:01PM -0700, Linus Torvalds wrote:
> 
> Sure, I could have called it ".sh" instead to make it look even more like 
> a shell script thing, but I actually think "-script" describes any 
> scripting language - shell, perl, you name it..

See, for example, the history on git-rename-script for why this is good.

-- 

Ryan Anderson
  sometimes Pug Majere
