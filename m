From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] git-cvsserver.perl: encourage use of English module and qx() operator
Date: Fri, 16 Apr 2010 09:55:42 -0700
Message-ID: <86y6gncp69.fsf@red.stonehenge.com>
References: <1271435565-32370-1-git-send-email-jari.aalto@cante.net>
	<8639yve4gk.fsf@red.stonehenge.com> <87mxx3qr6y.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Fri Apr 16 18:55:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2opZ-0004c9-0y
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758617Ab0DPQzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 12:55:44 -0400
Received: from red.stonehenge.com ([208.79.95.2]:16596 "EHLO
	red.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758606Ab0DPQzn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:55:43 -0400
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id D8075CE22; Fri, 16 Apr 2010 09:55:42 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.5.0; tzolkin = 12 Ahau; haab = 13 Pop
In-Reply-To: <87mxx3qr6y.fsf@jondo.cante.net> (Jari Aalto's message of "Fri,
	16 Apr 2010 19:48:21 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145083>

>>>>> "Jari" == Jari Aalto <jari.aalto@cante.net> writes:

Jari> It would be interesting to know why not. These magic variables are hard
Jari> to read and remember without consulting the manual pages.

Because it was observed over time that the aliases were *also* hard to
remember without consulting the manpages. :)

So you were merely trading one problem for another, and since far more
code is out there that does *not* use English than does, we agreed that
use English was an interesting but failed experiment.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
