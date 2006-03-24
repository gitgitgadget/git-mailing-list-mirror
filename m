From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fw: [PATCH 31/49] PCI: PCI/Cardbus cards hidden, needs pci=assign-busses to fix
Date: Thu, 23 Mar 2006 23:44:26 -0800
Message-ID: <7vy7z01e3p.fsf@assigned-by-dhcp.cox.net>
References: <20060323161521.28a874e6.akpm@osdl.org>
	<20060324002930.GA21184@kroah.com>
	<20060323163844.5fda7589.akpm@osdl.org>
	<20060324004654.GA19763@kroah.com>
	<7vbqvw3a62.fsf@assigned-by-dhcp.cox.net>
	<20060323175126.7ff71032.akpm@osdl.org>
	<7v3bh837cs.fsf@assigned-by-dhcp.cox.net>
	<20060324061706.GA11248@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 08:44:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMgyI-0001xp-DG
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 08:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbWCXHo3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 02:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWCXHo2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 02:44:28 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:3818 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751569AbWCXHo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 02:44:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060324074427.HGHR6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Mar 2006 02:44:27 -0500
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060324061706.GA11248@kroah.com> (Greg KH's message of "Thu, 23
	Mar 2006 22:17:06 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17901>

Greg KH <greg@kroah.com> writes:

>> This was tested once by sending myself two patches.
>
> Oops, just saw this after I sent out the last set of patches.  It looks
> good to me, I'll try it out next time.

Thanks.  Will place this in "master" tonight.
