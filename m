From: greened@obbligato.org
Subject: Re: [PATCH 1/8] Use %B for Split Subject/Body
Date: Mon, 31 Dec 2012 22:06:21 -0600
Message-ID: <87wqvxv96q.fsf@waller.obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
	<1357012655-24974-2-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 05:07:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpt8H-0006h0-3F
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 05:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab3AAEG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 23:06:59 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48359 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751324Ab3AAEG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 23:06:58 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TptF2-0005qA-N1; Mon, 31 Dec 2012 22:14:17 -0600
In-Reply-To: <1357012655-24974-2-git-send-email-greened@obbligato.org> (David
	A. Greene's message of "Mon, 31 Dec 2012 21:57:28 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  "David A. Greene" <greened@obbligato.org> writes: > From:
   Techlive Zheng <techlivezheng@gmail.com> > > Use %B to format the commit message
    and body to avoid an extra newline > if a commit only has a subject line.
    [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212412>

"David A. Greene" <greened@obbligato.org> writes:

> From: Techlive Zheng <techlivezheng@gmail.com>
>
> Use %B to format the commit message and body to avoid an extra newline
> if a commit only has a subject line.

Wow.  So that was a spectacular fail.  Sorry about th duplicate patch
e-mails.  I have no idea how that happened.

                        -David
