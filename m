From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH 2/3] Allow help.htmlpath to be an http: URL
Date: Fri, 29 Jun 2012 00:39:15 +0100
Message-ID: <20120628233915.GB2765@arachsys.com>
References: <7vwr2s5f9v.fsf@alter.siamese.dyndns.org>
 <20120627225248.GB27566@sigill.intra.peff.net>
 <20120628065623.GB1742@arachsys.com>
 <20120628175041.GA4731@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 29 01:39:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkOJ0-0003Aj-QU
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 01:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910Ab2F1XjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 19:39:19 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:55238 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab2F1XjS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 19:39:18 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SkOIu-0003bl-HB; Fri, 29 Jun 2012 00:39:16 +0100
Content-Disposition: inline
In-Reply-To: <20120628175041.GA4731@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200801>

Jeff King <peff@peff.net> writes:

> I think the "://" one is my preference. I just looked over your v3
> series, and the patches look good to me.

Thanks, and thanks for suggesting the much nicer :// heuristic.

Best wishes,

Chris.
