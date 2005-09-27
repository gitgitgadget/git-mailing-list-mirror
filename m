From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-daemon: path validation, export all option
Date: Tue, 27 Sep 2005 09:56:18 -0700
Message-ID: <7vd5mu30wd.fsf@assigned-by-dhcp.cox.net>
References: <4338AACC.1050305@zytor.com>
	<7vslvr6t1u.fsf@assigned-by-dhcp.cox.net> <43396FF9.1000900@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 18:59:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKIkk-00088I-KM
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 18:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVI0Q4Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 12:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVI0Q4Y
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 12:56:24 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:33449 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964995AbVI0Q4X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 12:56:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927165621.EYWT24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 12:56:21 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43396FF9.1000900@zytor.com> (H. Peter Anvin's message of "Tue,
	27 Sep 2005 09:14:49 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9404>

"H. Peter Anvin" <hpa@zytor.com> writes:

> I have restored this and make the requested RPM changes.  I have left a 
> pullable tree at:
>
> master.kernel.org:/home/hpa/git/daemon.git
>
> ... in order to preserve the commit structure.

Thanks.  Will pull tonight.
