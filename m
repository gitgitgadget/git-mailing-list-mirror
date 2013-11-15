From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Add a bugzilla website
Date: Fri, 15 Nov 2013 11:50:17 +0100
Message-ID: <vpqzjp62b2u.fsf@anie.imag.fr>
References: <361384464.315129845.1384511657291.JavaMail.root@zimbra35-e6.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: ycollette.nospam@free.fr
X-From: git-owner@vger.kernel.org Fri Nov 15 11:50:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhGys-0001fu-DE
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 11:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab3KOKu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 05:50:27 -0500
Received: from mx2.imag.fr ([129.88.30.17]:54470 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753494Ab3KOKuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 05:50:25 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id rAFAoHNi023164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 Nov 2013 11:50:17 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rAFAoI4L010802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 15 Nov 2013 11:50:18 +0100
In-Reply-To: <361384464.315129845.1384511657291.JavaMail.root@zimbra35-e6.priv.proxad.net>
	(ycollette nospam's message of "Fri, 15 Nov 2013 11:34:17 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 15 Nov 2013 11:50:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rAFAoHNi023164
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1385117420.96459@H4YQ2JfvKZaBj+03IdIHTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237898>

ycollette.nospam@free.fr writes:

> The bugzilla approach is really useful for the user who is reporting
> bugs: all the bugs are tracked, you can see if a bug has been already
> filled and put some additional informations if necessary.

As a user, the most important thing is that the bug is eventually fixed.
I had a lot of experiences with projects using bugtrackers, where
I filed bugs, and the bugs were burried forever in the bugtracker. Not
all projects are like this, but the danger of using a bugtracker to have
long-standing bugs forgotten is high. It is especially high when there's
no one paid to maintain the list of open bugs low.

As opposed to this, most bug reports on this list are followed by a
lively discussion and a patch.

Sure, a bugtracker could complement this, but someone would have to
volunteer to set up and maintain one, and to get developpers interested
in fixing bugs reported there. There have been attempts, but AFAIK no
success.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
