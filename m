From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 08/10] user-manual.txt: explain better the
 remote(-tracking) branch terms
Date: Tue, 02 Nov 2010 23:58:31 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1011022357240.442@perkele.intern.softwolves.pp.se>
References: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288711888-21528-9-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Nov 02 21:58:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDNwN-0004Ry-GX
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 21:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806Ab0KBU6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 16:58:42 -0400
Received: from smtp.getmail.no ([84.208.15.66]:57428 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543Ab0KBU6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 16:58:41 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LB900GNDZKM3660@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 02 Nov 2010 21:57:58 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id C281817991BF_CD07B56B	for <git@vger.kernel.org>; Tue,
 02 Nov 2010 20:57:58 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id A698D1797FB0_CD07B56F	for <git@vger.kernel.org>; Tue,
 02 Nov 2010 20:57:58 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LB900FQKZKM3L30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 02 Nov 2010 21:57:58 +0100 (MET)
Received: by perkele (Postfix, from userid 501)	id 726387F9D; Tue,
 02 Nov 2010 23:58:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 7092827E21; Tue, 02 Nov 2010 23:58:31 +0100 (CET)
In-reply-to: <1288711888-21528-9-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160555>

Matthieu Moy:

> +In this example, "origin" is called a remote repository, or "remote"
> +for short. The branches of this repository are called "remote
> +branches" from our point of view. The remote-tracking branches listed
> +above were created based on the remote branches at clone time and will
> +be updated by "git fetch" (hence "git pull) and "git push". See

Missing a double quote after '"git pull' above.

-- 
\\// Peter - http://www.softwolves.pp.se/
