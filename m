From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: [PATCH v3] Advertise the ability to abort a commit
Date: Thu, 31 Jul 2008 09:28:45 +0200
Message-ID: <87sktqfr6a.fsf@cup.kalibalik.dk>
References: <20080730051059.GA4497@sigill.intra.peff.net>
	<1217440391-13259-1-git-send-email-mail@cup.kalibalik.dk>
	<20080731055024.GA17652@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 31 09:30:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOSbc-00049n-8h
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 09:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbYGaH2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 03:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbYGaH2r
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 03:28:47 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:49476 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbYGaH2r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 03:28:47 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 89CC414062;
	Thu, 31 Jul 2008 09:28:45 +0200 (CEST)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 2D7FB1405A;
	Thu, 31 Jul 2008 09:28:45 +0200 (CEST)
In-Reply-To: <20080731055024.GA17652@sigill.intra.peff.net> (Jeff King's message of "Thu\, 31 Jul 2008 01\:50\:24 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90905>

Jeff King <peff@peff.net> writes:

> I still prefer a shortened version of these three lines, as I
> mentioned earlier.

Yeah, and I obviously didn't :-). I think the line wrapped, run-on
sentence makes it look more busy, even if it is shorter. Here is a
final compromise proposal:

# Enter a commit message for your changes. Use an empty one to abort.
# (Comment lines starting with '#' will not be included)


As this is mostly a matter of personal opinion, I will stop here.


Cheers,
Anders.
