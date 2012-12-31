From: greened@obbligato.org
Subject: Re: Bug/Enhancement: contrib/subtree should ship with manpage
Date: Mon, 31 Dec 2012 17:13:44 -0600
Message-ID: <87ip7h4xxz.fsf@waller.obbligato.org>
References: <CANC5J9HSSuc0OchdoVyQKLhXbLapej714LN3pjG=er4BBm0zoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neil <kngspook@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 00:14:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpoZF-0003KU-Ja
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 00:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab2LaXOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 18:14:25 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48182 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751070Ab2LaXOX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 18:14:23 -0500
X-Greylist: delayed 977 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Dec 2012 18:14:23 EST
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1Tpofs-0004zy-GW; Mon, 31 Dec 2012 17:21:40 -0600
In-Reply-To: <CANC5J9HSSuc0OchdoVyQKLhXbLapej714LN3pjG=er4BBm0zoA@mail.gmail.com>
	(Neil's message of "Mon, 8 Oct 2012 15:33:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Neil <kngspook@gmail.com> writes: > Actual: git-subtree.1
   fails to be generated because my system doesn't ship > asciidoc and xmlto.
    Well, you need those tools to build ANY git documentation. I just ran a test
    to build git-subtree and its documentation and it went just fine. This is
    not a bug. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted h 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212365>

Neil <kngspook@gmail.com> writes:

> Actual: git-subtree.1 fails to be generated because my system doesn't ship
> asciidoc and xmlto.

Well, you need those tools to build ANY git documentation.  I just ran a
test to build git-subtree and its documentation and it went just fine.
This is not a bug.

                              -Dave
