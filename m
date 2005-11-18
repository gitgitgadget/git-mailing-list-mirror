From: Junio C Hamano <junkio@cox.net>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 20:27:43 -0800
Message-ID: <7v7jb6r35s.fsf@assigned-by-dhcp.cox.net>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	<b0943d9e0511160311k725526d8v@mail.gmail.com>
	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
	<7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
	<7vy83ny450.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com>
	<7vwtj7wn7n.fsf@assigned-by-dhcp.cox.net> <437D2D14.5080205@gmail.com>
	<7vfypur5jb.fsf@assigned-by-dhcp.cox.net> <437D5219.6060300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 05:39:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecxqm-0007Cp-Ao
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 05:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVKRE1p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 23:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVKRE1p
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 23:27:45 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:6097 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932478AbVKRE1o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 23:27:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118042744.IZTO25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 23:27:44 -0500
To: John Benes <smartcat99s@gmail.com>
In-Reply-To: <437D5219.6060300@gmail.com> (John Benes's message of "Thu, 17
	Nov 2005 22:01:29 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12194>

John Benes <smartcat99s@gmail.com> writes:

> diff --git a/file4 b/file4
> index
> edc575dec543a684da5007b43886ee32ecb381ae..adb07b7ad3fa2c63251b06d1d39cb90a
> 85b860b4 100644
> Files a/file4 and b/file4 differ

Thanks.  This is the same problem as what Large Angly SCM
reports.  What does your "diff --version" say?
