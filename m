From: Peter Stuge <peter@stuge.se>
Subject: Re: [PATCH] gitweb: Add js=1 before an URI fragment to fix line
	number links
Date: Tue, 27 Sep 2011 00:28:01 +0200
Message-ID: <20110926222801.14985.qmail@stuge.se>
References: <1317060642-25488-1-git-send-email-peter@stuge.se> <7v62kf2jf4.fsf@alter.siamese.dyndns.org> <20110926194639.25339.qmail@stuge.se> <7vipof0zx0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 00:28:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Jep-0002CB-4Z
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 00:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420Ab1IZW2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 18:28:07 -0400
Received: from foo.stuge.se ([212.116.89.98]:36061 "HELO foo.stuge.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752394Ab1IZW2H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 18:28:07 -0400
Received: (qmail 14986 invoked by uid 501); 26 Sep 2011 22:28:01 -0000
Content-Disposition: inline
In-Reply-To: <7vipof0zx0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182176>

Junio C Hamano wrote:
> > I thought subject together with change would be clear enough. :)
> >
> >
> >> Explanation of what you are fixing is totally lacking.
> >
> > The subject sums it up, if briefly.
> 
> ... Sorry, that is not what I meant.
> 
> You don't have to explain these to *me* specifically as a response
> to this thread. What I meant was that your patch should have these
> necessary descriptions in its proposed commit log message.

IMO not so neccessary if one knows a little web and javascript, which
is probably likely for a gitweb change..

It's a simple fix of links broken by manual URI manipulation that
didn't consider fragments. Is the subject description really not
enough?


//Peter
