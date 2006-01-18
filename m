From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: Subprojects
Date: Wed, 18 Jan 2006 09:06:07 -0800
Message-ID: <7vy81dxy80.fsf@assigned-by-dhcp.cox.net>
References: <43C52B1F.8020706@hogyros.de>
	<7vpsmq2tyb.fsf@assigned-by-dhcp.cox.net>
	<7vy81eyz47.fsf@assigned-by-dhcp.cox.net>
	<200601181747.15609.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 18:08:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzGlD-0007l9-Ho
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 18:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWARRGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 12:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWARRGL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 12:06:11 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:23791 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751371AbWARRGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 12:06:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118170511.FAIV15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 12:05:11 -0500
To: Alexander Litvinov <lan@ac-sw.com>
In-Reply-To: <200601181747.15609.lan@ac-sw.com> (Alexander Litvinov's message
	of "Wed, 18 Jan 2006 17:47:15 +0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14840>

Alexander Litvinov <lan@ac-sw.com> writes:

>> I started this "bind" design as a thought experiment, but I
>> started to like it more and more.
>>
>
> Is there a version of git with this to try it ?

	http://article.gmane.org/gmane.comp.version-control.git/14760

As I warned there, it still has quite rough edges, so do not use
it on your production repositories.
