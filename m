From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into .git/config
Date: Mon, 28 Nov 2005 22:04:07 -0800
Message-ID: <7v4q5wng6g.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfyph1ebq.fsf@assigned-by-dhcp.cox.net> <438AC32E.5010100@op5.se>
	<200511281359.04741.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 07:22:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egyb7-0004is-C1
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 07:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVK2GEK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 01:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVK2GEK
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 01:04:10 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:28408 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751296AbVK2GEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 01:04:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051129060302.XOCK17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 01:03:02 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12922>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

>> >  - we will add new ones to config, now we have it;
>
> It is not really fitting for all purposes (eg. syntax restrictions).

OK; please read it as "when able".
