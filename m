From: greened@obbligato.org
Subject: Re: [PATCH 3/7] contrib/subtree: Add --unannotate
Date: Tue, 22 Jan 2013 02:37:42 -0600
Message-ID: <87liblfwa1.fsf@waller.obbligato.org>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org>
	<1357646997-28675-4-git-send-email-greened@obbligato.org>
	<7vehhvecoy.fsf@alter.siamese.dyndns.org>
	<87vcaxq0ez.fsf@waller.obbligato.org>
	<87y5ftojoj.fsf@waller.obbligato.org>
	<7vy5ftzr3s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, James Nylen <jnylen@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 09:38:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxZNX-0000rB-PS
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 09:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548Ab3AVIi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 03:38:26 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:37822 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752263Ab3AVIiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 03:38:25 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TxZNA-0002ZE-SM; Tue, 22 Jan 2013 02:38:25 -0600
In-Reply-To: <7vy5ftzr3s.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 15 Jan 2013 20:31:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > greened@obbligato.org
    writes: > >> greened@obbligato.org writes: >> >>>> I think this paragraph
    inherits existing breakage from the beginning >>>> of time, but I do not
   think the above will format the second and >>>> subsequent paragraphs correctly.
    >>> >>> Ok, I'll take a look. >> >> I don't know what "correctly" is but
   it is at least formatted in a >> similar manner to the other options. > >
   That is what "inherits existing breakage" means ;-) [...] 
 Content analysis details: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214219>

Junio C Hamano <gitster@pobox.com> writes:

> greened@obbligato.org writes:
>
>> greened@obbligato.org writes:
>>
>>>> I think this paragraph inherits existing breakage from the beginning
>>>> of time, but I do not think the above will format the second and
>>>> subsequent paragraphs correctly.
>>>
>>> Ok, I'll take a look.
>>
>> I don't know what "correctly" is but it is at least formatted in a
>> similar manner to the other options.
>
> That is what "inherits existing breakage" means ;-)

Ah.

> The first paragraph is typeset as body text, while the rest are
> typeset in monospaced font, no?
>
> It should be more like this, I think:
>
>         --option::
>                 First paragraph
>         +
>         Second paragraph
>         +
>         And third paragraph

Ok.

                          -David
