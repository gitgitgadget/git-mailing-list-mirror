From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Support for git aliasing for tcsh completion
Date: Wed, 28 Nov 2012 02:56:49 +0100
Message-ID: <CAMP44s1FTn==aK9i9G_N=DOv-F6CmrQ6KJEYvuRijSsByMb8wQ@mail.gmail.com>
References: <1353989472-4142-1-git-send-email-marc.khouzam@gmail.com>
	<CAFj1UpE5V5fKtt0fFOXLPrsQdOL8xpvzT=66Qi3=cMHit092Rg@mail.gmail.com>
	<7v38zvnez8.fsf@alter.siamese.dyndns.org>
	<CAFj1UpGipsewPRiumtuit5FKU2-CGMp3zgh48E3wdj=g4FWAOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 02:57:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdWtg-0000uO-Ok
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889Ab2K1B4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:56:52 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40941 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab2K1B4u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:56:50 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so11587084obb.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 17:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lCmK9nAcTRNXpbV88qpIOaaTk1p4M1dXOmzbUT0qj3o=;
        b=NTNc9Y99ayhQZREpHbIH5rskB/d8RGiFV3afW6MV36S0CMklEj19+NfRcaV1Mvdwmy
         buhBweA+Hn30D+tpV7l+fYl/FxiOmOf4wkHMPScPZWJ2x2kEFArN5YlMr4S4qy6Wxu+H
         FgeQlEcNj3sAPNyCBg2vh8rC8RfO5QZqq9xhMXIxonIrB6jMPfuuTLuPARSa1NF76dro
         yK6+J/REoZyj113w9Fqi5M2K6xRXEDjFZcMDUGSVF1endU7FOrKyb2+fJxoQ6IUhtfM4
         9zxyL3eOFToRS09RcRdCchq148Fl9+qrwhLQvUVf/v/vw8bKqfE/JJ9f8a5Asdx7EEM2
         W0mQ==
Received: by 10.60.31.6 with SMTP id w6mr14639755oeh.65.1354067809731; Tue, 27
 Nov 2012 17:56:49 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 17:56:49 -0800 (PST)
In-Reply-To: <CAFj1UpGipsewPRiumtuit5FKU2-CGMp3zgh48E3wdj=g4FWAOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210663>

On Wed, Nov 28, 2012 at 2:39 AM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
> On Tue, Nov 27, 2012 at 12:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> The patch was linewrapped so I had to fix it up;
>
> Sorry about that.  I don't know if it is gmail, or the fact that I use
> its web interface
> that causes these problems.
>
>> please double check
>> what will be queued on 'pu' to make sure that I did not miss
>> necessary whitespaces or added unnecessary ones when I rejoined long
>> lines.
>
> I just checked it and it looks great.
>
> I'm working on another improvement to the script but I don't have it working
> yet.  But I should not bother you much after that.

You might want to use msmtp to send mails with Gmail, that's what I do:
https://git.wiki.kernel.org/index.php/GitTips#Using_msmtp_to_send_your_patches

-- 
Felipe Contreras
