From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] Clarify the documentation of options with
 optional arguments
Date: Sat, 19 Sep 2015 06:50:43 -0400
Message-ID: <20150919105043.GA23464@sigill.intra.peff.net>
References: <1442588510-7379-1-git-send-email-Matthieu.Moy@imag.fr>
 <1442648870-22511-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org,
	Alastair McGowan-Douglas <altreus@altre.us>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Sep 19 12:50:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdFjK-0001wX-CI
	for gcvg-git-2@plane.gmane.org; Sat, 19 Sep 2015 12:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbbISKur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2015 06:50:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:33530 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750811AbbISKuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2015 06:50:46 -0400
Received: (qmail 25151 invoked by uid 102); 19 Sep 2015 10:50:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 19 Sep 2015 05:50:47 -0500
Received: (qmail 15744 invoked by uid 107); 19 Sep 2015 10:50:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 19 Sep 2015 06:50:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Sep 2015 06:50:43 -0400
Content-Disposition: inline
In-Reply-To: <1442648870-22511-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278238>

On Sat, Sep 19, 2015 at 09:47:47AM +0200, Matthieu Moy wrote:

> Changes since v2:
> 
> * Typo in commit message
> 
> * key-id -> keyid in more places. Not so important, but we had cases
>   where SYNOPSYS was saying key-id and the full doc keyid, let's make
>   it more uniform (and more grep-able).
> 
> * Document what --sign-commit and --open-in-pager do when the optional
>   argument is not specified.
> 
> Matthieu Moy (3):
>   Documentation: use 'keyid' consistently, not 'key-id'
>   Documentation/grep: fix documentation of -O
>   Documentation: explain optional arguments better

This all looks good to me.

-Peff
