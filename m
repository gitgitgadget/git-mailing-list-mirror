From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 19/25] contrib: remove 'diff-highlight'
Date: Thu, 8 May 2014 21:51:07 -0400
Message-ID: <20140509015107.GA9787@sigill.intra.peff.net>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-20-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 03:51:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZxy-0006YX-VK
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbaEIBvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:51:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:47893 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753367AbaEIBvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:51:09 -0400
Received: (qmail 14815 invoked by uid 102); 9 May 2014 01:51:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 May 2014 20:51:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2014 21:51:07 -0400
Content-Disposition: inline
In-Reply-To: <1399597116-1851-20-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248495>

On Thu, May 08, 2014 at 07:58:30PM -0500, Felipe Contreras wrote:

> No activity since 2012, no tests, no chance of ever graduating.

I don't think "no activity" is an interesting indicator. This tool _is_
actively maintained, but it has not needed any fixes since 2012. I use
it for every single "git log" and "git diff" invocation I do via the
pager.* config.

If we are getting rid of contrib/ I would be happy to continue
maintaining it out-of-tree. But I honestly cannot tell if this thread is
serious or passive-aggressive posturing.

-Peff
