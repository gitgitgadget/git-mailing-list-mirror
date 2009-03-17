From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2009, #01; Tue, 03)
Date: Tue, 17 Mar 2009 03:51:12 -0400
Message-ID: <20090317075112.GC18475@coredump.intra.peff.net>
References: <7vprgzdlom.fsf@gitster.siamese.dyndns.org> <20090303091504.GG3627@coredump.intra.peff.net> <7vprgiysow.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 08:52:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjU6U-0007KU-1m
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 08:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307AbZCQHvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 03:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbZCQHvV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 03:51:21 -0400
Received: from peff.net ([208.65.91.99]:41196 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753177AbZCQHvU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 03:51:20 -0400
Received: (qmail 2738 invoked by uid 107); 17 Mar 2009 07:51:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Mar 2009 03:51:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2009 03:51:12 -0400
Content-Disposition: inline
In-Reply-To: <7vprgiysow.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113434>

On Sun, Mar 15, 2009 at 09:53:19PM -0700, Junio C Hamano wrote:

> But in reality, contributors who had leftover topics on 'next' simply
> stopped working on their topics on 'next' without spending the freed up
> time on concentrating on 'master'.  In an ideal world, the choice would be
> between "git time on 'next'" vs "git time on 'master'", and closing 'next'
> was meant to force the choice, but instead the outcome became "less git
> time until 'next' reopens".

I think that is a reasonable argument for keeping 'next' open, and it
seems to be borne out by this experiment (the post-1.6.2 period seemed
no better or worse for bugfixes to me).

Now the only problem with keeping next open is that the maintainer
misses out on the relative lull in activity during release freeze to
catch up on his day job work. But if you can handle that, I'm certainly
in no position to complain. :)

-Peff
