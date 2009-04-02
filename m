From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Broken t9001 tests
Date: Thu, 02 Apr 2009 11:07:18 -0700
Message-ID: <7v3acrexpl.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0904021520200.7464@intel-tinevez-2-302>
 <20090402134019.GA26699@coredump.intra.peff.net>
 <76718490904020714x3f00d5fu6f13587be383be1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 20:09:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpRLe-0001Nu-Cg
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 20:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761999AbZDBSHd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2009 14:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761072AbZDBSHc
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 14:07:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760029AbZDBSHb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 14:07:31 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2C5A5B663;
	Thu,  2 Apr 2009 14:07:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 57100B65F; Thu, 
 2 Apr 2009 14:07:25 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21A34680-1FB1-11DE-8002-781813508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115479>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Thu, Apr 2, 2009 at 9:40 AM, Jeff King <peff@peff.net> wrote:
> ...
> Sorry, as Jeff mentions:
>
>> Try
>>
>> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/115280
>
> And BTW, it's not as if I didn't test. The "going interactive" issue
> is hidden by bash. But don't worry, I've since downloaded and
> installed dash just for running git tests, so it won't happen again.
>
>> Junio seems to have picked up the first part of the series, but not =
this
>> fix. I'm not sure why.
>
> Junio, may I please draw you attention to 3/4 and 4/4 at the link
> above. Please amend the commit message for 3/4 though. It says it
> corrects commit 67f1fe5 which is wrong. Please sed
> 's/67f1fe5/c18f75a/' in that message.
>
> Thanks,

Thanks, all of you.  I have been swamped.
