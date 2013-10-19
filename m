From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Oct 2013, #04; Fri, 18)
Date: Sat, 19 Oct 2013 02:34:48 -0400
Message-ID: <20131019063447.GA18977@sigill.intra.peff.net>
References: <xmqq38nyw7ja.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 08:35:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXQ81-00007h-LK
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 08:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964Ab3JSGev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 02:34:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:51938 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750881Ab3JSGev (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 02:34:51 -0400
Received: (qmail 25362 invoked by uid 102); 19 Oct 2013 06:34:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Oct 2013 01:34:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Oct 2013 02:34:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqq38nyw7ja.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236389>

On Fri, Oct 18, 2013 at 03:14:49PM -0700, Junio C Hamano wrote:

> * jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
>  - git add: -u/-A now affects the entire working tree
> 
>  Will cook in 'next' until Git 2.0.
> 
> 
> * jc/core-checkstat-2.0 (2013-05-06) 1 commit
>  - core.statinfo: remove as promised in Git 2.0
> 
>  Will cook in 'next' until Git 2.0.
> 
> 
> * jc/push-2.0-default-to-simple (2013-06-18) 1 commit
>  - push: switch default from "matching" to "simple"
> 
>  Will cook in 'next' until Git 2.0.
> 
> 
> * jc/add-2.0-ignore-removal (2013-04-22) 1 commit
>  - git add <pathspec>... defaults to "-A"
> 
>  Updated endgame for "git add <pathspec>" that defaults to "--all"
>  aka "--no-ignore-removal".
> 
>  Will cook in 'next' until Git 2.0.

I notice that these are not actually in 'next', despite the
descriptions.  Should they be, to give them wider exposure?

-Peff
