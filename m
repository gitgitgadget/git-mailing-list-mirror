From: Jeff King <peff@peff.net>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 02:36:07 -0400
Message-ID: <20071020063607.GA30572@coredump.intra.peff.net>
References: <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu> <20071019031959.GE14735@spearce.org> <20071019032407.GA10622@coredump.intra.peff.net> <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU> <20071019033500.GB10697@coredump.intra.peff.net> <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU> <20071019034704.GB11095@coredump.intra.peff.net> <1192859748.13347.146.camel@g4mdd.entnet> <20071020062400.GA30388@coredump.intra.peff.net> <FF5A82CA-8AE3-4E1C-872D-26D938933E1B@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Oct 20 08:36:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij7wd-0006jc-5U
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 08:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760640AbXJTGgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 02:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758741AbXJTGgK
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 02:36:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1556 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760414AbXJTGgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 02:36:09 -0400
Received: (qmail 19050 invoked by uid 111); 20 Oct 2007 06:36:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 20 Oct 2007 02:36:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Oct 2007 02:36:07 -0400
Content-Disposition: inline
In-Reply-To: <FF5A82CA-8AE3-4E1C-872D-26D938933E1B@MIT.EDU>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61795>

On Sat, Oct 20, 2007 at 02:34:49AM -0400, Michael Witten wrote:

> The first method is wrong, because I wasn't considering the fact that
> he may have already staged something.

Yes, I also didn't consider that, which is what led me to wonder what
his use case could possibly be. And thus we were both confused.

-Peff
