From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git-blame.el: what is format-spec?
Date: Fri, 04 Dec 2009 19:18:19 +0100
Message-ID: <vpqskbqmwlw.fsf@bauges.imag.fr>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <m2fx7qae49.fsf@igel.home>
	<87ljhi3cao.fsf@osv.gnss.ru> <m2bpieab67.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 19:18:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGcjl-0007YZ-Je
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 19:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbZLDSS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 13:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbZLDSS0
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 13:18:26 -0500
Received: from mx1.imag.fr ([129.88.30.5]:44729 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932236AbZLDSS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 13:18:26 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nB4IG8ob011238
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 4 Dec 2009 19:16:08 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NGcjT-00055l-Nd; Fri, 04 Dec 2009 19:18:19 +0100
In-Reply-To: <m2bpieab67.fsf@igel.home> (Andreas Schwab's message of "Fri\, 04 Dec 2009 18\:42\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 04 Dec 2009 19:16:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nB4IG8ob011238
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1260555369.26075@Beb8yEet36GXlvvgSykNIw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134562>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Sergei Organov <osv@javad.com> writes:
>
>> However, isn't it a bad idea to require Gnus(!) for git-blame to run? Gnus
>> is not installed on our server where I've encountered the problem. 
>
> Gnus has been part of Emacs since more than 10 years.

... but Linux distros often cut it out by default, so if you just ask
for Emacs as a package, you don't get the Gnus package.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
