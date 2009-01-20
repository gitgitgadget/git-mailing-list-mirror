From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #04; Mon, 19)
Date: Tue, 20 Jan 2009 09:18:10 -0500
Message-ID: <20090120141810.GA10688@sigill.intra.peff.net>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <20090120044021.GE30714@sigill.intra.peff.net> <49758367.7040706@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 15:21:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPHSf-0006jp-Bk
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 15:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762264AbZATOST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 09:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762891AbZATOSS
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 09:18:18 -0500
Received: from peff.net ([208.65.91.99]:60243 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761198AbZATOSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 09:18:16 -0500
Received: (qmail 1838 invoked by uid 107); 20 Jan 2009 14:18:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 20 Jan 2009 09:18:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2009 09:18:10 -0500
Content-Disposition: inline
In-Reply-To: <49758367.7040706@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106474>

On Tue, Jan 20, 2009 at 08:55:19AM +0100, Johannes Sixt wrote:

> >   - the test needs a few tweaks to be portable to Windows
> 
> While this is true, the workaround I have in my tree is so ugly that its
> discussion would hold back this series unnecessarily. So, please don't
> wait for the fixup of the test.

My goal was to just accept multiple exit codes in the test. I'll cc you
when I send out the new one, and you can comment.

-Peff
