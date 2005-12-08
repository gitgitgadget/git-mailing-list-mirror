From: Ryan Anderson <ryan@michonline.com>
Subject: Re: gitweb.cgi in C
Date: Thu, 8 Dec 2005 14:46:57 -0500
Message-ID: <20051208194656.GA25345@mythryan2.michonline.com>
References: <43988299.4090101@tiscali.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 20:49:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkRjR-0000oG-Vn
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 20:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVLHTrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 14:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVLHTrG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 14:47:06 -0500
Received: from mail.autoweb.net ([198.172.237.26]:26777 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S932293AbVLHTrF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 14:47:05 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1EkRjL-00066w-Ct; Thu, 08 Dec 2005 14:47:04 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1EkRjF-0001sz-Fv; Thu, 08 Dec 2005 14:47:02 -0500
Received: from ryan by mythical with local (Exim 4.54)
	id 1EkRjF-0002le-3F; Thu, 08 Dec 2005 14:46:57 -0500
To: Majkls <majkls@tiscali.cz>
Content-Disposition: inline
In-Reply-To: <43988299.4090101@tiscali.cz>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13370>

On Thu, Dec 08, 2005 at 07:59:37PM +0100, Majkls wrote:
> What do you think about gitweb.cgi in C?

I've seen CGI programs in C before.

I don't recommend it.  I think it will give most security people
nightmares, heh.

-- 

Ryan Anderson
  sometimes Pug Majere
