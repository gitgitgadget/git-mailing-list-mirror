From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH RFC 0/5] Patches to avoid reporting conversion changes.
Date: Sun, 18 Apr 2010 00:47:34 +0200
Message-ID: <g2xfabb9a1e1004171547we6a74176v4a697ded96e9f115@mail.gmail.com>
References: <cover.1271432034.git.grubba@grubba.org> <874ojbqnry.fsf@jondo.cante.net> 
	<86ljcnclvu.fsf@red.stonehenge.com> <87eiid6fjc.fsf@jondo.cante.net> 
	<86eiidan59.fsf@red.stonehenge.com> <n2kfabb9a1e1004171507r3f51d18bq3ff60831370f9b10@mail.gmail.com> 
	<m3iq7pemnw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 00:48:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Gnx-0001fa-Ct
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 00:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab0DQWr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 18:47:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:65032 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460Ab0DQWr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 18:47:56 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1096610fga.1
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 15:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=Bwbpj4w5A7SbJDv1doEXAQ3R4xvFtBNFNPtQPloELQg=;
        b=JJ2NcY2k2o99gkPS5qVHAjj3uBaZinlNxS292x+WmxqqdYOCNHKwBdJRFycob+QfBj
         Q7LiPRaa1r9gFOHCa25wkoaGg76IaWew/ZPGCeY/mTrui71e9H0EKwFtMBRWsUvJz5tH
         zcrddpj7K7p5JT5/KbEaYPHb1ItFWYsngHbP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=P+iViFucQYsNtNpdgne2n0014W34fX5nyrtIk23YWgL8EbyzRnLHWIqsWYuWDKo7Nf
         crt1gT40gx/CW10sM6HCQbd2g24DbIMG3qi1H3AaAsXDpq+EwnyENEyPDBa9diWZNeT0
         JzcmGsaOhvvz4WHeTVgOBrfrDMyUkKH+5KxEQ=
Received: by 10.103.168.14 with HTTP; Sat, 17 Apr 2010 15:47:34 -0700 (PDT)
In-Reply-To: <m3iq7pemnw.fsf@localhost.localdomain>
Received: by 10.103.126.36 with SMTP id d36mr2249382mun.65.1271544474080; Sat, 
	17 Apr 2010 15:47:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145189>

Heya,

On Sun, Apr 18, 2010 at 00:32, Jakub Narebski <jnareb@gmail.com> wrote:
> We use idiomatic C, e.g.

Agreed.

> We use idiomatic Perl, e.g.

Ah, I thought that the discussion was about whether the "$_" syntax
was idiomatic or not. It got the impression that the "$ARG etc. is a
failed experiment" was Randal's personal opinion, but if that's how
the perl community has decided that things should be done than that's
of course how we should do it :).

-- 
Cheers,

Sverre Rabbelier
