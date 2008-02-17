From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 17 Feb 2008 10:10:50 -0800
Message-ID: <7v7ih31mj9.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
 <7vodavd9qw.fsf@gitster.siamese.dyndns.org>
 <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
 <7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
 <7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
 <7vejbc44hu.fsf@gitster.siamese.dyndns.org> <1203263316.6601.3.camel@futex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Kestenholz <mk@spinlock.ch>
X-From: git-owner@vger.kernel.org Sun Feb 17 19:11:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQnzL-0006Mk-G5
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 19:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbYBQSLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 13:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbYBQSLI
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:11:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbYBQSLF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 13:11:05 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 04B5B67C6;
	Sun, 17 Feb 2008 13:10:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 5D3E167C4; Sun, 17 Feb 2008 13:10:53 -0500 (EST)
In-Reply-To: <1203263316.6601.3.camel@futex> (Matthias Kestenholz's message
 of "Sun, 17 Feb 2008 16:48:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74150>

Matthias Kestenholz <mk@spinlock.ch> writes:

> On Sat, 2008-02-16 at 19:59 -0800, Junio C Hamano wrote:
>> [...]
>
> What about color.ui? I am still interested in a single central
> configuration variable to enable colored output from git. I know that I
> sent a proposal patch at a bad time.

Yeah, I liked the general idea, and was about to forget.  I
vaguely recall there was a design disagreement between you and
Jeff King (perhaps others as well)?

I appreciate a reminder like your message, but I do not want to
be in the business of fishing for old patches that may or may
not { apply to | work well with } the updated base anymore for
everybody.  I wish I had the mental bandwidth to do so, but it
simply becomes infeasible in the longer run.

Could you (and anybody who has "sent but about to be or
suspected to be forgotten" changes) respin, retest and resend
please?
