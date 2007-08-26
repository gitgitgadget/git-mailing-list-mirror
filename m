From: Junio C Hamano <gitster@pobox.com>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls? etc.
Date: Sat, 25 Aug 2007 22:33:35 -0700
Message-ID: <7vsl66svv4.fsf@gitster.siamese.dyndns.org>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com>
	<7v1wdqud0z.fsf@gitster.siamese.dyndns.org>
	<52E107D8068148B795FB4279B6272B8E@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 07:34:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPAlM-0002YK-CQ
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 07:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbXHZFds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 01:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbXHZFds
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 01:33:48 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbXHZFdr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 01:33:47 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E3D5126D29;
	Sun, 26 Aug 2007 01:34:04 -0400 (EDT)
In-Reply-To: <52E107D8068148B795FB4279B6272B8E@ntdev.corp.microsoft.com>
	(Dmitry Kakurin's message of "Sat, 25 Aug 2007 22:17:26 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56675>

Dmitry Kakurin <dmitry.kakurin@gmail.com> writes:

> ----- Original Message ----- 
> From: "Junio C Hamano" <gitster@pobox.com>
>>> 2. Storing metadata in regular source-controlled files feels wrong to
>>> me.
>> You are free to _feel_ whatever you want without thinking, but
>
> I did quite a bit of thinking before posting it. Not sure what made you think otherwise.
>
>>  I think reading from
>> index as a fallback measure when work tree file is missing is a
>> very good compromise we came up recently.
>
> Can you specify _exactly_ how it works now? And I'll show you a bunch of corner cases where it's broken.

As I made it clear, it is a compromise.  I am not interested in
discussing corner cases with you -- I am sure there are.

If you are offering improvements, I am all ears.
