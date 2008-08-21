From: "Mike Gant" <mwgant@gmail.com>
Subject: Re: [RFC v2] Git User's Survey 2008
Date: Wed, 20 Aug 2008 21:22:29 -0600
Message-ID: <8f282e3b0808202022w68fa2ad6s6e07c1d77d5ea139@mail.gmail.com>
References: <200807230325.04184.jnareb@gmail.com>
	 <200808200308.26308.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 05:23:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0m9-0000xg-Pz
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 05:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758685AbYHUDWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 23:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758192AbYHUDWa
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 23:22:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:11528 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758676AbYHUDW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 23:22:29 -0400
Received: by rv-out-0506.google.com with SMTP id k40so756546rvb.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 20:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AWTG+AujtP4wOkcAo0JL62JOgaQ0dqhj8KDw5JKDYG0=;
        b=MX/4utMy8yK1zJQk6yMjiyDKVuIAOdkigdtlTEEBPvgjGhPVFFRtntd9F87gtrMskg
         Q3g4vlm53eZJ9V1V0BpKuA7Np1QJLVYH42lMc9wWttgm/65z2mS7XJu/8Z6CDZyKXNAY
         XxFAdhhEI1O6BQV5miyiT+KsMSxME8i8Mibkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iMR5aGsbVHrIGnmiz0zCpnPNSyzSzPGaKREMys1xWQKrfzSd9HDeWvNBY1Q4ktmrvk
         MXgLxgYm2ruh7hR2+weJntrqfINuuSqixdGrAsD8us+ZNCOvuef48WTngq5yICH1wqfx
         DnVNZjTTrV/oP4Zmfii5SBHrJHasKfCxCQzHc=
Received: by 10.115.50.5 with SMTP id c5mr978806wak.60.1219288949072;
        Wed, 20 Aug 2008 20:22:29 -0700 (PDT)
Received: by 10.115.108.8 with HTTP; Wed, 20 Aug 2008 20:22:29 -0700 (PDT)
In-Reply-To: <200808200308.26308.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93104>

On Tue, Aug 19, 2008 at 7:08 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> This is second revision (version) of proposed questions
> for Git User's Survey 2008.
>
>
[snip]

>   xx. Which programming languages you are proficient with?
>       (zero or more: multiple choice)
>     - C, shell, Perl, Python, Tcl/Tk, C++, C#, Java, PHP,
>       Ruby, Emacs Lisp, Common Lisp or Scheme, Visual Basic,
>       Delphi, Assembly, other (please specify), I am not programmer
>     ! C, shell, Perl, Python, Tcl/Tk
>     + First version included only programming languages used
>       by git, and some from contrib area

Please include an "others" selection that will except a comma
list of languages. I'm an FPGA designer and use Verilog and
VHDL but I know they wouldn't be a common choice.

Mike
