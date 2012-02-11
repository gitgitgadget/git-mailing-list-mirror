From: greened@obbligato.org (David A. Greene)
Subject: Re: git-subtree Ready #2
Date: Sat, 11 Feb 2012 13:22:01 -0600
Message-ID: <87mx8pkwfa.fsf@smith.obbligato.org>
References: <877gztmfwy.fsf@smith.obbligato.org>
	<7v8vk9mem4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 20:24:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwIYd-0002l6-Sa
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 20:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab2BKTYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 14:24:20 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:50107 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754324Ab2BKTYS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 14:24:18 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1RwIbZ-0007sz-Ku; Sat, 11 Feb 2012 13:27:30 -0600
In-Reply-To: <7v8vk9mem4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 11 Feb 2012 10:03:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > greened@obbligato.org
    (David A. Greene) writes: > >> I might need to fiddle with permissions, let
    me know. > > Everybody's client can talk smart http these days. Please don't
    > host/publish the code behind a dumb HTTP server. [...] 
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190531>

Junio C Hamano <gitster@pobox.com> writes:

> greened@obbligato.org (David A. Greene) writes:
>
>> I might need to fiddle with permissions, let me know.
>
> Everybody's client can talk smart http these days. Please don't
> host/publish the code behind a dumb HTTP server.

I'll have to learn how to set up a smart http.

In the meantime, this should also work:

git clone git://sources.obbligato.org/git/git.git

Or via gitweb:

http://sources.obbligato.org

                               -Dave
