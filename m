From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] Use backticks instead of $(command) to maintain /bin/sh compatibility
Date: Sun, 8 May 2005 01:15:05 +0200
Message-ID: <20050507231505.GA2497@cip.informatik.uni-erlangen.de>
References: <20050507084549.GF23680@cip.informatik.uni-erlangen.de> <7v3bszbeoo.fsf@assigned-by-dhcp.cox.net> <20050507090543.GG23680@cip.informatik.uni-erlangen.de> <20050507100348.GA16461@outpost.ds9a.nl> <20050507101530.GH23680@cip.informatik.uni-erlangen.de> <7vy8aqanlh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 08 01:08:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUYPO-0006nu-TB
	for gcvg-git@gmane.org; Sun, 08 May 2005 01:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbVEGXPK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 19:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbVEGXPJ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 19:15:09 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:43469 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262761AbVEGXPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 19:15:07 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j47NF5S8029760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 7 May 2005 23:15:06 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j47NF5r7029759
	for git@vger.kernel.org; Sun, 8 May 2005 01:15:05 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vy8aqanlh.fsf@assigned-by-dhcp.cox.net>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> If that is the case then I think the patch you posted to force
> bash is backwards.  How about changing it to use backticks?

agreed. Already did that see previous eMail.

	Thomas
