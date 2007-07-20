From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Install man3 manpages to $PREFIX/share/man/man3 even  for site installs
Date: Thu, 19 Jul 2007 17:46:00 -0700
Message-ID: <861wf37vhz.fsf@blue.stonehenge.com>
References: <11848491502417-git-send-email-madduck@madduck.net>
	<7vzm1r29df.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "martin f. krafft" <madduck@madduck.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 02:46:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBgdP-0001Nh-AT
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 02:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935731AbXGTAqH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 20:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935589AbXGTAqF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 20:46:05 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:16525 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934895AbXGTAqA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 20:46:00 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 336201DE848; Thu, 19 Jul 2007 17:46:00 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.8.18; tzolkin = 11 Etznab; haab = 6 Xul
In-Reply-To: <7vzm1r29df.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu, 19 Jul 2007 17:42:52 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53046>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> Randal, I cannot decide if this is the right thing to do, or 
Junio> better than what we currently do.  Could you care to enlighten
Junio> us please?

I'll have to research it.  On *every single* major release of Perl, and even
some of the minor ones, the rules for what Makefile.PL does have changed.
It's really maddening.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
