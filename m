From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problems with using git
Date: Thu, 02 Mar 2006 15:44:13 -0800
Message-ID: <7vr75k5s4y.fsf@assigned-by-dhcp.cox.net>
References: <44063B7C.40609@webdrake.net>
	<Pine.LNX.4.64.0603011651240.22647@g5.osdl.org>
	<4406F8B1.9050303@webdrake.net> <4406FA46.7080608@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 00:44:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FExT3-0002Ym-Dc
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 00:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbWCBXoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 18:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbWCBXoR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 18:44:17 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:34963 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1752083AbWCBXoR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 18:44:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060302234128.CQUC17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Mar 2006 18:41:28 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4406FA46.7080608@op5.se> (Andreas Ericsson's message of "Thu, 02
	Mar 2006 14:59:34 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17122>

Andreas Ericsson <ae@op5.se> writes:

> Joseph Wakeling wrote:
>> Thanks very much to all who offered advice on this. :-)
>> Unfortunately openSUSE is somewhat out of sync not just with git but
>> in
>> libraries necessary to install the latest version (libcrypto.so.4,
>> libssl.so.4).  The openssl (0.9.7g-2.4) and openssl-devel (0.9.7g-2)
>> packages don't contain these but rather contain libcrypto.so.0.9.7 and
>> libssl.0.9.7.  Just in case it's important to future git development.
>
> It might be useful for the openSuSE developers, but for git this is
> totally irrelevant.

True, but I had an impression that we had active developers in
git community who are close to Suse, and I wonder why this
hadn't come up earlier.  Maybe our userbase and Suse's userbase
do not overlap much?
