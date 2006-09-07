From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Cygwin install howto
Date: Thu, 7 Sep 2006 17:19:26 +1200
Message-ID: <46a038f90609062219g340a738fq3813f1c0e07916a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 07 09:05:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLDwa-0001ma-Cr
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 09:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWIGHE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 03:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWIGHE5
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 03:04:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:40319 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751811AbWIGFT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 01:19:28 -0400
Received: by nf-out-0910.google.com with SMTP id o25so371657nfa
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 22:19:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JBvS6piGf6KoJDueJJIkqTN0ka3RwWk+w866/DeRWNi0vVpfE5PtuxZ945xh8WeFMskCcIpnaasC1CRJMtsUzu0wd9DjmoRzNEDyZYZF2RI371RNXgsFmTp8ucm2g/Vf+ilwhcpYBq6diZiB1vHhc8n8Ld2B7xDNEqKEs8m6U2M=
Received: by 10.49.92.18 with SMTP id u18mr2043853nfl;
        Wed, 06 Sep 2006 22:19:26 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Wed, 6 Sep 2006 22:19:26 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26606>

A friend wants to work with us on a git project but is Trapped In
Windows right now. He does have a cywgin install, and I was hoping to find
a cygwin install howto. Alas, I couldn't find any (is there one and
Google doesn't know about it?).

Now, I am a bit at a loss, as I don't have access to windows. So for
you cygwin knights in the woods, a few questions...

 - What cygwin packages are needed?
 - Makefile tweaks?
 - How do I install for personal use?
 - How do I install in /usr/local?
 - Anything else I should know?

I'll be more than happy to shape the replies in a nice wiki page...
(Mercurial has one already
http://www.selenic.com/mercurial/wiki/index.cgi/WindowsInstall )

cheers,


martin
