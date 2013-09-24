From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 02:46:04 -0400
Message-ID: <20130924064604.GA7257@sigill.intra.peff.net>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
 <20130924045325.GD2766@sigill.intra.peff.net>
 <CAMP44s1tirA5w91L2YomaduZVkqL3=n1j79eoueB6XeGuyY3Mw@mail.gmail.com>
 <20130924053712.GA6114@sigill.intra.peff.net>
 <CAMP44s1-AXKRz4pqQsyCMLZgnxmxTaoeBGt8aNDFM0ttDTmBRQ@mail.gmail.com>
 <20130924061830.GB6114@sigill.intra.peff.net>
 <CAMP44s3ee_SmY=NOeMW31D4E01-Ft9qY5wa9VhRQWrY0fo7S=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 08:46:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOMNx-00020i-Nv
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 08:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725Ab3IXGqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 02:46:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:53639 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab3IXGqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 02:46:08 -0400
Received: (qmail 4066 invoked by uid 102); 24 Sep 2013 06:46:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Sep 2013 01:46:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 02:46:04 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s3ee_SmY=NOeMW31D4E01-Ft9qY5wa9VhRQWrY0fo7S=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235276>

On Tue, Sep 24, 2013 at 01:41:19AM -0500, Felipe Contreras wrote:

> > People who have different aliases for
> > the same terms are unaffected on existing boxes, but slightly hindered
> > on new boxes as the aliases do something else.
> 
> Less hindered than in the current situation.

I do not agree, but I've already explained my reasoning.  I think we
must agree to disagree on this.

> cvs ci = cvs commit
> cvs co = cvs checkout
> 
> svn ci = svn commit
> svn co = svn checkout
> 
> hg ci = hg commit
> hg co = hg checkout
> 
> And somehow you think this is not natural and sensible?
> 
> git ci = git commit
> git co = git checkout
> 
> I think it's as clear as day.

If it is natural, sensible, and as clear as day, then why do people
alias the commands to something besides what you show?

-Peff
