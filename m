From: Mirko Stocker <mirko.stocker@hsr.ch>
Subject: Re: Working with Git and CVS in a team.
Date: Mon, 16 Jun 2008 15:39:39 +0200
Organization: HSR
Message-ID: <200806161539.40007.mirko.stocker@hsr.ch>
References: <200806131633.34980.mirko.stocker@hsr.ch> <200806152222.50119.me@misto.ch> <20080615204841.GA10270@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 16 15:41:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8ExC-0006pJ-DN
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 15:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012AbYFPNjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 09:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755718AbYFPNjq
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 09:39:46 -0400
Received: from luc80-74-131-252.ch-meta.net ([80.74.131.252]:55028 "EHLO
	lucius.metanet.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754689AbYFPNjp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 09:39:45 -0400
Received: (qmail 32711 invoked from network); 16 Jun 2008 15:39:43 +0200
Received: from unknown (HELO pin6108034.hsr.ch) (152.96.200.175)
  by luc80-74-131-153.ch-meta.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 16 Jun 2008 15:39:43 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080615204841.GA10270@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85189>

On Sunday 15 June 2008 22:48:41 Jeff King wrote:
> Sure. From the client perspective, there's not really a difference
> between a bare repo and one with a working directory. Using just one
> repo with a working directory will mean you just have one extra checkout
> on the server, which wastes a little space.

Ok, but in my case I have the checkout on the server in any case, whether I 
push it to the bare repository or use it directly.

Thanks again

Mirko
