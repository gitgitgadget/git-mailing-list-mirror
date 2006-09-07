From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Cygwin playbook?
Date: Thu, 7 Sep 2006 16:59:22 +1200
Message-ID: <46a038f90609062159v3858a771t38355ed60867ccfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 07 08:48:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLDgn-0007Fg-TQ
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 08:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWIGGsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 02:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWIGGsj
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 02:48:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:10057 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161087AbWIGE7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 00:59:24 -0400
Received: by nf-out-0910.google.com with SMTP id o25so369416nfa
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 21:59:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mwKnC4CQ0FvMSvkWSixiNguhsWB/mh4zJ+JsbtkLjzhR2rKJduATAEwaQVw2/HePtXicfL9htZoeH8oHJcoMAgAE/Br1lFKnmoMlfRmeeg1vry7nHWc6wJ8gBEbXZoognqiOPYcfvYEx0+wkihpa2SyqNur7kHMQrrvDoaBgzOY=
Received: by 10.49.41.18 with SMTP id t18mr2039913nfj;
        Wed, 06 Sep 2006 21:59:22 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Wed, 6 Sep 2006 21:59:22 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26604>

A colleage wants to work with us on a git project but is Trapped In
Windows (TM). He does have a cywgin install, and I was hoping to find
a cygwin install howto. Alas, I couldn't find any (is there one and
Google doesn't know about it?).

Now, I am a bit at a loss, as I don't have access to windows. So for
you cygwin knights in the woods, a few questions...

 - What cygwin packages are needed?
 - Need to fudge makefile?
 - How do I install for personal use?
 - How do I install in /usr/local?
 - Anything else I should know?

I'll be more than happy to shape the replies in a nice wiki page...
(Mercurial has one already
http://www.selenic.com/mercurial/wiki/index.cgi/WindowsInstall )

cheers,


martin
