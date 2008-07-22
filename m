From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [FYI PATCH] git wrapper: DWIM mistyped commands
Date: Wed, 23 Jul 2008 01:10:22 +0200
Message-ID: <bd6139dc0807221610o7da154f9r9011753a9dc7588f@mail.gmail.com>
References: <alpine.DEB.1.00.0807222100150.8986@racer>
	 <7vwsjdjz9e.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:11:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLR0t-00038E-Qe
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 01:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbYGVXKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 19:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbYGVXKX
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 19:10:23 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:46386 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbYGVXKX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 19:10:23 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2455109wfd.4
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 16:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=N6IizdXXOg1oxDOzkqDII63/G5Ah+EGvVfvTN1u3BtQ=;
        b=sXbENGmt2i6it39Qv5FyIo+K6XwZs7XLxOMJqvsvMGOVxb+uEtOvN/3fQFQbDSAQVm
         UVNH+mcIAaETapZ/P1IAUGryvwsDHD/n1wFZipmLOTJQCA9vIQyOy9gk2SQbcW0pQndd
         i5hYhlKxfZhJMzLiwWJwPAACwQazduWDvDhrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=VQovA9l3GD/f032l07nom0yZORMIWqEW8lTaCzZ5kEKhmBd0AdDlfGbOF0NzCmNThj
         xD5Q+MVJY5wdWcFKi2RoqlTaIuQsIyL1+E17vFWvPNU80Tcb5G33RXu/Yn9p+9JYcGK1
         T/KioS9hr3tfXt5LV8kBAg9n8AgoR3sDN/EQY=
Received: by 10.142.89.13 with SMTP id m13mr2062667wfb.338.1216768222833;
        Tue, 22 Jul 2008 16:10:22 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 22 Jul 2008 16:10:22 -0700 (PDT)
In-Reply-To: <7vwsjdjz9e.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89559>

On Wed, Jul 23, 2008 at 1:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>       So I mistyped 'reabse' for the hundred trillionth time, but I
>>       will never have to correct my mistakes again.
>>
>>       Note: this patch is _not_ meant for inclusion.
>
> Heh, I do "git emrge" all the time ;-)
>
> Time to start a "gitster private edition" branch for my own use, I guess.

If it is the same typo all the time, wouldn't aliasses do the trick?

-- 
Cheers,

Sverre Rabbelier
