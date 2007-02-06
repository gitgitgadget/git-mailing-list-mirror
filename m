From: Michael <barra_cuda@katamail.com>
Subject: Re: [PATCH] Documentation: add KMail in SubmittingPatches
Date: Tue, 6 Feb 2007 14:45:07 +0100
Message-ID: <200702061445.07657.barra_cuda@katamail.com>
References: <7v1wl7bv66.fsf@assigned-by-dhcp.cox.net> <200702051427.32532.barra_cuda@katamail.com> <7vveigkmpv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 06 14:39:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEQXm-0006nX-Ls
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 14:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbXBFNj1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 08:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbXBFNj1
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 08:39:27 -0500
Received: from slim-3a.inet.it ([213.92.5.124]:55976 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbXBFNj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 08:39:26 -0500
Received: from dial-up-mi-727.lombardiacom.it ([::ffff:212.34.227.219]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:212.34.227.219+hk8idDWpe3; Tue, 06 Feb 2007 14:39:03 +0100
User-Agent: KMail/1.9.4
In-Reply-To: <7vveigkmpv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38839>

Junio C Hamano:
> Michael <barra_cuda@katamail.com> writes:
> > @@ -331,3 +330,21 @@ whitespaces (fatal in patches).  Running 'C-u g' to
> > display the
> >  message in raw form before using '|' to run the pipe can work
> >  this problem around.
[...]
> This is quite interesting -- notice your own hunk header @@ ... @@ line?

I see. It's this account's fault: now I know because I've tried with
another account. I didn't know it had this glitch, sorry.

> I do not use KMail myself, so I cannot comment on the procedure,
> but from the cursory look it *should* do the right thing.  Only
> that it makes me a bit nervous to see your hunk header being
> line wrapped.
>
> Doubly interesting is that somebody appears to have added two
> message IDs.
>
>    Subject: [PATCH] Documentation: add KMail in SubmittingPatches
>    Date:	Mon, 5 Feb 2007 14:27:32 +0100
>    User-Agent: KMail/1.9.4
>    Message-Id: <200702051427.32532.barra_cuda@katamail.com>
>    Message-ID: <20070205132150.123659@dial-up-mi-449.lombardiacom.it>

This is my current account's fault too. So I used KMail correctly,
but my mail server did something to the message. I guess I should
use another account. Anyway, if some other KMail user has something
to say about this issue, it will make things clearer.

Bye.
