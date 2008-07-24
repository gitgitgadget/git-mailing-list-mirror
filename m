From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/12] git-grep: read config
Date: Thu, 24 Jul 2008 14:58:44 -0400
Message-ID: <20080724185844.GC21186@sigill.intra.peff.net>
References: <20080723145535.GA29053@laptop> <20080724171519.GA21043@sigill.intra.peff.net> <fcaeb9bf0807241145y16bb5f94q9f7e3c09c3184782@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 21:00:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM62T-0001t8-RL
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 20:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbYGXS6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 14:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbYGXS6q
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 14:58:46 -0400
Received: from peff.net ([208.65.91.99]:4953 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752659AbYGXS6p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 14:58:45 -0400
Received: (qmail 27270 invoked by uid 111); 24 Jul 2008 18:58:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 24 Jul 2008 14:58:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jul 2008 14:58:44 -0400
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0807241145y16bb5f94q9f7e3c09c3184782@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89941>

On Fri, Jul 25, 2008 at 01:45:58AM +0700, Nguyen Thai Ngoc Duy wrote:

> > The commit message is a bit lacking...what config are we interested in?
> 
> core.sparsecheckout, but I will probably stay away from config.

Right, I kind of guessed that from reading the rest of the series. But
that sort of "why" really should go into the commit message.

-Peff
