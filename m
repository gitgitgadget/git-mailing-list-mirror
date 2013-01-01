From: greened@obbligato.org
Subject: Re: [PATCH] DESTDIR support in contrib/subtree/Makefile
Date: Mon, 31 Dec 2012 20:58:17 -0600
Message-ID: <87a9sty5h2.fsf@waller.obbligato.org>
References: <20121129154057.GA4300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Tkac <atkac@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 03:59:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tps4S-0001Vx-9L
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 03:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab3AAC65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 21:58:57 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48285 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751358Ab3AAC64 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 21:58:56 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TpsBC-0005am-3q; Mon, 31 Dec 2012 21:06:14 -0600
In-Reply-To: <20121129154057.GA4300@redhat.com> (Adam Tkac's message of "Thu,
	29 Nov 2012 16:41:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Adam Tkac <atkac@redhat.com> writes: > Signed-off-by: Adam
    Tkac <atkac@redhat.com> > --- > > It is a good habit in Makefiles to honor
    DESTDIR variable to support > > `make DESTDIR=/instalroot install` > > syntax.
    > > Comments are welcomed. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Baye 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212395>

Adam Tkac <atkac@redhat.com> writes:

> Signed-off-by: Adam Tkac <atkac@redhat.com>
> ---
>
> It is a good habit in Makefiles to honor DESTDIR variable to support
>
> `make DESTDIR=/instalroot install`
>
> syntax.
>
> Comments are welcomed.

Applied.  I'll be sending this to the mailing list tonight or tomorrow.

                         -David
