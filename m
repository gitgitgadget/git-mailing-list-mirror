From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 11/14] t3032-*.sh: Pass the -b (--binary) option to sed
 on cygwin
Date: Sat, 18 Dec 2010 20:16:37 +0000
Message-ID: <4D0D16A5.1010406@ramsay1.demon.co.uk>
References: <4D07B8B5.2030409@ramsay1.demon.co.uk> <7vtyigtaxn.fsf@alter.siamese.dyndns.org> <4D07FE91.2090003@sunshineco.com> <4D087AC7.2090705@viscovery.net> <4D088AB6.5090501@sunshineco.com> <4D0A8250.5090403@ramsay1.demon.co.uk> <4D0B126A.8080702@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Dec 18 23:09:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU4yE-00063k-4r
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 23:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab0LRWJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 17:09:31 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:43305 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750943Ab0LRWJa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Dec 2010 17:09:30 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1PU4y0-0000pE-cJ; Sat, 18 Dec 2010 22:09:29 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4D0B126A.8080702@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163941>

Johannes Sixt wrote:
>> [I thought I was unusual in having such an old sed version, but
>> apparently not... ;-) ]
> 
> As far as I'm concerned, I'm not married to this old version, and I'll
> update to a recent msysgit/MinGW environment RSN. So, in the long run,
> your setup might turn out to be unusal ;-)

Yeah, I've been meaning to upgrade too. (However, I've been saying that
for quite some time now!)

[I had to install the Perl CGI module by hand to get one test to run.
(There is something funny going on with the Config, ExtUtils and Test
modules as well!)]

ATB,
Ramsay Jones
