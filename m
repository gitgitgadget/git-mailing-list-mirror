From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow passing of configuration parameters in the command 
	line
Date: Sat, 20 Mar 2010 17:03:36 +0100
Message-ID: <81b0412b1003200903gb6923e1ved6de423db97b28@mail.gmail.com>
References: <81b0412b1003190742v6e5577c9wb121d5e3cbc9fccd@mail.gmail.com>
	 <7vbpejkmo5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 17:03:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt19P-0003Hd-60
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 17:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab0CTQDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 12:03:42 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:44308 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200Ab0CTQDl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 12:03:41 -0400
Received: by bwz1 with SMTP id 1so773826bwz.21
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=w/f5wPqr1bFlCHEms55SLkViUgkdVtlzmwGH4KvyydY=;
        b=Ep1CU3q5BB5WV+2LjzomNZ0tu7hKMYVCLsUxBCX5dbxWOnjquPgfLUOzsE8BPL5sDB
         0MBaxMpKTWvgYZNcjJqwGmHpsHakPVLMMGaw+fjbHYDRT8SpWb5ZRNUJbg7HCd9Lx2OG
         jPlHFmUAEnkxlHHxXUHNgCauxyItrfmPYSRhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=MObE5qkW4enBG/oEBQf5ubaZkYlJ450EUIG/QW68uQymwl8OVNhW0Jw4y3Xa2fhz6g
         aeuw086dNRlmNfCuUSGXIYdcThsKqGmXjs/Tl/DfVE/qHgETrmrEO8EV8LtAsIxrnbVs
         SW6iGyclWcd3GZ4X5BXDbzxqpLa9qSyOmCoxw=
Received: by 10.204.138.81 with SMTP id z17mr1950347bkt.49.1269101016807; Sat, 
	20 Mar 2010 09:03:36 -0700 (PDT)
In-Reply-To: <7vbpejkmo5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142723>

On Sat, Mar 20, 2010 at 17:00, Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> The values passed this way will override whatever is defined
>> in the config files.
>
> You sent MIME multipart-mixed and I am getting a broken patch.
>
> How could this be... If I cannot expect to reliably get a non-linewrapped
> patch, there doesn't seem to be much point in you and I taking extra time
> to bother with MIME.

That's gmail, again. There must be an attachment with a normal patch,
but I'll resend.
