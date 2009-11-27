From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Give the hunk comment its own color
Date: Fri, 27 Nov 2009 01:52:03 -0500
Message-ID: <20091127065202.GD20844@coredump.intra.peff.net>
References: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
 <20091118142320.GA1220@coredump.intra.peff.net>
 <7vaayjebu5.fsf@alter.siamese.dyndns.org>
 <36ca99e90911260405y42a9a07cx419d2973ec673039@mail.gmail.com>
 <7v4oogzo74.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 07:52:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDugZ-0002vY-M6
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 07:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbZK0Gvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 01:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbZK0Gvz
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 01:51:55 -0500
Received: from peff.net ([208.65.91.99]:36594 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbZK0Gvz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 01:51:55 -0500
Received: (qmail 25074 invoked by uid 107); 27 Nov 2009 06:56:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 27 Nov 2009 01:56:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Nov 2009 01:52:03 -0500
Content-Disposition: inline
In-Reply-To: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133862>

On Thu, Nov 26, 2009 at 06:38:55PM -0800, Junio C Hamano wrote:

> > ... If it is only the nen-existing
> > consensus of the default color, than please use the die.
> 
> If you are having me go find the mail and apply I would probably use
> "plain" as I suggested.

As the other person in the discussion, I'll just chime in that I also
think "plain" is the best of the suggested defaults.

-Peff
