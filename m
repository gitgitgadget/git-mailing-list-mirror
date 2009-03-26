From: Jeff King <peff@peff.net>
Subject: Re: Reference for git.git release process
Date: Wed, 25 Mar 2009 23:15:21 -0400
Message-ID: <20090326031521.GA7984@coredump.intra.peff.net>
References: <49CA78BF.2020101@fastmail.fm> <7viqlxz9go.fsf@gitster.siamese.dyndns.org> <20090326022757.GC5835@coredump.intra.peff.net> <7vtz5hugc6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Raman Gupta <rocketraman@fastmail.fm>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 04:17:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmg5a-0001hg-6Z
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 04:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbZCZDPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 23:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753826AbZCZDPd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 23:15:33 -0400
Received: from peff.net ([208.65.91.99]:45175 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690AbZCZDPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 23:15:32 -0400
Received: (qmail 11510 invoked by uid 107); 26 Mar 2009 03:15:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Mar 2009 23:15:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2009 23:15:21 -0400
Content-Disposition: inline
In-Reply-To: <7vtz5hugc6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114711>

On Wed, Mar 25, 2009 at 08:13:13PM -0700, Junio C Hamano wrote:

> Incidentally, that is why I usually favor the current 'matching' default.
> If I decide to push something to the other repository, the other
> repository remembers my wish, so I do not have to keep track (of course,
> for that to work effectively, you have to _own_ the other side; it does
> not work well for a shared public repository and that is why we had a
> lengthy discussion on push.default).

So if I understand correctly, you would actually like "push matching,
delete missing" behavior?

-Peff
