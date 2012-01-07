From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] run-command: optionally kill children on exit
Date: Sat, 7 Jan 2012 09:41:57 -0500
Message-ID: <20120107144157.GA2461@sigill.intra.peff.net>
References: <7vipkoih0e.fsf@alter.siamese.dyndns.org>
 <1325936567-3136-1-git-send-email-drizzd@aon.at>
 <1325936567-3136-2-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Jan 07 15:42:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjXTG-0001Jw-NK
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 15:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab2AGOmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 09:42:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60048
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab2AGOl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 09:41:59 -0500
Received: (qmail 16286 invoked by uid 107); 7 Jan 2012 14:48:51 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.2.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Jan 2012 09:48:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Jan 2012 09:41:57 -0500
Content-Disposition: inline
In-Reply-To: <1325936567-3136-2-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188079>

On Sat, Jan 07, 2012 at 12:42:43PM +0100, Clemens Buchacher wrote:

> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
> 
> Not sure if I can sign off without your sign-off. Should I have
> replaced this with Acked-by?

Sorry, I usually sign-off when I sent to the list. But:

Signed-off-by: Jeff King <peff@peff.net>

for this and the other patch in this series.

As for whether you can sign-off, I think it is OK in this case. You are
basically signing off on the "Certificate of Origin" found in
SubmittingPatches. I think you are covered under (b), which is that to
the best of your knowledge it is based on open source work (i.e., even
though I didn't sign off explicitly, it is pretty obvious that this is
meant to be open source). But it's nicer to be explicit.

-Peff
