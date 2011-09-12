From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 19:53:27 -0400
Message-ID: <20110912235327.GA29752@sigill.intra.peff.net>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
 <7vk49d5t8u.fsf@alter.siamese.dyndns.org>
 <4E6E928A.6080003@sunshineco.com>
 <7vwrdd1gyc.fsf@alter.siamese.dyndns.org>
 <20110912233348.GE28994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Boaz Harrosh <bharrosh@panasas.com>,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Shumkin <zapped@mail.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:53:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3GK6-0002py-7C
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050Ab1ILXxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:53:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47125
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888Ab1ILXxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:53:30 -0400
Received: (qmail 20848 invoked by uid 107); 12 Sep 2011 23:54:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Sep 2011 19:54:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2011 19:53:27 -0400
Content-Disposition: inline
In-Reply-To: <20110912233348.GE28994@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181261>

On Mon, Sep 12, 2011 at 07:33:48PM -0400, Jeff King wrote:

> > Thanks for spotting. I'll locally amend only this part and hope somebody
> > would volunteer to submit an agreed version as the final one ;-)
> 
> I think we're missing Brandon's note that ".F" is used (as distinct from
> ".f", even on case-sensitive filesystems, as it has some magic meaning).
> And the pascal ones somebody mentioned.

I'm keeping my local version of the topic up-to-date. I'll collect any
more comments, and send the final version in a day or two.

-Peff
