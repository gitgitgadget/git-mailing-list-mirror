From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] get_tree_entry: map blank requested entry to tree root
Date: Tue, 9 Jan 2007 19:57:50 -0500
Message-ID: <20070110005750.GA18242@coredump.intra.peff.net>
References: <20070109161147.GA9313@coredump.intra.peff.net> <7vk5zviwxa.fsf@assigned-by-dhcp.cox.net> <20070110004633.GA14345@coredump.intra.peff.net> <7vac0rhf6g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Rmt-0008R8-Jo
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbXAJA5x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbXAJA5x
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:57:53 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4376 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932603AbXAJA5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:57:52 -0500
Received: (qmail 28052 invoked from network); 9 Jan 2007 19:58:04 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 9 Jan 2007 19:58:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jan 2007 19:57:50 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac0rhf6g.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36452>

On Tue, Jan 09, 2007 at 04:57:11PM -0800, Junio C Hamano wrote:

> I've noticed this while looking at your patch and fixed it in my
> tree already.

Thanks, I will stop looking, then. :)

-Peff
