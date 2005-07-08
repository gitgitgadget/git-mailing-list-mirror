From: Wolfgang Denk <wd@denx.de>
Subject: Re: New script: cg-clean
Date: Sat, 09 Jul 2005 00:59:59 +0200
Message-ID: <20050708225959.5BCA13539FE@atlas.denx.de>
References: <1120862084.17812.6.camel@dv>
Cc: git <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Jul 09 01:18:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr268-0004TN-LH
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 01:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbVGHXQw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 19:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbVGHXEK
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 19:04:10 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:5297 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262958AbVGHXDa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2005 19:03:30 -0400
Received: from fwd16.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1Dr1sP-00024E-00; Sat, 09 Jul 2005 01:03:21 +0200
Received: from denx.de (VgwhREZDrerr2IHjLyITEHgdE9IVkpv6pUyNtJwZTTPWvlS-i1DH0Z@[84.150.68.56]) by fwd16.sul.t-online.de
	with esmtp id 1Dr1sC-0Wb7T60; Sat, 9 Jul 2005 01:03:08 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id AB13A42FCC; Sat,  9 Jul 2005 01:03:07 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 5BCA13539FE;
	Sat,  9 Jul 2005 00:59:59 +0200 (MEST)
To: Pavel Roskin <proski@gnu.org>
In-reply-to: <1120862084.17812.6.camel@dv> 
Comments: In-reply-to Pavel Roskin <proski@gnu.org>
   message dated "Fri, 08 Jul 2005 18:34:44 -0400."
X-ID: VgwhREZDrerr2IHjLyITEHgdE9IVkpv6pUyNtJwZTTPWvlS-i1DH0Z@t-dialin.net
X-TOI-MSGID: 81e20480-a717-45d3-b5fd-8c1ebe835975
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In message <1120862084.17812.6.camel@dv> Pavel Roskin wrote:
> 
> Please consider this script for Cogito.
...
> # OPTIONS
> # -------
> # -i::
> #	Clean files ignored by cg-status, such as object files.

May I suggest to give "-i" the standard "--interactive" meaning
(= prompt before removal) like with "rm" etc. ?

Thanks.


Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
How come everyone's going so slow if it's called rush hour?
