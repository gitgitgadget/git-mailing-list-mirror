From: greened@obbligato.org
Subject: Re: [PATCH] For git-subtree, when installing docs (make install-doc), create man1 folder first.
Date: Mon, 31 Dec 2012 21:06:08 -0600
Message-ID: <87zk0twqjj.fsf@waller.obbligato.org>
References: <1355429376-4192-1-git-send-email-lyager@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Jesper L. Nielsen" <lyager@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 04:07:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpsBy-0006kB-SW
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 04:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab3AADGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 22:06:45 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48297 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751279Ab3AADGo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 22:06:44 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TpsIk-0005bz-Bc; Mon, 31 Dec 2012 21:14:02 -0600
In-Reply-To: <1355429376-4192-1-git-send-email-lyager@gmail.com> (Jesper
	L. Nielsen's message of "Thu, 13 Dec 2012 21:09:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  "Jesper L. Nielsen" <lyager@gmail.com> writes: > So, small
    patch to create the folder first in the Makefile. Hope > everything is right
    with the patch and submitting of the patch. I've applied this to my local
    copy and will send it to the list for integration. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00     
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212398>

"Jesper L. Nielsen" <lyager@gmail.com> writes:

> So, small patch to create the folder first in the Makefile. Hope
> everything is right with the patch and submitting of the patch.

I've applied this to my local copy and will send it to the list for
integration.

Thanks for fixing this!

                         -David
