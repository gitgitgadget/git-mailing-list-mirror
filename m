From: greened@obbligato.org (David A. Greene)
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Tue, 12 Jan 2016 20:56:41 -0600
Message-ID: <874meip4pi.fsf@waller.obbligato.org>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 03:56:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJBcD-0001wT-Hl
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 03:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbcAMC4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 21:56:50 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:58476 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752740AbcAMC4t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 21:56:49 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aJBdJ-0001ev-Ac; Tue, 12 Jan 2016 20:58:01 -0600
In-Reply-To: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 11 Jan 2016 15:45:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > * dw/subtree-split-do-not-drop-merge
    (2015-12-10) 1 commit > - contrib/subtree: fix "subtree split" skipped-merge
    bug > > The "split" subcommand of "git subtree" (in contrib/) incorrectly
    > skipped merges when it shouldn't, which was corrected. > > Waiting for
   review from 'subtree' folks. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283872>

Junio C Hamano <gitster@pobox.com> writes:

> * dw/subtree-split-do-not-drop-merge (2015-12-10) 1 commit
>  - contrib/subtree: fix "subtree split" skipped-merge bug
>
>  The "split" subcommand of "git subtree" (in contrib/) incorrectly
>  skipped merges when it shouldn't, which was corrected.
>
>  Waiting for review from 'subtree' folks.

Just saw this one now.  I'm sorry I missed it.  I will go review the
latest version of that.

> * rm/subtree-unwrap-tags (2015-11-24) 1 commit
>  - contrib/subtree: unwrap tag refs
>
>  Waiting for review from subtree folks.

Looks good.  I just sent (very late) follow-up messages.

                          -David
