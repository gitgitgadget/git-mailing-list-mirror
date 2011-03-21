From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 0/3] rev-list and friends: --min-parents, --max-parents
Date: Mon, 21 Mar 2011 06:56:28 -0400
Message-ID: <20110321105628.GC16334@sigill.intra.peff.net>
References: <4D870157.2070309@drmicha.warpmail.net>
 <cover.1300702130.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 11:57:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1cnJ-0008LL-P3
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 11:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228Ab1CUK4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 06:56:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42708
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016Ab1CUK4b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 06:56:31 -0400
Received: (qmail 12092 invoked by uid 107); 21 Mar 2011 10:57:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Mar 2011 06:57:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2011 06:56:28 -0400
Content-Disposition: inline
In-Reply-To: <cover.1300702130.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169581>

On Mon, Mar 21, 2011 at 11:14:04AM +0100, Michael J Gruber wrote:

> In v2, based on the input from Jeff, Junio and Jonathan, I switched to
> ordinary signed integers for --min-parent and --max-parent. Negative
> parameters to the latter mean infinity. (Thus, no more range/macro magic.)

FWIW, I like this version much better. Besides my "resp." nit, I have no
complaints.

-Peff
