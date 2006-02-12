From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.2.0
Date: Sun, 12 Feb 2006 13:53:13 -0800
Message-ID: <7vpsls8cs6.fsf@assigned-by-dhcp.cox.net>
References: <7vzmkw8d5b.fsf@assigned-by-dhcp.cox.net>
	<43EFADD9.7010909@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Feb 12 22:53:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8P9h-0007R0-FN
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 22:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWBLVxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 16:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWBLVxP
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 16:53:15 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:26331 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751471AbWBLVxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 16:53:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212215046.BISZ17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 16:50:46 -0500
To: git@vger.kernel.org
In-Reply-To: <43EFADD9.7010909@zytor.com> (H. Peter Anvin's message of "Sun,
	12 Feb 2006 13:51:21 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16022>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Junio C Hamano wrote:
>> The latest feature release GIT 1.2.0 is available at the
>> usual places:
>> 	http://www.kernel.org/pub/software/scm/git/
>> 	git-1.2.0.tar.{gz,bz2}			(tarball)
>> 	RPMS/$arch/git-*-1.2.0-1.$arch.rpm	(RPM)
>> Right now binary RPM is available only for x86_64, because I do
>> not have an access to RPM capable i386 box.
>>
>
> You can build the i386 binary rpms on hera as such:
>
> rpmbuild --rebuild --target i386 git-1.2.0-1.src.rpm
>
> I had to install openssl-devel from the i386 distribution, which for
> some reason wasn't part of the x86-64 distribution, but that's now
> taken care of.

OK.  Maybe I will when I find time, but not right now.

By the way, did I screw up the original announce?  I do not see
the message come back to me from vger...
