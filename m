From: greened@obbligato.org
Subject: Re: [PATCH] subtree.sh: Use raw subject and body modifier "%B" instead of "%s%n%n%b"
Date: Mon, 31 Dec 2012 21:59:17 -0600
Message-ID: <87han1wo2y.fsf@waller.obbligato.org>
References: <1344561358-2953-1-git-send-email-techlivezheng@gmail.com>
	<1344561358-2953-2-git-send-email-techlivezheng@gmail.com>
	<87zk5pdn43.fsf@waller.obbligato.org>
	<87mwwt4yp4.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, apenwarr@gmail.com
To: Techlive Zheng <techlivezheng@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 05:00:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpt1S-00010e-Qh
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 05:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501Ab3AAD75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 22:59:57 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48349 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751450Ab3AAD74 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 22:59:56 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1Tpt8D-0005p9-Da; Mon, 31 Dec 2012 22:07:13 -0600
In-Reply-To: <87mwwt4yp4.fsf@waller.obbligato.org> (greened@obbligato.org's
	message of "Mon, 31 Dec 2012 16:57:27 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  greened@obbligato.org writes: > I've applied this patch to
    my working copy but I'm not finding that I > can recreate the original problem
    when the patch is disabled. ^ not -David [...] 
 Content analysis details:   (-0.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212410>

greened@obbligato.org writes:

> I've applied this patch to my working copy but I'm not finding that I
> can recreate the original problem when the patch is disabled.
     ^ not

                          -David
