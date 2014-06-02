From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] Git v2.0.0
Date: Mon, 02 Jun 2014 09:24:09 +0200
Message-ID: <871tv7bwpy.fsf@fencepost.gnu.org>
References: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com>
	<53866e8562b7a_12a7a052f87a@nysa.notmuch>
	<20140529185311.GB10865@sigill.intra.peff.net>
	<5388fb283edaf_bd8167d3002b@nysa.notmuch>
	<87k392e0mf.fsf@fencepost.gnu.org>
	<20140602063607.GA27445@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-fc@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 09:59:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrN9k-0001je-Kk
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 09:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbaFBH7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 03:59:40 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:50011 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbaFBH7k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 03:59:40 -0400
Received: from localhost ([127.0.0.1]:49051 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WrN9e-0006th-So; Mon, 02 Jun 2014 03:59:39 -0400
Received: by lola (Postfix, from userid 1000)
	id D2F18E05E7; Mon,  2 Jun 2014 09:24:09 +0200 (CEST)
In-Reply-To: <20140602063607.GA27445@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 2 Jun 2014 02:36:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250559>

Jeff King <peff@peff.net> writes:

> On Sat, May 31, 2014 at 11:52:24AM +0200, David Kastrup wrote:
>
>> Some mailing list filters and/or spam filters flag mails with too many
>> recipients so that they need to pass through moderation first.  The
>> typical threads on this list are short and have few recipients while
>> longer threads, due to the list policy of adding every participants to
>> the Cc, will tend to have more recipients.
>
> AFAIK, vger does not do anything like this. They block HTML, messages
> lacking a message-id, messages over 100K, and certain taboo phrases:
>
>   http://vger.kernel.org/majordomo-info.html#taboo
>
> And anyway, I do not think vger is responsible here. The messages were
> delivered through the list, and other archives have them. This looks
> like a gmane problem.

I am reading more than one list through Gmane/nntp, and in the last
years it was not infrequent that delivery paused for even days and/or
spurious old messages from the last day or even more were getting
redelivered.

> According to gmane.org, their admins will look manually at messages
> flagged as spam, but I find it unlikely that they flagged several days
> worth of git traffic (and when they do, I think they cross-post them
> to a spam group in NNTP, and the messages do not seem to be marked as
> such). So I think this really is just a bug.

Quite so.  In particular when other mirrors got the messages timely.

-- 
David Kastrup
