From: greened@obbligato.org
Subject: Re: What's cooking in git.git (Feb 2013, #05; Tue, 12)
Date: Mon, 18 Feb 2013 14:21:46 -0600
Message-ID: <877gm54bl1.fsf@waller.obbligato.org>
References: <7v621xdql8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:23:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7XEr-0004Ty-Jq
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 21:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757350Ab3BRUWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 15:22:37 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:45236 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757317Ab3BRUWg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 15:22:36 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U7XGK-0008QR-Hn; Mon, 18 Feb 2013 14:24:33 -0600
In-Reply-To: <7v621xdql8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 12 Feb 2013 16:06:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > * dg/subtree-fixes
    (2013-02-05) 6 commits > (merged to 'next' on 2013-02-09 at 8f19ebe) > +
   contrib/subtree: make the manual directory if needed > + contrib/subtree:
   honor DESTDIR > + contrib/subtree: fix synopsis > + contrib/subtree: better
    error handling for 'subtree add' > + contrib/subtree: use %B for split subject/body
    > + contrib/subtree: remove test number comments > > contrib/subtree updates,
    but here are only the ones that looked > ready to be merged to 'next'. For
   
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216515>

Junio C Hamano <gitster@pobox.com> writes:

> * dg/subtree-fixes (2013-02-05) 6 commits
>   (merged to 'next' on 2013-02-09 at 8f19ebe)
>  + contrib/subtree: make the manual directory if needed
>  + contrib/subtree: honor DESTDIR
>  + contrib/subtree: fix synopsis
>  + contrib/subtree: better error handling for 'subtree add'
>  + contrib/subtree: use %B for split subject/body
>  + contrib/subtree: remove test number comments
>
>  contrib/subtree updates, but here are only the ones that looked
>  ready to be merged to 'next'.  For the remainder, they will have
>  another day.

Great, I've got updates for the rest.

                       -David
