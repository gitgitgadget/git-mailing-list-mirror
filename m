From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Tue, 2 Sep 2008 17:44:28 -0400
Message-ID: <20080902214428.GA20355@sigill.intra.peff.net>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> <7vk5dujn9h.fsf@gitster.siamese.dyndns.org> <20080902210524.GB7757@leksak.fem-net> <200809022339.20123.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:45:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kadgw-0005of-G3
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 23:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbYIBVoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 17:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbYIBVoc
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 17:44:32 -0400
Received: from peff.net ([208.65.91.99]:2805 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbYIBVoc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 17:44:32 -0400
Received: (qmail 19970 invoked by uid 111); 2 Sep 2008 21:44:31 -0000
Received: from lawn-128-61-20-177.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.20.177)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 02 Sep 2008 17:44:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Sep 2008 17:44:28 -0400
Content-Disposition: inline
In-Reply-To: <200809022339.20123.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94720>

On Tue, Sep 02, 2008 at 11:39:20PM +0200, Johan Herland wrote:

> I'm not sure I like this personally, but if we _really_ don't want newbies 
> to shoot themselves in the foot, we could make "git commit" fail on a 
> detached HEAD unless the user has indicated that s/he knows what's going 
> on; i.e. something like this:

This was discussed to death when detached HEAD was introduced, and the
decision was to go with the current behavior. Try looking in the list
archives around December 2006 / January 2007 if you are truly
masochistic.

-Peff
