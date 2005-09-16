From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add uninstall target to Makefile
Date: Fri, 16 Sep 2005 10:08:04 -0700
Message-ID: <7vfys5ndor.fsf@assigned-by-dhcp.cox.net>
References: <20050916125814.GA8084@igloo.ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 19:11:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGJh4-0007G0-H5
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 19:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbVIPRIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 13:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbVIPRIH
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 13:08:07 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44470 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1161194AbVIPRIG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 13:08:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916170805.OHOZ20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 13:08:05 -0400
To: Martin Atukunda <matlads@dsmagic.com>
In-Reply-To: <20050916125814.GA8084@igloo.ds.co.ug> (Martin Atukunda's message
	of "Fri, 16 Sep 2005 15:58:14 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8695>

Martin Atukunda <matlads@dsmagic.com> writes:

> Add the uninstall target to the Makefile.

Sorry, I absolutely detest other peoples' Makefiles that has
this target.  Why would anybody want this?
