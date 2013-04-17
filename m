From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git log - crash and core dump
Date: Wed, 17 Apr 2013 13:43:11 +0400
Message-ID: <20130417134311.56ea1b191270647dc9ede1df@domain007.com>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
	<516D93C4.1000100@lsrfire.ath.cx>
	<7v61zml0ow.fsf@alter.siamese.dyndns.org>
	<516DBE2E.4060201@lsrfire.ath.cx>
	<7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
	<CANKwXW2h1+CGw2M3CmeXzXAX+wdCPgs5Ff_bGvTgYVpkwpijUw@mail.gmail.com>
	<CANKwXW0WkZXJMi+6T8ymvTi5-JpRfrn_xKmjGw-FsXpaCGuK5g@mail.gmail.com>
	<20130417082701.GP2278@serenity.lan>
	<CANKwXW10tA+qNZ21YYcZxFLL4fWVRhq42nrkSogtmwAMTgPAzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Ivan Lyapunov <dront78@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 11:43:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USOtg-0006EI-OM
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 11:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965852Ab3DQJnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 05:43:19 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:41989 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab3DQJnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 05:43:19 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r3H9hBP9004656;
	Wed, 17 Apr 2013 13:43:12 +0400
In-Reply-To: <CANKwXW10tA+qNZ21YYcZxFLL4fWVRhq42nrkSogtmwAMTgPAzQ@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221525>

On Wed, 17 Apr 2013 13:14:48 +0400
Ivan Lyapunov <dront78@gmail.com> wrote:

> netbeans use some integrated git wrapper and I don't know about JGit
> source base or not. In Eclipse we use Egit. Also all broken commits
> limited to november 2012, but we still continue to use the same
> development environments without any problems

Does "the same" also mean "of the same version"?
I mean that if, say, you managed to update netbeans after November, 2012
that would explain a lot as the update might just silently pull
a fix for the Git-interfacing code.  The same might apply to Git itself
as well.
