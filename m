From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: ks/precompute-completion (was Re: What's cooking in git.git (Oct 
	2009, #04; Wed, 21))
Date: Fri, 23 Oct 2009 13:27:18 -0500
Message-ID: <fabb9a1e0910231127i3ab469qebdc17168a58f22a@mail.gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <4AE0190E.8020803@gmail.com> 
	<fabb9a1e0910221011r957246dx3162cd675ff16800@mail.gmail.com> 
	<4AE0DAB3.1030103@gmail.com> <fabb9a1e0910221555k287b45ebwb15ac97851b845f9@mail.gmail.com> 
	<fabb9a1e0910221556s694a344ag8e5ae07c35351ee4@mail.gmail.com> 
	<4AE0E542.8010501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Stephen Boyd <bebarino@gmail.com>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Fri Oct 23 20:27:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1Orh-0002mf-00
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 20:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbZJWS1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 14:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752574AbZJWS1f
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 14:27:35 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:63910 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbZJWS1e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 14:27:34 -0400
Received: by ewy4 with SMTP id 4so1900081ewy.37
        for <git@vger.kernel.org>; Fri, 23 Oct 2009 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=+JjDVht0fHqK1mz7cKUNOdavtMGiYIurq58uGYeU7Io=;
        b=hh5WqFNRFS462AWREFtLZYWN/F4n6n9c9kYm88qoDwCExWjuBxogU4mojlu60+5+lm
         7G4JpuKNdywuTOgRSm0jG/Bm4mS3FLnLApM5SPfGNJr0cl/N6ovO5Kc/LYrMURperMeP
         rjC+p2RGcOpkdAGGenZGmADQzlwpZR1xZ+B5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JRXprBIwpJUFMd0FHS0Fmk+IDg9ifg2MMQEWdhuoG21XNJfI4V6SrPhTCYb4gR9yuC
         eIVgNXn4osRUa5neApFCrKC2YWQByGE7ra9/QAqlF+4YwTgwP21UqbJ52b7byK36gvPn
         mSRru6F9Vt6ROi7YGtrcwZ3lH6XouPo4o392M=
Received: by 10.216.87.16 with SMTP id x16mr3956607wee.106.1256322458078; Fri, 
	23 Oct 2009 11:27:38 -0700 (PDT)
In-Reply-To: <4AE0E542.8010501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131112>

Heya,

On Thu, Oct 22, 2009 at 18:05, A Large Angry SCM <gitzilla@gmail.com> wrote:
> Your original email included 'make && make install'; it's the "make install"
> part I'm concerned about.

Ah, no, I meant that as part of my semi-regular git update (during
which I do 'make && make install') I want to have up-to-date bash
completion, preferably installed somewhere system-wide; currently I am
forced to have a 'source
/home/sverre/code/git/contrib/completion/git-completion.bash' in my
.bashrc,..

-- 
Cheers,

Sverre Rabbelier
