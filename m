From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH RFC 0/5] Patches to avoid reporting conversion changes.
Date: Sat, 17 Apr 2010 12:34:42 -0700
Message-ID: <86eiidan59.fsf@red.stonehenge.com>
References: <cover.1271432034.git.grubba@grubba.org>
	<874ojbqnry.fsf@jondo.cante.net> <86ljcnclvu.fsf@red.stonehenge.com>
	<87eiid6fjc.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Apr 17 21:34:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Dmy-0004ig-CH
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 21:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594Ab0DQTeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 15:34:44 -0400
Received: from red.stonehenge.com ([208.79.95.2]:24765 "EHLO
	red.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab0DQTen (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 15:34:43 -0400
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 0079DD0F3; Sat, 17 Apr 2010 12:34:42 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.5.1; tzolkin = 13 Imix; haab = 14 Pop
In-Reply-To: <87eiid6fjc.fsf@jondo.cante.net> (Jari Aalto's message of "Sat,
	17 Apr 2010 22:32:39 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145174>

>>>>> "Jari" == Jari Aalto <jari.aalto@cante.net> writes:

>> Right, but without looking, is it $OS_ERROR or $OSERROR?

Jari> I don't see any difference, because that variable is always within the
Jari> close context of previous statements. The reader would consult the lines
Jari> above.

Yes, once it's already *in* the program.  But I bet you had to *look
them up* to add them.

And if you weren't familiar with Perl, you'd still have to *look them
up* to get the punctuation variables.

You're just trading one problem for another.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
