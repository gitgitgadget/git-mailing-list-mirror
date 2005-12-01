From: James Cloos <cloos@jhcloos.com>
Subject: Re: keeping remote repo checked out?
Date: Wed, 30 Nov 2005 20:15:58 -0500
Message-ID: <m38xv5r50x.fsf@lugabout.cloos.reno.nv.us>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
	<7vbr051ad1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 03:16:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehdzf-0003vz-6n
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 03:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVLACQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 21:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbVLACQE
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 21:16:04 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:54033 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S1751324AbVLACQD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 21:16:03 -0500
Received: from lugabout.jhcloos.org (host-69-48-14-86.roc.choiceone.net [69.48.14.86])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lugabout.jhcloos.org", Issuer "ca.jhcloos.com" (verified OK))
	by ore.jhcloos.com (Postfix) with ESMTP
	id 47CD51C2EF; Wed, 30 Nov 2005 20:15:55 -0600 (CST)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 70DAC1DD416; Thu,  1 Dec 2005 01:15:58 +0000 (GMT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr051ad1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 27 Nov 2005 23:48:26 -0800")
Copyright: Copyright 2005 James Cloos
X-Hashcash: 1:23:051201:junkio@cox.net::J47FYy4s6zBN25ed:000C1BR
X-Hashcash: 1:23:051201:git@vger.kernel.org::tMEbsWsOnSYDSiGn:000000000000000000000000000000000000000000cLkp
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13036>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> Creative use of hooks/post-update would solve that.

I'll have to look into that.

Junio> However, you should be very careful if you sometimes edit on
Junio> server and sometimes push from other machine to the server on
Junio> the same branch on the server.

I always pull before editing on the laptop....

Thanks,

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com>
