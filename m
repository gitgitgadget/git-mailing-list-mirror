From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 00/25] contrib: cleanup
Date: Fri, 9 May 2014 11:22:36 -0400
Message-ID: <20140509152236.GC18197@sigill.intra.peff.net>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <CACPiFCJnsu3qw59oK94sP1u0+KBDvne0ZpKS0LMGc_9ge+rJjA@mail.gmail.com>
 <536c36fc8e04c_741a161d31095@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 17:22:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WimdG-0006qB-Lt
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 17:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbaEIPWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 11:22:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:48303 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751667AbaEIPWi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 11:22:38 -0400
Received: (qmail 26396 invoked by uid 102); 9 May 2014 15:22:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 May 2014 10:22:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 May 2014 11:22:36 -0400
Content-Disposition: inline
In-Reply-To: <536c36fc8e04c_741a161d31095@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248572>

On Thu, May 08, 2014 at 09:01:32PM -0500, Felipe Contreras wrote:

> > Are you planning on CC'ing the (inactive) authors/maintainers
> > so they know that if they care they should host those elsewhere?
> 
> They are already Cc'ed.

I don't think you were very thorough on this. Of the three remaining
contrib projects I authored (and for which I am the top shortlog entry),
you cc'd me on one. For contrib/persistent-https, you did not cc Colby,
who is the sole author. I didn't look beyond that.

If we are going to remove projects so they can be maintained out of
tree, it seems like the prudent thing to do is make sure the original
author is aware so that they can actually start maintaining it out of
tree.

-Peff
