From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Sanity-ckeck config variable names
Date: Fri, 21 Jan 2011 11:23:19 -0500
Message-ID: <20110121162318.GC21840@sigill.intra.peff.net>
References: <20110119141112.GD8034@fm.suse.cz>
 <20110120232232.GA9442@sigill.intra.peff.net>
 <20110121000629.GA7773@sigill.intra.peff.net>
 <20110108144644.GA11019@localhost.suse.cz>
 <20110111055922.GD10094@sigill.intra.peff.net>
 <20110119100105.GB8034@fm.suse.cz>
 <20110119141112.GD8034@fm.suse.cz>
 <20110120232232.GA9442@sigill.intra.peff.net>
 <20110121100212.GE19715@fm.suse.cz>
 <20110121102339.GG19715@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Libor Pechacek <lpechacek@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jan 21 17:23:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgJln-0007YT-9j
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 17:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046Ab1AUQXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 11:23:22 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34689 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880Ab1AUQXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 11:23:21 -0500
Received: (qmail 19725 invoked by uid 111); 21 Jan 2011 16:23:21 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 21 Jan 2011 16:23:21 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jan 2011 11:23:19 -0500
Content-Disposition: inline
In-Reply-To: <20110121102339.GG19715@fm.suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165379>

On Fri, Jan 21, 2011 at 11:23:39AM +0100, Libor Pechacek wrote:

> Sanity-ckeck config variable names when adding and retrieving them.  As a side

Typo: s/ckeck/check/

Other than that, this version looks good to me.

Acked-by: Jeff King <peff@peff.net>

-Peff
