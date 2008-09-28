From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] Docs: send-email: Added all config variables to
	man end
Date: Sun, 28 Sep 2008 15:08:33 -0400
Message-ID: <20080928190833.GA32418@coredump.intra.peff.net>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu> <1222564196-84202-2-git-send-email-mfwitten@mit.edu> <1222564196-84202-3-git-send-email-mfwitten@mit.edu> <1222564196-84202-4-git-send-email-mfwitten@mit.edu> <1222564196-84202-5-git-send-email-mfwitten@mit.edu> <1222564196-84202-6-git-send-email-mfwitten@mit.edu> <1222564196-84202-7-git-send-email-mfwitten@mit.edu> <20080928031822.GB15696@sigill.intra.peff.net> <C886DB88-EA48-4608-A9DB-B8A11C1240B2@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 28 21:09:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kk1eK-0007DR-Vu
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 21:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbYI1TIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 15:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbYI1TIf
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 15:08:35 -0400
Received: from peff.net ([208.65.91.99]:2422 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbYI1TIf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 15:08:35 -0400
Received: (qmail 7962 invoked by uid 111); 28 Sep 2008 19:08:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 28 Sep 2008 15:08:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Sep 2008 15:08:33 -0400
Content-Disposition: inline
In-Reply-To: <C886DB88-EA48-4608-A9DB-B8A11C1240B2@MIT.EDU>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96985>

On Sun, Sep 28, 2008 at 02:03:42PM -0500, Michael Witten wrote:

>> Maybe it is better to simply make a note of that (or
>> mention it in the --foo section).
>
> Then it would be better to do away with all but
>
> 	sendemail.aliasesfile
> 	sendemail.aliasfile
>
> which sounds OK with me.

Yes, that was exactly what I meant (but I hadn't bothered to see how
many, if any, options didn't directly correspond to a command line
option).

-Peff
