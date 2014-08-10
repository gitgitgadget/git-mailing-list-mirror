From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Aug 2014, #02; Fri, 8)
Date: Sat, 9 Aug 2014 22:42:17 -0400
Message-ID: <20140810024217.GA3246@peff.net>
References: <xmqq1tsqk4m4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 04:42:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGJ5f-00029d-Sa
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 04:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbaHJCm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2014 22:42:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:49188 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751631AbaHJCm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2014 22:42:28 -0400
Received: (qmail 18658 invoked by uid 102); 10 Aug 2014 02:42:28 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (204.237.18.137)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 09 Aug 2014 21:42:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Aug 2014 22:42:17 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tsqk4m4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255085>

On Fri, Aug 08, 2014 at 03:18:11PM -0700, Junio C Hamano wrote:

> * jk/pack-bitmap (2014-08-04) 1 commit
>  - pack-bitmap: do not use gcc packed attribute
> 
>  Will merge to 'next'.

You may want to hold off on merging this; I hope Karsten will re-roll
his neater replacement patch next week, which would replace it
completely.

-Peff
