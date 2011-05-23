From: Jeff King <peff@peff.net>
Subject: Re: git checkout no longer warning about uncommitted/untracked files!
Date: Mon, 23 May 2011 17:18:58 -0400
Message-ID: <20110523211857.GE6281@sigill.intra.peff.net>
References: <1306171797211-6395441.post@n2.nabble.com>
 <1306184704408-6396225.post@n2.nabble.com>
 <1306185443823-6396282.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: funeeldy <Marlene_Cote@affirmednetworks.com>
X-From: git-owner@vger.kernel.org Mon May 23 23:19:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOcWo-0007X5-Sk
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 23:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757587Ab1EWVTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 17:19:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47687
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757379Ab1EWVTA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 17:19:00 -0400
Received: (qmail 23745 invoked by uid 107); 23 May 2011 21:21:04 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 17:21:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 17:18:58 -0400
Content-Disposition: inline
In-Reply-To: <1306185443823-6396282.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174278>

On Mon, May 23, 2011 at 02:17:23PM -0700, funeeldy wrote:

> Is there any way a checkout would not warn about modified and untracked
> files, and then proceed to lose them all? 

Git checkout -f ?

-Peff
