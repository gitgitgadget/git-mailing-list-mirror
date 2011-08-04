From: Christian Jaeger <chrjae@gmail.com>
Subject: Re: [ANNOUNCE/RFC] cj-git-patchtool: a "rebase -i" with more interaction
Date: Thu, 4 Aug 2011 02:02:10 -0400
Message-ID: <CAEjYwfVfRyde=hzgPDrWgS2VMHWzk5kccDh3TYZTgQ=YXOyeYw@mail.gmail.com>
References: <CAEjYwfUY9tF_9frkaS7Aw26CPJA02Cr3HDN5Qpkup1rfHYacXw@mail.gmail.com>
 <m3d3gmrchz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 08:02:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qor0x-0002QC-SK
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 08:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab1HDGCc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 02:02:32 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49700 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab1HDGCa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2011 02:02:30 -0400
Received: by gxk21 with SMTP id 21so876501gxk.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 23:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MBM7+2TKy3Wk7/wsRg7ijylbKpu9WKt9KZRUecQxr44=;
        b=u3Wb5UEDSChJKqQ4Vg4BP4GzNzmbJeU7Cl3XkVPq1NFthsJG3ccjTE1u6XIlQGy9+Y
         oULfXBWQ81A8qvqrbUyjkOP1bnBW30VjhwBKoyNX9bGrKUXvYM+me3fT141sR9pgmRFg
         LeXVixFHugLBfJh4ggNJXcjhqG3LGj9pOt6wQ=
Received: by 10.151.58.8 with SMTP id l8mr1651677ybk.242.1312437750148; Wed,
 03 Aug 2011 23:02:30 -0700 (PDT)
Received: by 10.150.137.6 with HTTP; Wed, 3 Aug 2011 23:02:10 -0700 (PDT)
In-Reply-To: <m3d3gmrchz.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178702>

2011/8/3 Jakub Narebski <jnareb@gmail.com>:
> I have added cj-git-patchtool to "Patch-management Interface layers"
> section of "Interfaces, frontends and tools" page on Git Wiki:

Cool, thanks!

> I use one of patch management interfaces for that, namely StGit. =A0I=
t
> operates on stack of patches, which you can apply and unapply, going
> back and forth and correcting them.

I knew StGit existed, but I've never actually tried it. Now I also see
that the description of Guilt actually sounds exactly what
cj-git-patchtool does. (I was expecting that these tools would just
let me easily create sets of patches, similar to Darcs, not that
they'd actually allow to edit patches to fix conflicts.) I'll have to
try them out as soon as I find some time. Thanks for the hint.

Christian.
