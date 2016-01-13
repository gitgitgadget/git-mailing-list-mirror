From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH 0/7] contrib/subtree: Testsuite cleanup
Date: Tue, 12 Jan 2016 21:32:39 -0600
Message-ID: <87twminoh4.fsf@waller.obbligato.org>
References: <1447381956-4771-1-git-send-email-greened@obbligato.org>
	<20151113152320.GA8336@dell-note>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 04:33:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJCB7-0007vP-VQ
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 04:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbcAMDcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 22:32:48 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:58491 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754492AbcAMDcq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 22:32:46 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aJCC6-0001hy-HA; Tue, 12 Jan 2016 21:33:59 -0600
In-Reply-To: <20151113152320.GA8336@dell-note> (Alexey Shumkin's message of
	"Fri, 13 Nov 2015 18:23:20 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Alexey Shumkin <alex.crezoff@gmail.com> writes: > On Thu,
   Nov 12, 2015 at 08:32:29PM -0600, David Greene wrote: >> Sending again with
    a proper From: address after rebasing on latest master. >> >> Copying the
    maintainers because the origin patchset didn't get any >> comments and I'm
    unsure of how to proceed. >> >> These are some old changes I have lying around
    that should get applied >> to clean up git-subtree's testbase. With these
    changes post-mortem >> analysis is much easier and adding new tests can be
    done in an orderly >> fashion. >>  
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283875>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> On Thu, Nov 12, 2015 at 08:32:29PM -0600, David Greene wrote:
>> Sending again with a proper From: address after rebasing on latest master.
>> 
>> Copying the maintainers because the origin patchset didn't get any
>> comments and I'm unsure of how to proceed.
>> 
>> These are some old changes I have lying around that should get applied
>> to clean up git-subtree's testbase.  With these changes post-mortem
>> analysis is much easier and adding new tests can be done in an orderly
>> fashion.
>> 
>> I have a number of future patches and further development ideas for
>> git-subtree that require these changes as a prerequisite.
> Please, could you take a look to the following thread
> http://thread.gmane.org/gmane.comp.version-control.git/277343to take into account the mentioned bug for your futher work?
>
> Thank you

Just wanted to check in and let you know that I attempted to keep all of
the changes from the thread above.  Please let me know if I missed
something.  Thanks!

                        -David
