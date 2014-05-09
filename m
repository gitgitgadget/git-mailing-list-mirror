From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 07/25] contrib: remove 'git-jump'
Date: Thu, 8 May 2014 22:03:50 -0400
Message-ID: <20140509020350.GD9787@sigill.intra.peff.net>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 04:04:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiaAI-0005dH-4K
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 04:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbaEICDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 22:03:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:47914 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932125AbaEICDw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 22:03:52 -0400
Received: (qmail 15464 invoked by uid 102); 9 May 2014 02:03:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 May 2014 21:03:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2014 22:03:50 -0400
Content-Disposition: inline
In-Reply-To: <1399597116-1851-8-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248499>

On Thu, May 08, 2014 at 07:58:18PM -0500, Felipe Contreras wrote:

> No activity, no tests.

Like diff-highlight, I don't think "no activity" is a useful indicator.
I use this daily, and several people have commented off-list to me that
they use it, too.

Like diff-highlight, I'm happy to maintain it out-of-tree if contrib/ is
going away.

-Peff
