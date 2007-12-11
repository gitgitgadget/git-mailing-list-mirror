From: Jeff King <peff@peff.net>
Subject: Re: v1.5.4 plans
Date: Tue, 11 Dec 2007 02:03:10 -0500
Message-ID: <20071211070310.GA26228@coredump.intra.peff.net>
References: <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org> <20071210234941.GE22254@coredump.intra.peff.net> <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org> <7vzlwhhli5.fsf@gitster.siamese.dyndns.org> <20071211063941.GB21718@coredump.intra.peff.net> <7vd4tdhgnd.fsf@gitster.siamese.dyndns.org> <20071211065400.GA25985@coredump.intra.peff.net> <7v7ijlhg0o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 08:03:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1z9R-0006vw-Kt
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 08:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbXLKHDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 02:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbXLKHDM
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 02:03:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4919 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbXLKHDM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 02:03:12 -0500
Received: (qmail 7027 invoked by uid 111); 11 Dec 2007 07:03:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 11 Dec 2007 02:03:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2007 02:03:10 -0500
Content-Disposition: inline
In-Reply-To: <7v7ijlhg0o.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67813>

On Mon, Dec 10, 2007 at 11:00:55PM -0800, Junio C Hamano wrote:

> Perhaps, but that's post 1.5.4.  There is no short-hand to call the
> single commit diff-tree and not give any commit header afair.

OK. I was going to add a "something like this..." patch to my last
email, but realized I had no idea how one would invoke the diff
machinery in such a way.

> Anyway, format-commit-message() makes it much more readable ;-)

The repetition of the format string is a little ugly. But otherwise,

Acked-by: Jeff King <peff@peff.net>

-Peff
