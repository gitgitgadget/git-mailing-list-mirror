From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: [PATCH] cvsserver: fix "cvs diff" in a subdirectory
Date: Mon, 23 Oct 2006 19:11:35 +1300
Message-ID: <453C5D17.4010209@catalyst.net.nz>
References: <Pine.LNX.4.63.0610110032560.14200@wbgn013.biozentrum.uni-wuerzburg.de> <7vslhvy8bo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Martyn Smith <martyn@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Oct 23 08:11:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbt2L-0001K7-Qx
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 08:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbWJWGLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 02:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWJWGLq
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 02:11:46 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:28110 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751569AbWJWGLp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 02:11:45 -0400
Received: from 121-73-4-156.cable.telstraclear.net ([121.73.4.156] helo=[192.168.0.5])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Gbt29-0000Oq-CV; Mon, 23 Oct 2006 19:11:37 +1300
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslhvy8bo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29820>

Junio C Hamano wrote:

> Will park this and the "U for update, M for modified" patch in
> "pu", waiting for acks from actual git-cvsserver users.  It
> feels it is safe enough change, so with an Ack from Mart[yi]n
> it may be woth having it in 1.4.3

Late late Ack. Sorry about the delay. I see it's in master already ;-)

cheers,


martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
