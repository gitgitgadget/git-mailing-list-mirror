From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Distribution of longest common hash prefixes
Date: Tue, 03 Apr 2007 10:11:44 -0700
Message-ID: <867istcrhr.fsf@blue.stonehenge.com>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
	<Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
	<86bqi6kae7.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0704020938470.6730@woody.linux-foundation.org>
	<86y7laitlz.fsf@blue.stonehenge.com>
	<86r6r2isva.fsf@blue.stonehenge.com>
	<m3r6r1jsmq.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Eriksen <s022018@student.dtu.dk>
To: James Cloos <cloos@jhcloos.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 19:12:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYmY1-0000mn-Ed
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 19:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965724AbXDCRLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 13:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965661AbXDCRLq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 13:11:46 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:48702 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965724AbXDCRLp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 13:11:45 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id CA3491DEB76; Tue,  3 Apr 2007 10:11:44 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.3.11; tzolkin = 8 Chuen; haab = 4 Uayeb
In-Reply-To: <m3r6r1jsmq.fsf@lugabout.jhcloos.org> (James Cloos's message of "Tue, 03 Apr 2007 13:04:54 -0400")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43631>

>>>>> "James" == James Cloos <cloos@jhcloos.com> writes:

James> With that version the kernel gives:

James> 0: 
James> 1: 
James> 2: 
James> 3: 565
James> 4: 288450
James> 5: 139080
James> 6: 10699
James> 7: 700
James> 8: 32
James> 9: 2

Fascinating.  So you can spell out *any* commit in linux-2.6.git with
10 hex chars.  What do we need 40 for, again? :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
