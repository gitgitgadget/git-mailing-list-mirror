From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 4/5] branch: introduce --list option
Date: Fri, 9 Sep 2011 15:30:34 -0400
Message-ID: <20110909193033.GA31184@sigill.intra.peff.net>
References: <0785cac235c3b45537cf161c86dde8e798c4ff3e.1314367414.git.git@drmicha.warpmail.net>
 <7vfwkodq5s.fsf@alter.siamese.dyndns.org>
 <4E5A5290.4050005@drmicha.warpmail.net>
 <20110907195611.GD13364@sigill.intra.peff.net>
 <4E6889DF.7030404@drmicha.warpmail.net>
 <7vr53qwxtz.fsf@alter.siamese.dyndns.org>
 <7vmxeewx7f.fsf@alter.siamese.dyndns.org>
 <4E69B832.9030503@drmicha.warpmail.net>
 <7vlitxvh45.fsf@alter.siamese.dyndns.org>
 <4E6A691C.2060803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 21:30:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R26mf-0002d8-Cj
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 21:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759917Ab1IITah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 15:30:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50524
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759852Ab1IITag (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 15:30:36 -0400
Received: (qmail 1222 invoked by uid 107); 9 Sep 2011 19:31:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Sep 2011 15:31:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2011 15:30:34 -0400
Content-Disposition: inline
In-Reply-To: <4E6A691C.2060803@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181112>

On Fri, Sep 09, 2011 at 09:29:32PM +0200, Michael J Gruber wrote:

> > I recall Peff had some comments on your new tests last night, by the way.
> 
> Yes, we have tests (now) for "-v -d", "-v -m", "-v branch*" and
> combinations with --list. Testing "-v foo" for creation would be good
> (and belong into t3200). Is there anything to amend?

I think my comment was just to add the "-v foo" test.

-Peff
