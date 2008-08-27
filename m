From: Karl Chen <quarl@cs.berkeley.edu>
Subject: Re: [PATCH v2] Support "core.excludesfile = ~/.gitignore"
Date: Tue, 26 Aug 2008 20:18:15 -0700
Message-ID: <quack.20080826T2018.lthr68b2ljc@roar.cs.berkeley.edu>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
	<7vsksw92nh.fsf@gitster.siamese.dyndns.org>
	<quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>
	<7vprnyqo59.fsf@gitster.siamese.dyndns.org>
	<20080824220854.GA27299@coredump.intra.peff.net>
	<7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
	<20080824231343.GC27619@coredump.intra.peff.net>
	<7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
	<quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
	<20080827002506.GB7347@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 05:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYBZ2-0005YV-LD
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 05:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbYH0DSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 23:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783AbYH0DSQ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 23:18:16 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:55023 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758AbYH0DSP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 23:18:15 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 69FB834579; Tue, 26 Aug 2008 20:18:15 -0700 (PDT)
X-Quack-Archive: 1
In-Reply-To: <20080827002506.GB7347@coredump.intra.peff.net> (Jeff King's message of "Tue\, 26 Aug 2008 20\:25\:06 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93849>

>>>>> On 2008-08-26 17:25 PDT, Jeff King writes:

    Jeff>   2. There is no documentation update.

Relative paths and $ENVVARS would need explanation; not sure what
needs to be said about ~user since the new behavior is what people
expect to just work.  Would it go in git-config.txt if something
were added?
