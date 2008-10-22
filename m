From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] builtin-blame: Reencode commit messages according
	to git-log rules.
Date: Wed, 22 Oct 2008 16:42:38 -0400
Message-ID: <20081022204238.GC4585@coredump.intra.peff.net>
References: <1224622557-6669-1-git-send-email-angavrilov@gmail.com> <20081022082016.GA18473@sigill.intra.peff.net> <7vd4hsv46z.fsf@gitster.siamese.dyndns.org> <20081022191415.GA31568@coredump.intra.peff.net> <gdo1a3$akl$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 22:44:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KskYb-0004qy-OE
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbYJVUml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 16:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187AbYJVUml
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:42:41 -0400
Received: from peff.net ([208.65.91.99]:4231 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357AbYJVUmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 16:42:40 -0400
Received: (qmail 4392 invoked by uid 111); 22 Oct 2008 20:42:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 16:42:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 16:42:38 -0400
Content-Disposition: inline
In-Reply-To: <gdo1a3$akl$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98909>

On Wed, Oct 22, 2008 at 10:12:54PM +0200, Jakub Narebski wrote:

> Currently you can use path_info URL for blob_plain
> 
>   http://repo.or.cz/w/git/gitbuild.git/platform:/jk/solaris/config.mak

Ah, I didn't know that. Thanks.

> Soon (thanks to Giuseppe patches) you would be able to use
> 
>   http://repo.or.cz/w/git/gitbuild.git/blob/platform:/jk/solaris/config.mak

Yes, those patches were actually what spurred my comment. :) I am
looking forward to playing with them once they are on repo.or.cz.

-Peff
