From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add another verbosity level to git-fetch
Date: Thu, 24 May 2007 00:47:25 +0200
Message-ID: <20070523224725.GH2554@steel.home>
References: <20070523213113.GF2554@steel.home> <7viraj1a2e.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:47:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzcB-0008LB-R2
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439AbXEWWr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755293AbXEWWr2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:47:28 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:26815 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439AbXEWWr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:47:28 -0400
Received: from tigra.home (Fa87d.f.strato-dslnet.de [195.4.168.125])
	by post.webmailer.de (fruni mo3) (RZmta 6.7)
	with ESMTP id N00322j4NJf03F ; Thu, 24 May 2007 00:47:26 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 22C6C277BD;
	Thu, 24 May 2007 00:47:26 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 80B23BF4D; Thu, 24 May 2007 00:47:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7viraj1a2e.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSkVo8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48209>

Junio C Hamano, Wed, May 23, 2007 23:53:13 +0200:
> > Use "-v -v" to run git-fetch-pack in verbose mode.
> >
> > Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> > ---
> >
> > Otherwise there is no way to show connect messages for git-fetch
> 
> How about just a single -v to do so?
> 

Dunno, it looks too verbose for a single -v. Try it
