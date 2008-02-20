From: Jeff King <peff@peff.net>
Subject: Re: Minor annoyance with git push
Date: Wed, 20 Feb 2008 13:23:15 -0500
Message-ID: <20080220182315.GA16485@sigill.intra.peff.net>
References: <alpine.LSU.1.00.0802100213330.11591@racer.site> <20080210101756.GB26568@coredump.intra.peff.net> <alpine.LSU.1.00.0802101219280.11591@racer.site> <20080210122321.GA31009@coredump.intra.peff.net> <alpine.LSU.1.00.0802101303140.11591@racer.site> <7vzltwavf9.fsf@gitster.siamese.dyndns.org> <20080220140306.GA6928@sigill.intra.peff.net> <7vk5kz7btw.fsf@gitster.siamese.dyndns.org> <20080220181513.GA16289@sigill.intra.peff.net> <7vskzn5w3m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 19:23:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRtbm-0002Md-FX
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 19:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbYBTSXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 13:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbYBTSXT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 13:23:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2002 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbYBTSXS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 13:23:18 -0500
Received: (qmail 7487 invoked by uid 111); 20 Feb 2008 18:23:17 -0000
Received: from lawn-128-61-31-98.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.31.98)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 20 Feb 2008 13:23:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2008 13:23:15 -0500
Content-Disposition: inline
In-Reply-To: <7vskzn5w3m.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74532>

On Wed, Feb 20, 2008 at 10:19:41AM -0800, Junio C Hamano wrote:

> Yes I would, except that I think Daniel's is much better and is
> to the point.  Doesn't it cover all the issues we discussed so
> far?

Yes, I like Daniel's patch (it came right after I wrote my response).

-Peff
