From: Jeff King <peff@peff.net>
Subject: Re: Make the ftplugin right wrt gitdir
Date: Wed, 18 Oct 2006 05:02:32 -0400
Message-ID: <20061018090231.GA18807@coredump.intra.peff.net>
References: <11611319762395-git-send-email-madcoder@debian.org> <11611324463754-git-send-email-madcoder@debian.org> <20061018070239.GD3507@coredump.intra.peff.net> <200610181010.59995.madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 11:02:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga7Ju-0003An-BT
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 11:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWJRJCf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 05:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWJRJCf
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 05:02:35 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:31896 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751168AbWJRJCf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 05:02:35 -0400
Received: (qmail 5692 invoked from network); 18 Oct 2006 05:02:32 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 18 Oct 2006 05:02:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Oct 2006 05:02:32 -0400
To: Pierre Habouzit <madcoder@debian.org>
Content-Disposition: inline
In-Reply-To: <200610181010.59995.madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29207>

On Wed, Oct 18, 2006 at 10:10:59AM +0200, Pierre Habouzit wrote:

> > Looks like the patch is missing (more sleep required?).
> 
> err, the patch is here: 
> <1161132446703-git-send-email-madcoder@debian.org>

Right, that's the "be more robust" patch which applies on top of
something else (presumably "nice ftplugin for vim"), but the last one I
got of that (<11611319761977-git-send-email-madcoder@debian.org>) causes
vim errors and you immediately followed up with "that's still not the
good one." Where is that patch?

-Peff
