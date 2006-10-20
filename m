From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 12:02:18 +0200
Message-ID: <vpqwt6v1f11.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca>
	<200610201157.22348.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 12:04:29 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GarEc-0000vN-Ss
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 12:04:14 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GarEX-0004nn-Fi; Fri, 20 Oct 2006 11:04:09 +0100
Received: from imag.imag.fr ([129.88.30.1])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <Matthieu.Moy@imag.fr>) id 1GarET-0004nf-U8
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 11:04:06 +0100
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9KA2Qqj029368
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Oct 2006 12:02:26 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1GarCk-0005DQ-TD; Fri, 20 Oct 2006 12:02:18 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GarCk-0003tA-Ps; Fri, 20 Oct 2006 12:02:18 +0200
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610201157.22348.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri\, 20 Oct 2006 11\:57\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6
	(imag.imag.fr [129.88.30.1]);
	Fri, 20 Oct 2006 12:02:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29435>

Jakub Narebski <jnareb@gmail.com> writes:

> Huh? If you want what changes have been introduced by commit 
> c3424aebbf722c1f204931bf1c843e8a103ee143, you just do
>
> # git diff c3424aebbf722c1f204931bf1c843e8a103ee143

How does git chose which ancestor to use if this revision has more
than one in this case?
