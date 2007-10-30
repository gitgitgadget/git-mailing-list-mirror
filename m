From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 13:15:18 -0700
Message-ID: <86tzo81hrd.fsf@blue.stonehenge.com>
References: <20071029174000.GA4449@efreet.light.src>
	<alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org>
	<20071029214925.GH21133@thunk.org>
	<alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
	<20071030030104.GK21133@thunk.org>
	<7vtzo9s221.fsf@gitster.siamese.dyndns.org>
	<20071030044026.GA9600@thunk.org>
	<alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
	<20071030053732.GA16963@hermes.priv>
	<alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org>
	<20071030160232.GB2640@hermes.priv>
	<alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org>
	<vpq8x5kh4rr.fsf@bauges.imag.fr>
	<alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org>
	<4727839B.9070205@obry.net>
	<alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pascal Obry <pascal@obry.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Tom Prince <tom.prince@ualberta.net>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 21:15:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImxUs-0000Mv-1c
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 21:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbXJ3UPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 16:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752830AbXJ3UPU
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 16:15:20 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:26677 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbXJ3UPT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 16:15:19 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id B70D51DE9CC; Tue, 30 Oct 2007 13:15:18 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.14.1; tzolkin = 10 Imix; haab = 9 Zac
In-Reply-To: <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org> (Linus Torvalds's message of "Tue, 30 Oct 2007 12:38:27 -0700 (PDT)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62749>

>>>>> "Linus" == Linus Torvalds <torvalds@linux-foundation.org> writes:

Linus> So the only argument really is:

Linus>  - Nobody has pointed to *any* reason to follow 1738.

Linus>  - I have pointed to reasons *not* to do it.

I can support non-compliance with 1738.  However, I'd also suggest
that outside of this cozy group of developers, URL already has a heavily
defined meaning associated with 1738.

Therefore, I propose that the git docs refrain from calling these things
"URLs" because they're not, and instead adopt something like "GRL" (git
resources locator) or whatever.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
