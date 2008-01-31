From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] filter-branch: only print usage information when no arguments supplied
Date: Wed, 30 Jan 2008 18:44:12 -0800
Message-ID: <7vwspqg1dv.fsf@gitster.siamese.dyndns.org>
References: <47A109A7.1070502@nrlssc.navy.mil>
	<47A112C5.8010903@nrlssc.navy.mil>
	<7v3asehj5s.fsf@gitster.siamese.dyndns.org>
	<47A12CF1.1010801@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jan 31 03:45:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKPQH-0000O7-MJ
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 03:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537AbYAaCoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 21:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756416AbYAaCoe
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 21:44:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594AbYAaCod (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 21:44:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EAE213350;
	Wed, 30 Jan 2008 21:44:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 33250334C;
	Wed, 30 Jan 2008 21:44:25 -0500 (EST)
In-Reply-To: <47A12CF1.1010801@nrlssc.navy.mil> (Brandon Casey's message of
	"Wed, 30 Jan 2008 20:05:37 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72093>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Junio C Hamano wrote:
>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>>>
>>> I prefer my original patch since I think it is consistent
>>> with the git interface.
>> 
>> I'd refrain from commenting on if it is consistent or not with
>> "the git interface".
>
> I'm not sure whether you're saying that _I_ should refrain from
> making comments about "git interface" consistencies?

No, I am just saying "I (Junio) is stupid and lazy, and I do not
want to think about it right now, so I will not judge on that
point".
