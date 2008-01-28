From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to split a patch
Date: Mon, 28 Jan 2008 01:25:02 -0800
Message-ID: <7vhcgyuwsx.fsf@gitster.siamese.dyndns.org>
References: <4d8e3fd30801280105g2876cedfjbe1ba323ede57e0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git mailing list" <git@vger.kernel.org>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 10:25:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJQFL-0005gq-FV
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 10:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254AbYA1JZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 04:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755375AbYA1JZJ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 04:25:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131AbYA1JZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 04:25:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A88F6CB9;
	Mon, 28 Jan 2008 04:25:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F047D6CB8;
	Mon, 28 Jan 2008 04:25:03 -0500 (EST)
In-Reply-To: <4d8e3fd30801280105g2876cedfjbe1ba323ede57e0a@mail.gmail.com>
	(Paolo Ciarrocchi's message of "Mon, 28 Jan 2008 10:05:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71868>

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:

> I know ho to do the opposite process, rebase -i and squash is something
> I'm really used to do but this time that trick is not going to help me.
>
> What is the preferred way to split a big patch in a series of
> smaller patches?


I personally found the procedure described there a bit on the
sketchy side, but does "SPLITTING COMMITS" section of git-rebase
manual help?
