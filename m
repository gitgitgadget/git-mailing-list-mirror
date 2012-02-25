From: greened@obbligato.org (David A. Greene)
Subject: Re: git-subtree Ready #2
Date: Sat, 25 Feb 2012 09:00:37 -0600
Message-ID: <87ty2ft0tm.fsf@smith.obbligato.org>
References: <877gztmfwy.fsf@smith.obbligato.org>
	<8739acra5j.fsf@smith.obbligato.org>
	<20120215050855.GB29902@sigill.intra.peff.net>
	<87sjicpsr1.fsf@smith.obbligato.org>
	<87ty2ro1zf.fsf@smith.obbligato.org>
	<20120220205346.GA6335@sigill.intra.peff.net>
	<7vd399jdwc.fsf@alter.siamese.dyndns.org>
	<CAHqTa-2s1xbAfNvjD7cXBe2TBMs1985nag1NOYVfE+dATvfEWA@mail.gmail.com>
	<7vobsox84l.fsf@alter.siamese.dyndns.org>
	<CAHqTa-1fbi5W7R2fLu3bp7Yuv_ZB9nxhgjHkLGuU8-V4016+JA@mail.gmail.com>
	<87hayfv75y.fsf@smith.obbligato.org>
	<7vy5rrfft2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 16:04:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1JAW-0005vj-Bx
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 16:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756715Ab2BYPDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 10:03:43 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:51856 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756697Ab2BYPDm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 10:03:42 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1S1JAL-0004XB-6E; Sat, 25 Feb 2012 09:04:05 -0600
In-Reply-To: <7vy5rrfft2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 25 Feb 2012 01:00:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: >> I'm happy to
    do either (rebase or filter-branch). Just let me know. > > I would understand
    Avery's "should we filter-branch/rebase, or is it OK > as-is?", but I do
   not understand what you mean by "either rebase or > filter-branch is fine".
    [...] 
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191535>

Junio C Hamano <gitster@pobox.com> writes:

>> I'm happy to do either (rebase or filter-branch).  Just let me know.
>
> I would understand Avery's "should we filter-branch/rebase, or is it OK
> as-is?", but I do not understand what you mean by "either rebase or
> filter-branch is fine".

Sorry, got mixed up there.  I'm not that familiar with filter-branch.
Now I understand you do both.  :)

So have we decided to keep the history?

                                 -Dave
