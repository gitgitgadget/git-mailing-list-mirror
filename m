From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] --date=relative falls back to "short" format for
	commits older than a year
Date: Tue, 24 Feb 2009 01:36:25 -0500
Message-ID: <20090224063625.GA16389@coredump.intra.peff.net>
References: <1235165034-20299-1-git-send-email-eletuchy@gmail.com> <20090222230620.GB19011@coredump.intra.peff.net> <7v7i3ix6yi.fsf@gitster.siamese.dyndns.org> <20090223031631.GC22348@coredump.intra.peff.net> <49A2599E.2030406@trolltech.com> <20090224050400.GC4615@coredump.intra.peff.net> <49A39519.3030308@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, eletuchy@gmail.com,
	git@vger.kernel.org, eletuchy@facebook.com,
	Eugene Letuchy <eugene@facebook.com>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 07:37:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbqvU-0006Q6-B7
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 07:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbZBXGga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 01:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbZBXGg3
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 01:36:29 -0500
Received: from peff.net ([208.65.91.99]:45134 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429AbZBXGg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 01:36:28 -0500
Received: (qmail 11695 invoked by uid 107); 24 Feb 2009 06:36:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Feb 2009 01:36:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Feb 2009 01:36:25 -0500
Content-Disposition: inline
In-Reply-To: <49A39519.3030308@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111222>

On Tue, Feb 24, 2009 at 07:35:05AM +0100, Marius Storm-Olsen wrote:

> Ok, the standard abbreviation for month is "mo.", so
>
>   "3y 2mo. ago"
>
> then? ;-)

That is definitely better, but see the patch I just posted elsewhere in
the thread.

-Peff
