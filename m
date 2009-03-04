From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] Modify description file to say what this file is
Date: Wed, 4 Mar 2009 05:00:00 -0500
Message-ID: <20090304100000.GB32433@coredump.intra.peff.net>
References: <200902190736.00462.johnflux@gmail.com> <7vy6w2n3cz.fsf@gitster.siamese.dyndns.org> <43d8ce650903032307i512268f4sa3240c517b51d0b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:01:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lenuy-0002mG-Rc
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 11:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbZCDKAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 05:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbZCDKAI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 05:00:08 -0500
Received: from peff.net ([208.65.91.99]:38339 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbZCDKAH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 05:00:07 -0500
Received: (qmail 23133 invoked by uid 107); 4 Mar 2009 10:00:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 04 Mar 2009 05:00:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2009 05:00:00 -0500
Content-Disposition: inline
In-Reply-To: <43d8ce650903032307i512268f4sa3240c517b51d0b4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112194>

On Wed, Mar 04, 2009 at 07:07:14AM +0000, John Tapsell wrote:

> Hi Junio,
>   Did you commit my patches?  I don't see them yet in git.git ?

Try looking in 'next', which is where new patches cook before going to
master (especially now, as we are right in the middle of release freeze
on master).

  git log --author=John.Tapsell origin/next

-Peff
