From: Jeff King <peff@peff.net>
Subject: Re: log.decorate=auto not documented
Date: Wed, 27 Aug 2014 14:20:16 -0400
Message-ID: <20140827182016.GB6590@peff.net>
References: <53FDEF52.3030101@eisentraut.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Eisentraut <peter@eisentraut.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 20:20:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMhpa-0003MG-Ej
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 20:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935553AbaH0SUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 14:20:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:60234 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935433AbaH0SUS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 14:20:18 -0400
Received: (qmail 15036 invoked by uid 102); 27 Aug 2014 18:20:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 13:20:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 14:20:16 -0400
Content-Disposition: inline
In-Reply-To: <53FDEF52.3030101@eisentraut.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256019>

On Wed, Aug 27, 2014 at 10:46:42AM -0400, Peter Eisentraut wrote:

> The log.decorate=auto value, which is mentioned in the release notes of
> Git 2.1, is not documented in either git-config.txt or git-log.txt.
> 
> It should also be documented that "auto" corresponds to "short".

Yes, you're right. Care to make a patch?

-Peff
