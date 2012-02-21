From: greened@obbligato.org (David A. Greene)
Subject: Re: git-subtree Ready #2
Date: Mon, 20 Feb 2012 23:31:22 -0600
Message-ID: <87ipj0wy51.fsf@smith.obbligato.org>
References: <877gztmfwy.fsf@smith.obbligato.org>
	<8739acra5j.fsf@smith.obbligato.org>
	<20120215050855.GB29902@sigill.intra.peff.net>
	<87sjicpsr1.fsf@smith.obbligato.org>
	<87ty2ro1zf.fsf@smith.obbligato.org>
	<20120220205346.GA6335@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 21 06:33:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RziMM-0001RQ-LD
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 06:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804Ab2BUFdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 00:33:50 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:50065 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750765Ab2BUFdt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 00:33:49 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1RziMg-0006jF-Bv; Mon, 20 Feb 2012 23:34:14 -0600
In-Reply-To: <20120220205346.GA6335@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 20 Feb 2012 15:53:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Jeff King <peff@peff.net> writes: > Of course there's no real
    reason we can't take it slow by putting it in > contrib, and then graduating
    from there. It just seems like an > unnecessary and complicated interim step.
    Either way, I do think it's > worth saving the commit history by doing a
   real merge. [...] 
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through tr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191133>

Jeff King <peff@peff.net> writes:

> Of course there's no real reason we can't take it slow by putting it in
> contrib, and then graduating from there. It just seems like an
> unnecessary and complicated interim step. Either way, I do think it's
> worth saving the commit history by doing a real merge.

I have no problem starting off in contrib.  I was asking more about the
logistics of getting there.

> As a non-user, I am totally fine with it. I think the burden is not that
> high, and you have already promised to deal with ongoing maintenance
> issues.

Indeed, I'm more than happy to help with maintenance.  I have one or two
fixes/enhancements on my list, in fact.

                              -Dave
