From: Jeff King <peff@peff.net>
Subject: Re: packfile is unavailable/cannot be accessed
Date: Wed, 6 Apr 2011 20:47:08 -0400
Message-ID: <20110407004707.GA28813@sigill.intra.peff.net>
References: <loom.20110406T020617-993@post.gmane.org>
 <20110406154208.GC1864@sigill.intra.peff.net>
 <loom.20110407T015644-337@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Enchanter <ensoul.magazine@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 02:47:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7dNW-0007Up-HR
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 02:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756754Ab1DGArN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 20:47:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45340
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755619Ab1DGArM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 20:47:12 -0400
Received: (qmail 11547 invoked by uid 107); 7 Apr 2011 00:47:57 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Apr 2011 20:47:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2011 20:47:08 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110407T015644-337@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171029>

On Thu, Apr 07, 2011 at 12:01:28AM +0000, Enchanter wrote:

> 1. the bare repository is on the windows server
> 2. One developer use ubuntu with git 1.7.4.1 (Has the error message)
> 3. Another developer use windows XP with git 1.7.4.msysgit.0 (there's no errors)

How are they accessing the bare repo? Directly via a CIFS share, or by
git:// running on the Windows server?

-Peff
