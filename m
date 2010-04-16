From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH RFC 0/5] Patches to avoid reporting conversion changes.
Date: Fri, 16 Apr 2010 11:06:45 -0700
Message-ID: <86ljcnclvu.fsf@red.stonehenge.com>
References: <cover.1271432034.git.grubba@grubba.org>
	<874ojbqnry.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Fri Apr 16 20:06:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2pwK-0003Gm-NY
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 20:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152Ab0DPSGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 14:06:46 -0400
Received: from red.stonehenge.com ([208.79.95.2]:34358 "EHLO
	red.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757742Ab0DPSGq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 14:06:46 -0400
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id F3F84CF5F; Fri, 16 Apr 2010 11:06:45 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.5.0; tzolkin = 12 Ahau; haab = 13 Pop
In-Reply-To: <874ojbqnry.fsf@jondo.cante.net> (Jari Aalto's message of "Fri,
	16 Apr 2010 21:02:09 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145090>

>>>>> "Jari" == Jari Aalto <jari.aalto@cante.net> writes:

Jari>     if ( $OS_ERROR ) ...

Right, but without looking, is it $OS_ERROR or $OSERROR?

That's the problem.

You're trading a list of single punctuation characters, pretty
unambiguous, for things that could have been named a dozen different
ways each.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
