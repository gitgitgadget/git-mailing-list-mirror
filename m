From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (May 2012, #02; Fri, 4)
Date: Thu, 10 May 2012 09:12:55 -0400
Message-ID: <20120510131255.GA2950@sigill.intra.peff.net>
References: <7vhavv8s2d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 15:13:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSTB4-0006YA-Qp
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 15:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931Ab2EJNM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 09:12:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38709
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898Ab2EJNM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 09:12:57 -0400
Received: (qmail 27847 invoked by uid 107); 10 May 2012 13:13:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 May 2012 09:13:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2012 09:12:55 -0400
Content-Disposition: inline
In-Reply-To: <7vhavv8s2d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197560>

On Fri, May 04, 2012 at 04:06:18PM -0700, Junio C Hamano wrote:

> --------------------------------------------------
> [Graduated to "master"]
> 
> * jk/maint-push-progress (2012-05-01) 3 commits
>   (merged to 'next' on 2012-05-01 at 2286130)
>  + t5541: test more combinations of --progress
>  + teach send-pack about --[no-]progress
>  + send-pack: show progress when isatty(2)
> 
> "git push" over smart-http lost progress output and this resurrects it.
> 
> Will merge to 'master'.

I noticed that this graduated to master, but not to maint. Any reason?

-Peff
