From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] checkout -f: do not leave untracked working tree files.
Date: Tue, 20 Jun 2006 04:51:06 -0700
Message-ID: <7vveqw82qd.fsf@assigned-by-dhcp.cox.net>
References: <449557B6.1080907@garzik.org> <8764iw5bvl.fsf@gmail.com>
	<7vfyi09isf.fsf@assigned-by-dhcp.cox.net>
	<200606201827.50808.lan@academsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 13:53:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsenf-0002Xv-4W
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 13:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWFTLws (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 07:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWFTLwd
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 07:52:33 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:55989 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030229AbWFTLvH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 07:51:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060620115106.THYA5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Jun 2006 07:51:06 -0400
To: Alexander Litvinov <lan@academsoft.ru>
In-Reply-To: <200606201827.50808.lan@academsoft.ru> (Alexander Litvinov's
	message of "Tue, 20 Jun 2006 18:27:50 +0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22194>

Alexander Litvinov <lan@academsoft.ru> writes:

> Good news. I have a habbit to switch branches using two commands:
>
> git checkout -f second-branch
> git clean -d -q
>
> Now this will work with single command. Thanks.

"will" meaning "you suspect" or "you tried and confirmed"?
