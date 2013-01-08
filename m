From: greened@obbligato.org
Subject: Re: [PATCH 2/8] Add --unannotate
Date: Tue, 08 Jan 2013 04:42:45 -0600
Message-ID: <878v84lzve.fsf@waller.obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
	<1357012655-24974-3-git-send-email-greened@obbligato.org>
	<7v623ga8vs.fsf@alter.siamese.dyndns.org>
	<87sj6kfsbz.fsf@waller.obbligato.org>
	<7va9ss77bu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, James Nylen <jnylen@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 11:43:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsWep-0002qy-NL
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 11:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab3AHKn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 05:43:26 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:51726 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755918Ab3AHKnY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 05:43:24 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TsWm1-0003lO-Hc; Tue, 08 Jan 2013 04:51:13 -0600
In-Reply-To: <7va9ss77bu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 01 Jan 2013 16:32:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > greened@obbligato.org
    writes: > >> In the meantime, will you apply the patch or do you prefer a
    new design? > > The --unannotate option will become a baggage you will have
    to keep > working until the end of time, if we applied it. I think it is
   not > too uch a baggage, so it probably is OK. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_T 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212952>

Junio C Hamano <gitster@pobox.com> writes:

> greened@obbligato.org writes:
>
>> In the meantime, will you apply the patch or do you prefer a new design?
>
> The --unannotate option will become a baggage you will have to keep
> working until the end of time, if we applied it.  I think it is not
> too uch a baggage, so it probably is OK.

Ok.  I think it's worth applying since people find it useful.  It's not
very complicated.

                       -David
