From: Wolfgang Denk <wd@denx.de>
Subject: Re: dangling commits
Date: Sun, 15 Jan 2006 23:11:08 +0100
Message-ID: <20060115221108.3ED2E352659@atlas.denx.de>
References: <7vslrp2nw0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 23:11:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyG5q-0008JB-44
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 23:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWAOWLT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 17:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWAOWLT
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 17:11:19 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:50832 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S1750907AbWAOWLS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 17:11:18 -0500
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id D292071357;
	Sun, 15 Jan 2006 23:11:08 +0100 (CET)
X-Auth-Info: uFt9+ITlo5oky+9tvOJno7ljFpB4DikvY/cTD6YGMRw=
X-Auth-Info: uFt9+ITlo5oky+9tvOJno7ljFpB4DikvY/cTD6YGMRw=
Received: from mail.denx.de (p54966EA7.dip.t-dialin.net [84.150.110.167])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id BF2F3B8C10;
	Sun, 15 Jan 2006 23:11:08 +0100 (CET)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 4AD736D00A8;
	Sun, 15 Jan 2006 23:11:08 +0100 (MET)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 3ED2E352659;
	Sun, 15 Jan 2006 23:11:08 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: Your message of "Sun, 15 Jan 2006 13:15:59 PST."
             <7vslrp2nw0.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14713>

In message <7vslrp2nw0.fsf@assigned-by-dhcp.cox.net> you wrote:
>
> Note that only because that is these dangling objects are packed
> in the past, and when fetching over http, packs are fetched as a
> whole.

Is ther eany way to clean up such a situation and really get  rid  of
the  dangling  commits?  I understand that I'd first need some way to
"unpack" the packs, but how to do this? 

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Heavier than air flying machines are impossible.
                    -- Lord Kelvin, President, Royal Society, c. 1895
