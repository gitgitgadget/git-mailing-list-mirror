From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/3] conditional makefile vars
Date: Fri, 5 Aug 2005 01:07:37 +0200
Message-ID: <20050804230737.GK24479@pasky.ji.cz>
References: <42EE8992.5070204@my-eitzenberger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 05 01:09:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0oq3-00022n-Oh
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 01:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVHDXI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 19:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVHDXIm
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 19:08:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62221 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262717AbVHDXHi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 19:07:38 -0400
Received: (qmail 10668 invoked by uid 2001); 4 Aug 2005 23:07:37 -0000
To: Holger Eitzenberger <holger@my-eitzenberger.de>
Content-Disposition: inline
In-Reply-To: <42EE8992.5070204@my-eitzenberger.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Aug 01, 2005 at 10:44:02PM CEST, I got a letter
where Holger Eitzenberger <holger@my-eitzenberger.de> told me that...
> Hi,

Hi,

> please see the notes of my first email, thx.

I don't know. Is this really a good idea? The names are lowercase and
may be whatever mess some build scripts or whatever may set, or junk the
user has set inadvertently. And automake-generated Makefiles don't have
them conditional either.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
