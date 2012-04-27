From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2012, #10; Thu, 26)
Date: Fri, 27 Apr 2012 07:03:52 -0400
Message-ID: <20120427110352.GA1828@sigill.intra.peff.net>
References: <xmqqlili6xfu.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 13:04:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNiy1-0006ZG-Br
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 13:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757343Ab2D0LDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 07:03:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49263
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292Ab2D0LDz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 07:03:55 -0400
Received: (qmail 28869 invoked by uid 107); 27 Apr 2012 11:04:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Apr 2012 07:04:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Apr 2012 07:03:52 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlili6xfu.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196465>

On Thu, Apr 26, 2012 at 01:38:13PM -0700, Junio C Hamano wrote:

> * mm/include-userpath (2012-04-25) 2 commits
>   (merged to 'next' on 2012-04-26 at c68e261)
>  + fixup! config: expand tildes in include.path variable
>  + config: expand tildes in include.path variable
> 
> The new "include.path" directive in the configuration files learned
> to understand "~/path" and "~user/path".

Oops? Was this supposed to be squashed before merging to next?

-Peff
