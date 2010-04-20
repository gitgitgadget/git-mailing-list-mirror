From: Zefram <zefram@fysh.org>
Subject: Re: ghost refs
Date: Tue, 20 Apr 2010 14:14:47 +0100
Message-ID: <20100420131447.GN17930@lake.fysh.org>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com> <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com> <20100407210010.GB27012@coredump.intra.peff.net> <loom.20100420T085842-887@post.gmane.org> <20100420115124.GB22907@coredump.intra.peff.net> <20100420120228.GM17930@lake.fysh.org> <20100420150015.4bd80387@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Tue Apr 20 15:15:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4DI3-00021U-VB
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 15:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab0DTNOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 09:14:52 -0400
Received: from lake.fysh.org ([81.94.195.195]:40158 "EHLO lake.fysh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644Ab0DTNOv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 09:14:51 -0400
Received: from zefram by lake.fysh.org with local (Exim 4.69 #1 (Debian))
	id 1O4DHr-0003Y8-Br; Tue, 20 Apr 2010 14:14:47 +0100
Content-Disposition: inline
In-Reply-To: <20100420150015.4bd80387@chalon.bertin.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145374>

Yann Dirson wrote:
>Another option than adding a sequence number would be to move back the
>dead_refs/ log back to refs/ when the branch is creating again.

Yes, that also makes sense.  Pick one model or the other.  A mixture
would *not* make sense.

-zefram
