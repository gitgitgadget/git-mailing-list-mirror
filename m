From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] merge: add instructions to the commit message when editing
Date: Tue, 31 Jan 2012 08:46:04 +0100
Message-ID: <87k4488gcj.fsf@thomas.inf.ethz.ch>
References: <7vd3a1caxb.fsf@alter.siamese.dyndns.org>
	<0c9a880c7dca27520f957446c6b0e72e93609b03.1327954927.git.trast@student.ethz.ch>
	<7vy5soaons.fsf@alter.siamese.dyndns.org>
	<878vkoamu3.fsf@thomas.inf.ethz.ch>
	<7vhazcamdl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 08:46:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rs8Pu-000744-58
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 08:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176Ab2AaHqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 02:46:11 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:17331 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752881Ab2AaHqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 02:46:08 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 31 Jan
 2012 08:46:05 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 31 Jan
 2012 08:46:05 +0100
In-Reply-To: <7vhazcamdl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 30 Jan 2012 13:52:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189443>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>>>   Please enter the commit message for your merge commit.  Explain
>>>   why the merge is necessary, especially if it merges an updated
>>>   upstream into a topic branch.
>>>
>>> ... because people who need to be told to "justify it" would probably be
>>> helped by a more explicit "explain _why_ it is needed".
>>
>> Why not.  The "explain..." might be construed as a bit too coercive, but
>> I cannot come up with a way to defuse it (well, except again tacking on
>> "you should") ...
>
> Would "Please enter the commit message for your merge commit, to explain
> why ..." work?

Yes, though it winds up as a rather long sentence.  I could then shorten
it to

  Please enter a commit message that explains why the merge commit is
  necessary, especially if it merges an updated upstream into a topic
  branch.

though that's only _implying_ that you're completing a merge.

Your pick ;-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
