From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's not in 'master' but should be
Date: Fri, 18 Jan 2008 02:24:57 -0800
Message-ID: <7vwsq7fn2e.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	<47893E1A.5020702@gmail.com>
	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	<8c5c35580801180215s2c980b4kbc66fbb05778ff67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 11:25:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFoPw-0005xF-LC
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 11:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253AbYARKZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 05:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756272AbYARKZL
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 05:25:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253AbYARKZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 05:25:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D7E08639C;
	Fri, 18 Jan 2008 05:25:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 42C5E639A;
	Fri, 18 Jan 2008 05:25:04 -0500 (EST)
In-Reply-To: <8c5c35580801180215s2c980b4kbc66fbb05778ff67@mail.gmail.com>
	(Lars Hjemli's message of "Fri, 18 Jan 2008 11:15:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70991>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On Jan 18, 2008 10:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> It seems that for the past few days, people were having too much
>> fun bashing how broken MacOS X is, and the real work has stalled
>> in the meantime.  Well, not really stalled but they certainly
>> made the patches and discussions harder to find in the list
>> archive.
>
> Here's a patch which might have been lost in the noise:
>
> http://thread.gmane.org/gmane.comp.version-control.git/70463

Not really.  It came late into rc cycle without fixing any
breakage.  Not 1.5.4 material.
