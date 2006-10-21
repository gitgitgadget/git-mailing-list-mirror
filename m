From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 13:57:01 -0400
Message-ID: <453A5F6D.7020306@utoronto.ca>
References: <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org> <453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca> <20061020141222.GA17497@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Carl Worth <cworth@cworth.org>, Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 19:57:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbL5s-0007pR-Or
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 19:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766619AbWJUR5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 13:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766622AbWJUR5J
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 13:57:09 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:52398 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1766619AbWJUR5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 13:57:07 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GbL5j-0002VH-00; Sat, 21 Oct 2006 13:57:04 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Jeff King <peff@peff.net>
In-Reply-To: <20061020141222.GA17497@coredump.intra.peff.net>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29647>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff King wrote:
> On Thu, Oct 19, 2006 at 09:06:40PM -0400, Aaron Bentley wrote:
> 
>> What's nice is being able see the revno 753 and knowing that "diff -r
>> 752..753" will show the changes it introduced.  Checking the revo on a
>> branch mirror and knowing how out-of-date it is.
> 
> I was accustomed to doing such things in CVS, but I find the git way
> much more pleasant, since I don't have to do any arithmetic:
>   diff d8a60^..d8a60

> Does bzr have a similar shorthand for mentioning relative commits?

Yes, you could e.g. do:

bzr diff -r before:753..753

Aaron

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFOl9s0F+nu1YWqI0RAhW7AJ4vi4kgen/8h6j2AgueU+kcsmLrPwCeKry9
pp68K4rAmXjjkPvK32LvmPk=
=qDn2
-----END PGP SIGNATURE-----
