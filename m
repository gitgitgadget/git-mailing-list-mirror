From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: [PATCH 0/6] manual: Fix or remove em dashes.
Date: Tue, 9 Oct 2007 23:02:01 +0100
Message-ID: <18071eea0710091502y3b70231dnd4270a3155af91a8@mail.gmail.com>
References: <20071009205755.GB31317@ins.uni-bonn.de>
	 <20071009210530.GH31317@ins.uni-bonn.de>
	 <18071eea0710091441n717c0a99p58a9b585d15cc778@mail.gmail.com>
	 <20071009215255.GB3146@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ralf Wildenhues" <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 00:02:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfN9f-0007Lp-17
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 00:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbXJIWCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 18:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833AbXJIWCH
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 18:02:07 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:47560 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbXJIWCE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 18:02:04 -0400
Received: by fk-out-0910.google.com with SMTP id z23so6375fkz
        for <git@vger.kernel.org>; Tue, 09 Oct 2007 15:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BPR8mci/L/DCqS8Y0f9KLb6xr9mT5gpglsQnurWuDBQ=;
        b=HiHhUydbN1T7Dzg0EvZ5EYDV67OBlKiBthAepo9wXeenfYJIXxUkYBJUZ1A59p/I+IMcaUWkkdgUv6joR3HLlK/jUlzzNZ1aLV6B455Nk1dMy5PG3SIar0t+JSQZ/hFXCncUZmo4leb9aa2kUaOWI3sp99DV7JOFwUeClN8wgPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Df9CLlUqyuyvg2AtvkgKc8Hu3DECDnoRnJoYhBK1LOFNGOsLbPo9SLVRPUjCkxjW5ldygNzFzFlS234BiEA8ofDbW3ei3mfYZlITK1cyOD0bU30YHcazK7GScLwakmYtBJLmz0FMpxVaUCgQ+PIiF6zGdMSyVac5Ar/touqasfE=
Received: by 10.82.171.16 with SMTP id t16mr19968439bue.1191967321745;
        Tue, 09 Oct 2007 15:02:01 -0700 (PDT)
Received: by 10.82.177.16 with HTTP; Tue, 9 Oct 2007 15:02:01 -0700 (PDT)
In-Reply-To: <20071009215255.GB3146@ins.uni-bonn.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60452>

On 09/10/2007, Ralf Wildenhues <Ralf.Wildenhues@gmx.de> wrote:
> Hello, and sorry, this patch should be number 6/6 of course.
>
> * Thomas Adam wrote on Tue, Oct 09, 2007 at 11:41:41PM CEST:
> > On 09/10/2007, Ralf Wildenhues <Ralf.Wildenhues@gmx.de> wrote:
> > > em dashes were used inconsistently in the manual.
> > > This changes them to the way they are used in US English.
> >
> > I find this particular patch to be rather odd; there is nothing
> > invalid in the way the em-dashes are used.
>
> No, not invalid, just inconsistent usage in the manual.
>
> > Why is it US English is somehow de facto over, say, proper English?
> > :)
>
> Oh, that was written quoting from memory and experience.  But here's a
> quote to back it up, from <http://en.wikipedia.org/wiki/Dash> as of now:
>
> | According to most American sources (e.g., The Chicago Manual of Style)
> | and to some British sources (e.g., The Oxford Guide to Style), an em
> | dash should always be set closed (not surrounded by spaces). But the
> | practice in many parts of the English-speaking world[...] sets it
> | open [...]
>
> No, I did not write that!  ;-)

Well, I don't see why it needs to change, to be honest.  I use
em-dashes all the time surrounded by spaces, as do many academics.
The fact that may here in the UK do not use the letter z in place of s
to satisfy the OSD is also of equal testament to this.

-- Thomas Adam
