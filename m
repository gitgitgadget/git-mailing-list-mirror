From: greened@obbligato.org
Subject: Re: Subtree in Git
Date: Mon, 11 Jun 2012 20:32:48 -0500
Message-ID: <877gvdxqkf.fsf@smith.obbligato.org>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com>
	<20120504224312.GA99879@hyve.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Koester <dk@hyve.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 04:01:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeGQV-0000p5-F0
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 04:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab2FLCBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 22:01:44 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:37527 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751990Ab2FLCBm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 22:01:42 -0400
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1SeG5R-00036P-R4; Mon, 11 Jun 2012 20:40:02 -0500
In-Reply-To: <20120504224312.GA99879@hyve.org> (Daniel Koester's message of
	"Sat, 5 May 2012 00:50:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Daniel Koester <dk@hyve.org> writes: > i am afraid my english
    is not sufficient enough to fully grasp your > statement: > >> I also want
    to get at least one release under our belt. > > Could you please elaborate
    on this? [...] 
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199756>

Daniel Koester <dk@hyve.org> writes:

> i am afraid my english is not sufficient enough to fully grasp your
> statement:
>
>> I also want to get at least one release under our belt.
>
> Could you please elaborate on this?

Sorry about my use of English idioms.  :)

I want to make sure that we get an official git release with subtree in
contrib/ before we move it to the top level.  That way, we've gone
though a whole test/release cycle and are fairly confident it all works
correctly.

> I too would very much like to use git subtree, especially with the
> changes from gith.com/helmo/git and recommend it to
> friends/colleagues once/if it is merged into mainline.

Oh, me too.  We have the same goals!

                          -Dave
