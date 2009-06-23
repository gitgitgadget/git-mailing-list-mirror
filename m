From: Jeff King <peff@peff.net>
Subject: Re: git-mailsplit and TortoiseGit bugs
Date: Tue, 23 Jun 2009 00:42:58 -0400
Message-ID: <20090623044258.GA26875@coredump.intra.peff.net>
References: <5b31733c0906221053k4b2659bev1da861b8e997eb5f@mail.gmail.com>
 <20090622202939.GA11912@sigill.intra.peff.net>
 <7vskhra7el.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Filip Navara <filip.navara@gmail.com>, git@vger.kernel.org,
	tortoisegit-dev@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 06:43:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIxqh-0003vE-AX
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 06:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbZFWEnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 00:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbZFWEnA
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 00:43:00 -0400
Received: from peff.net ([208.65.91.99]:52531 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbZFWEnA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 00:43:00 -0400
Received: (qmail 10580 invoked by uid 107); 23 Jun 2009 04:44:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 23 Jun 2009 00:44:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jun 2009 00:42:58 -0400
Content-Disposition: inline
In-Reply-To: <7vskhra7el.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122072>

On Mon, Jun 22, 2009 at 09:41:38PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > mailinfo: accept useless non-multipart boundary attributes
> 
> Is this "accept"? Or do you mean "ignore"?

Saying "ignore" is probably more accurate.

-Peff
