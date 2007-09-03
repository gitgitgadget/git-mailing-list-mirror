From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Mon, 03 Sep 2007 02:10:09 -0700
Message-ID: <7vlkboktce.fsf@gitster.siamese.dyndns.org>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
	<46DA5F33.2020005@zytor.com> <85odgltrtj.fsf@lola.goethe.zz>
	<46DA88EF.7080103@zytor.com>
	<20070902133803.1b46f599.seanlkml@sympatico.ca>
	<7v4picpvgq.fsf@gitster.siamese.dyndns.org>
	<20070902191644.29d46cd2.seanlkml@sympatico.ca>
	<46DBBD00.5090308@zytor.com>
	<7vr6lgmao5.fsf@gitster.siamese.dyndns.org>
	<46DBC1EE.3020009@zytor.com>
	<7vfy1wm9ik.fsf@gitster.siamese.dyndns.org>
	<46DBCA31.5010607@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 11:10:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS7wz-0002TM-9R
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 11:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbXICJKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 05:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbXICJKT
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 05:10:19 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbXICJKS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 05:10:18 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E82FE12D867;
	Mon,  3 Sep 2007 05:10:32 -0400 (EDT)
In-Reply-To: <46DBCA31.5010607@zytor.com> (H. Peter Anvin's message of "Mon,
	03 Sep 2007 09:47:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57458>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Junio C Hamano wrote:
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>>
>>>> Ok, should I then do that single change, cut 1.5.3.1 with it and
>>>> ping you?
>>> Sounds good to me.
>>
>> Thanks, and sorry for the trouble.  I am building one on k.org,
>> and after placing the result in the RPMS/x86-64 and running the
>> yummy script, I'll ping you again.  If it installs fine for you,
>> I'll boot my wife's machine to do i386 as well, but it is
>> getting a bit late now, so it might have to be tomorrow.
>
> git.kernel.org is actually an i386 machine (the only one we have left), too.

Ok, I did the same for i386, up to "yummy" part.  Could you take
care of the rest of the installation procedure, please?
