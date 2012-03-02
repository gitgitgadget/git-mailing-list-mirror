From: greened@obbligato.org (David A. Greene)
Subject: Re: git-subtree Ready #2
Date: Thu, 01 Mar 2012 21:42:37 -0600
Message-ID: <87mx7zk6s2.fsf@smith.obbligato.org>
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
	<87ty2ft0tm.fsf@smith.obbligato.org>
	<7vobsk56md.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 04:45:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3JQy-00080x-BU
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 04:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757814Ab2CBDp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 22:45:26 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:53983 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752645Ab2CBDpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 22:45:25 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1S3JRv-0001zM-HL; Thu, 01 Mar 2012 21:46:31 -0600
In-Reply-To: <7vobsk56md.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 27 Feb 2012 13:06:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > and everybody
    (including me) now favors to have the history. > > So the answer to your
   question is yes, but I do not think we heard opinion > from anybody regarding
    the question by Avery yet. I personally do not see > how it would help us
    if the old history is rewritten at this point. [...] 
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191994>

Junio C Hamano <gitster@pobox.com> writes:

> and everybody (including me) now favors to have the history.
>
> So the answer to your question is yes, but I do not think we heard opinion
> from anybody regarding the question by Avery yet.  I personally do not see
> how it would help us if the old history is rewritten at this point.

Looks like eveyone's on board to keep the history as-is.  I cleaned a
few things up and will re-post the subtree once the test-lib.sh 
changes go through.

                        -Dave
