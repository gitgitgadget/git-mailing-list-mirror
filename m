From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/4] Introduce diff.submodule
Date: Thu, 15 Nov 2012 08:23:34 -0800
Message-ID: <20121115162331.GD6157@sigill.intra.peff.net>
References: <http://mid.gmane.org/1352653146-3932-1-git-send-email-artagnon@gmail.com>
 <1352821367-3611-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:24:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ2EK-0001ph-QJ
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 17:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768344Ab2KOQXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 11:23:38 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49523 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992633Ab2KOQXi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 11:23:38 -0500
Received: (qmail 17610 invoked by uid 107); 15 Nov 2012 16:24:26 -0000
Received: from m8c0536d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.5.140)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Nov 2012 11:24:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2012 08:23:34 -0800
Content-Disposition: inline
In-Reply-To: <1352821367-3611-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209825>

On Tue, Nov 13, 2012 at 09:12:43PM +0530, Ramkumar Ramachandra wrote:

> v1 is here: http://mid.gmane.org/1349196670-2844-1-git-send-email-artagnon@gmail.com
> v2 is here: http://mid.gmane.org/1351766630-4837-1-git-send-email-artagnon@gmail.com
> v3 is here: http://mid.gmane.org/1352653146-3932-1-git-send-email-artagnon@gmail.com
> 
> This version was prepared in response to Peff's review of v3.
> What changed:
> * Functional code simplified and moved to git_diff_ui_config.
> * Peff contributed one additional patch to the series.

Thanks, this version looks good to me.

-Peff
