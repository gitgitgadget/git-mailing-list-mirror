From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/19] transport-helper: fix minor leak in
 push_refs_with_export
Date: Wed, 8 Jun 2011 17:57:25 -0400
Message-ID: <20110608215723.GC13021@sigill.intra.peff.net>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-2-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 23:57:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUQl8-0000Sv-Kp
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 23:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482Ab1FHV5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 17:57:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53522
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756409Ab1FHV5g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 17:57:36 -0400
Received: (qmail 4784 invoked by uid 107); 8 Jun 2011 21:57:42 -0000
Received: from m9a2036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.154)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jun 2011 17:57:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2011 17:57:25 -0400
Content-Disposition: inline
In-Reply-To: <1307558930-16074-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175464>

On Wed, Jun 08, 2011 at 08:48:32PM +0200, Sverre Rabbelier wrote:

> From: Jeff King <peff@peff.net>
> 
> 
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>

Hmm. This and the other ones from me lack my S-o-b. I'm pretty sure my
originals included it, so I'm not sure what stripped it out.

-Peff
