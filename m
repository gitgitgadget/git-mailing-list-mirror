From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-grep: boolean expression on pattern matching.
Date: Fri, 30 Jun 2006 03:29:23 -0700
Message-ID: <7vk66zj5rw.fsf@assigned-by-dhcp.cox.net>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx>
	<20060625184757.f8273820.tihirvon@gmail.com>
	<E1FuX8l-0001H5-2z@moooo.ath.cx>
	<Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<E1FueYh-0004XE-Fg@moooo.ath.cx>
	<20060629222009.GA9310@cip.informatik.uni-erlangen.de>
	<7vejx7oa3x.fsf@assigned-by-dhcp.cox.net>
	<E1Fw8hS-00023y-FY@moooo.ath.cx>
	<7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net>
	<E1FwDiI-0007Xp-2s@moooo.ath.cx>
	<7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net>
	<7vsllnj6rh.fsf_-_@assigned-by-dhcp.cox.net>
	<e82u4l$fvb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 12:29:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwGFc-0007Gb-6b
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 12:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWF3K3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 06:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWF3K3Z
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 06:29:25 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:32655 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932305AbWF3K3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 06:29:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630102924.SJTP6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 06:29:24 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e82u4l$fvb$1@sea.gmane.org> (Jakub Narebski's message of "Fri,
	30 Jun 2006 12:24:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22979>

Jakub Narebski <jnareb@gmail.com> writes:

>> 
>>       $ git grep -e _PATTERN --and \( -e atom -e token \)
>
> And where is documentation update?

Heh, real men do not do documentation ;-).

I am going to bed now, and am hoping a kind soul would be
sending out a patch while I am sleeping.
