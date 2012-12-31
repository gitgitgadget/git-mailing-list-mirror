From: greened@obbligato.org
Subject: Re: [PATCH] Add --unannotate option to git-subtree
Date: Mon, 31 Dec 2012 17:19:46 -0600
Message-ID: <87ehi54xnx.fsf@waller.obbligato.org>
References: <CABVa4NinSighUn7GKbzMx9qZj3Ao2dCtEZxUqCPwO9TocZ8Kkg@mail.gmail.com>
	<CABVa4NgdaiwfTvFe1CU+24QF-BA45tM2e3+9e2PJ_4ecuD0Cyg@mail.gmail.com>
	<5082FC72.4000608@initfour.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Nylen <jnylen@gmail.com>, git@vger.kernel.org
To: Herman van Rink <rink@initfour.nl>
X-From: git-owner@vger.kernel.org Tue Jan 01 00:20:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpof3-0007gm-UK
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 00:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960Ab2LaXUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 18:20:25 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48189 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750820Ab2LaXUX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 18:20:23 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1Tpolg-00052D-3x; Mon, 31 Dec 2012 17:27:40 -0600
In-Reply-To: <5082FC72.4000608@initfour.nl> (Herman van Rink's message of
	"Sat, 20 Oct 2012 21:33:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Herman van Rink <rink@initfour.nl> writes: >> Has anybody
   looked at this? >> >> It has been very useful for me. I am looking at it now.
    [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212367>

Herman van Rink <rink@initfour.nl> writes:

>> Has anybody looked at this?
>>
>> It has been very useful for me.

I am looking at it now.

> The version of subtree in contrib is rather out-dated unfortunately.

It is the official version.  What's missing?  You have a bunch of
changes that need rework to include into "mainline" but other than that
I am not aware of any major missing pieces.  If there are such changes I
would very much like to get them integrated

> Your patch looks interesting though. I can see how this could be useful.

> I've collected a bunch of patches in
> https://github.com/helmo/git/tree/subtree-updates

I hope you will submit your changes for inclusion.  Again, I'm not a
gatekeeper but I do want the patches to have proper testcases and
integrate into contrib/subtree.

                         -David
