From: Junio C Hamano <junkio@cox.net>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Tue, 22 Nov 2005 09:06:20 -0800
Message-ID: <7v1x18fw8j.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	<cda58cb80511171347yef4f090g@mail.gmail.com>
	<Pine.LNX.4.64.0511171443000.13959@g5.osdl.org>
	<cda58cb80511190423w1e46bf5bu@mail.gmail.com>
	<Pine.LNX.4.64.0511190953520.13959@g5.osdl.org>
	<7vzmo04dpl.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80511211211l2ff6ff12j@mail.gmail.com>
	<7vhda5pw6l.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80511220122r76ca69a2y@mail.gmail.com>
	<7vfyppf1va.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80511220240u45267b18o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 18:11:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EebbE-0006pU-9M
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 18:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVKVRG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 12:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVKVRG2
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 12:06:28 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:4578 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965012AbVKVRG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 12:06:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122170547.UPWE20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 12:05:47 -0500
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80511220240u45267b18o@mail.gmail.com>
	(vagabon.xyz@gmail.com's message of "Tue, 22 Nov 2005 11:40:36 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12555>

Franck <vagabon.xyz@gmail.com> writes:

> It seems that the "lite" repository can't be used as a working
> repository.
>...
> Do you have any clues ?

Were you around on this list, around the beginning of this
month?  The thread that starts here may be of interest:

	http://marc.theaimsgroup.com/?l=git&m=113089701819420

I think (although I do not exactly know how the "lite"
repository was constructed) what you are doing is similar to
what I called "shallow clone" there in that thread.  At the end
of the thread I think I listed what you can and cannot do in
such an incomplete repository.
