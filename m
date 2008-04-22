From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fast forward strategies allow, never, and only
Date: Tue, 22 Apr 2008 00:48:50 -0700
Message-ID: <7vhcdu2uu5.fsf@gitster.siamese.dyndns.org>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
 <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
 <7vskym310l.fsf@gitster.siamese.dyndns.org>
 <402c10cd0803192347q7b4a3fb0s35737f361d53a86a@mail.gmail.com>
 <7vbq56ilnj.fsf@gitster.siamese.dyndns.org>
 <402c10cd0803252050u582111cag18674e0257ac2884@mail.gmail.com>
 <402c10cd0803302119r251b3a43te69ce2a52e121ba5@mail.gmail.com>
 <402c10cd0804191806h5460eb82y2442517343734b8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 09:49:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoDGC-0006Sp-SJ
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 09:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756577AbYDVHtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 03:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756500AbYDVHtF
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 03:49:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132AbYDVHtD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 03:49:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F4811F4D;
	Tue, 22 Apr 2008 03:49:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C48FE1F4B; Tue, 22 Apr 2008 03:48:58 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80077>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> On Sun, Mar 30, 2008 at 9:19 PM, Sverre Hvammen Johansen
> <hvammen@gmail.com> wrote:
>> I have attached a new set of patches to this email (to avoid
>>
>> line-wrapping issues if someone needs them for testing).  They are
>>  also posted inlined for comments.
>>
>>  The patch series consists of the following five patches:
>>
>>    0001-New-merge-tests.patch
>>    0002-Introduce-ff-fast-forward-option.patch
>>    0003-Restructure-git-merge.sh.patch
>>    0004-Head-reduction-before-selecting-merge-strategy.patch
>>    0005-Introduce-fast-forward-option-only.patch
>
> I consider myself finished with this and as far as I am concerned it
> can be applied to git.git.  I am currently using this on top of 1.5.5
> in production and assume it to be good.  All tests passes.

Sorry, but I am with a rather big backlog and am reluctant to go back the
archive a looong way to pick up and comment on a series when not many
people are wondering what happened to the wonderful series ;-)  Care to
resend and ask for comments from people?
