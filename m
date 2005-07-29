From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Dump http servers still slow?
Date: Fri, 29 Jul 2005 10:48:02 -0400
Message-ID: <20050729144802.GA2280@mythryan2.michonline.com>
References: <1122584423.12374.11.camel@localhost.localdomain> <7vy87qpcwg.fsf@assigned-by-dhcp.cox.net> <1122645821.4263.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 16:48:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyW9r-0004fY-0F
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 16:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVG2OsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 10:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbVG2OsL
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 10:48:11 -0400
Received: from mail.autoweb.net ([198.172.237.26]:36543 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262597AbVG2OsJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 10:48:09 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DyW9a-00017p-KI; Fri, 29 Jul 2005 10:48:02 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DyWJ6-0005qQ-00; Fri, 29 Jul 2005 10:57:52 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DyW9a-0004LZ-40; Fri, 29 Jul 2005 10:48:02 -0400
To: Darrin Thompson <darrint@progeny.com>
Content-Disposition: inline
In-Reply-To: <1122645821.4263.6.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2005 at 09:03:41AM -0500, Darrin Thompson wrote:
> 
> Where is the code for gitweb? (i.e. http://kernel.org/git ) Seems like
> it could benefit from some git-send-pack superpowers.

http://www.kernel.org/pub/software/scm/gitweb/

It occurs to me that pulling this into the main git repository might not
be a bad idea, since it is currently living outside any revision
tracking at the moment.

-- 

Ryan Anderson
  sometimes Pug Majere
