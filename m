From: Jeff King <peff@peff.net>
Subject: Re: git-completion.bash --local
Date: Mon, 11 Feb 2013 16:04:55 -0500
Message-ID: <20130211210455.GB32740@sigill.intra.peff.net>
References: <85E0E68E8961D64E9200C534AC5E1B240A443EDC@RED-INF-EXMB-P1.esri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Dasa Paddock <dpaddock@esri.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:05:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U50Z0-0007ez-GI
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 22:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759743Ab3BKVE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 16:04:58 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44594 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759563Ab3BKVE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 16:04:58 -0500
Received: (qmail 26952 invoked by uid 107); 11 Feb 2013 21:06:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 16:06:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 16:04:55 -0500
Content-Disposition: inline
In-Reply-To: <85E0E68E8961D64E9200C534AC5E1B240A443EDC@RED-INF-EXMB-P1.esri.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216088>

On Sat, Feb 09, 2013 at 06:37:28PM +0000, Dasa Paddock wrote:

> I think this line should include --local:
> 
> https://github.com/git/git/blob/next/contrib/completion/git-completion.bash#L1782
>     "--global|--system|--file=*)"

Yeah, I think that makes sense.

Care to prepare a patch?

-Peff
