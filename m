From: Junio C Hamano <gitster@pobox.com>
Subject: Re: summaries in git add --patch
Date: Tue, 02 Dec 2008 18:15:54 -0800
Message-ID: <7vskp6j95x.fsf@gitster.siamese.dyndns.org>
References: <492F0CAD.3010101@gmail.com>
 <7viqq8adsf.fsf@gitster.siamese.dyndns.org> <492F92C9.7030301@gmail.com>
 <7v8wr48g98.fsf@gitster.siamese.dyndns.org> <49308B4B.3070703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 03:17:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7hIm-0008E7-Id
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 03:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbYLCCQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 21:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbYLCCQA
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 21:16:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbYLCCQA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 21:16:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EA8A183AFD;
	Tue,  2 Dec 2008 21:15:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 190BF83AFC; Tue,
  2 Dec 2008 21:15:55 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 530BF648-C0E0-11DD-8BCD-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102198>

William Pursell <bill.pursell@gmail.com> writes:

> Junio C Hamano wrote:
>> William Pursell <bill.pursell@gmail.com> writes:
>>
>>> Here's a new patch.  Instead of displaying the summary and then
>>> the current hunk, it implements a 'goto' command.
>>
>> I take it that this is for discussion not for immediate inclusion.
>
> Yes.  I tend to think of all of my patches as being merely
> for discussion since I'm not terribly familiar with the code
> base and expect to miss many things.  I'm flattered that
> you would even consider them for inclusion.  For that matter,
> I'm flattered that you have even responded to my submissions!

Thanks.  I value contributions from people who are enthused and can make a
good case for the change they propose.  I utter comments and sometimes
even send out an alternative implementation to illustrate what might be a
better approach.  IOW, I try to help people make progress.

One thing I will not do after such a discussion, unless I am really really
interested in having the new feature personally myself, is to go back to
the discussion thread and assemble the pieces together to make the final
series of patches for inclusion.  The responsibility for doing that lies
on the original contributor.
