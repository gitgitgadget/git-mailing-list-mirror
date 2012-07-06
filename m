From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git with uucp for deployment
Date: Fri, 06 Jul 2012 13:04:18 -0700
Message-ID: <86txxk8xml.fsf@red.stonehenge.com>
References: <jt5crg$ku1$1@dough.gmane.org> <863954ai7l.fsf@red.stonehenge.com>
	<7v3954odyc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 22:10:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnErF-0002CT-B3
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 22:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610Ab2GFUKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 16:10:21 -0400
Received: from lax-gw17.mailroute.net ([199.89.0.117]:54671 "EHLO
	gw17.lax01.mailroute.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689Ab2GFUKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 16:10:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gw17.lax01.mailroute.net (Postfix) with ESMTP id 61D4F666A77;
	Fri,  6 Jul 2012 20:10:19 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from gw17.lax01.mailroute.net ([199.89.0.117])
	by localhost (gw17.lax01.mailroute.net.mailroute.net [127.0.0.1]) (mroute_mailscanner, port 10026)
	with LMTP id X84Dg-qUu4Kq; Fri,  6 Jul 2012 20:10:07 +0000 (GMT)
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by gw17.lax01.mailroute.net (Postfix) with ESMTP id 9847D666B1A;
	Fri,  6 Jul 2012 20:04:19 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id BB8212B41; Fri,  6 Jul 2012 13:04:18 -0700 (PDT)
x-mayan-date: Long count = 12.19.19.9.12; tzolkin = 5 Eb; haab = 15 Tzec
In-Reply-To: <7v3954odyc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 06 Jul 2012 13:02:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201147>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>>>>>>> "Neal" == Neal Kreitzinger <nkreitzinger@gmail.com> writes:
>> 
Neal> Does anyone use git with uucp to deploy software?
>> 
>> Isn't there a gap of about two decades between those two things? :)

Junio> Are you suggesting us to get rid of use of Perl from Git, or C for
Junio> that matter?

No, I said *gap*, not *origination*.  I am unaware of *anyone* using
uucp these days, but Perl and C are in heavy use.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
