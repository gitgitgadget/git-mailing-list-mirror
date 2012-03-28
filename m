From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Use SHELL_PATH to fork commands in run_command.c:prepare_shell_cmd
Date: Wed, 28 Mar 2012 19:28:03 -0400
Message-ID: <1332977205-sup-469@pinkfloyd.chass.utoronto.ca>
References: <20120326182427.GA10333@sigill.intra.peff.net> <1332816078-26829-1-git-send-email-bwalton@artsci.utoronto.ca> <20120327032917.GB17338@sigill.intra.peff.net> <1332901381-sup-4406@pinkfloyd.chass.utoronto.ca> <20120328042215.GB30251@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	jrnieder <jrnieder@gmail.com>, gitster <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 01:28:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD2Hj-0002Ya-PW
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 01:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247Ab2C1X2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 19:28:07 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:55586 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933155Ab2C1X2F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 19:28:05 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:36164 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SD2Hb-0004h3-LC; Wed, 28 Mar 2012 19:28:03 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SD2Hb-0007ZV-K5; Wed, 28 Mar 2012 19:28:03 -0400
In-reply-to: <20120328042215.GB30251@sigill.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194219>

Excerpts from Jeff King's message of Wed Mar 28 00:22:15 -0400 2012:

> Yeah, I think so (not that I am the final word, but that at least
> matches my perception of the discussion so far, too).

Ok, I just sent the updated patch.  Thanks to everyone that has
provided feedback on this so far.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
