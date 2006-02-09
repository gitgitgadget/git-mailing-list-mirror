From: Junio C Hamano <junkio@cox.net>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Wed, 08 Feb 2006 17:37:38 -0800
Message-ID: <7vy80ljorh.fsf@assigned-by-dhcp.cox.net>
References: <87slqtcr2f.wl%cworth@cworth.org>
	<7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602081726390.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 02:37:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F70kh-0002Ap-IM
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 02:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422765AbWBIBhl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 20:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422766AbWBIBhk
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 20:37:40 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:1193 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1422765AbWBIBhk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 20:37:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209013449.OFIH17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 20:34:49 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602081726390.2458@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 8 Feb 2006 17:30:56 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15782>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 8 Feb 2006, Junio C Hamano wrote:
>> 
>> So we could even implement that with
>> 
>> 	$ git commit --preview [other flags] [paths...]
>
> My argument for "git status" was that it very much _is_ about "what would 
> I commit". So I'd much rather extend on "git status" than add a 
> "--preview" flag to "git commit".

Our messages crossed.  I'd agree about the reasoning completely,
as I did in my previous message.

Now we need to find a volunteer to do all that work ;-).
