From: greened@obbligato.org
Subject: Re: [PATCH 1/8] Use %B for Split Subject/Body
Date: Tue, 01 Jan 2013 16:25:39 -0600
Message-ID: <871ue4h76k.fsf@waller.obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
	<1357012655-24974-2-git-send-email-greened@obbligato.org>
	<87wqvxv96q.fsf@waller.obbligato.org>
	<7vpq1pbg1k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 23:26:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqAI6-0005gQ-0y
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 23:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab3AAW0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 17:26:16 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48582 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752439Ab3AAW0O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 17:26:14 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TqAOu-0001EP-MY; Tue, 01 Jan 2013 16:33:36 -0600
In-Reply-To: <7vpq1pbg1k.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 31 Dec 2012 21:58:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > Also, please
   be careful about the subject line. I doubt that these > 8 patches will stand
    out as relating to "contrib/subtree", when mixed > in 200 line output of
   "git shortlog --no-merges". [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212462>

Junio C Hamano <gitster@pobox.com> writes:

> Also, please be careful about the subject line.  I doubt that these
> 8 patches will stand out as relating to "contrib/subtree", when mixed
> in 200 line output of "git shortlog --no-merges".

Ah, ok.  I'll be more careful next time.

                          -David
