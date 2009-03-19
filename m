From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: Gnome chose Git
Date: Thu, 19 Mar 2009 11:33:54 +0000
Message-ID: <e2b179460903190433l3619e09aj47490a6e3b10d42d@mail.gmail.com>
References: <877i2lbvt7.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Mar 19 12:35:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkGX4-0006JN-Tp
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 12:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbZCSLd7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 07:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbZCSLd5
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 07:33:57 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:46555 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbZCSLd5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 07:33:57 -0400
Received: by qyk16 with SMTP id 16so583711qyk.33
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 04:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ViLTY3hqoqzK+evh3AKPr9opFuYC/3OC4GPfLKWHj/s=;
        b=Fkk5Cdw4W63Hdn1nxBs1mJmBapjwn3B+hrbSgQQBw3fENVlQNTY8H9TWEyjd8zx8kx
         vtp47dJ/W1ZFG3QTnymOH08kx9z9tj8rZ8jkH2K+O/1YkSFIW+EQnUKET65nzh3QE0gy
         mK6w22l0nptndryFbKrbx4xiAMgMYeTjUBjgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U2OaEpiCDcvNdsb2KoieX1fBQwXF4GtWr3aUwi7TtQJXwbmMPZvb62XNODH8sKv3yK
         OM09xTxtnPkPZQpq3XqTj6j0uO9qP1tOmLMGqN54EqBN6Y3ey5WTqEa2yrGdzoaPFI3I
         818oW6q670x+3CoflDm2puuVQIn0xmz1BWoWs=
Received: by 10.224.74.83 with SMTP id t19mr3555926qaj.334.1237462435001; Thu, 
	19 Mar 2009 04:33:55 -0700 (PDT)
In-Reply-To: <877i2lbvt7.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113765>

2009/3/19 Teemu Likonen <tlikonen@iki.fi>:
> FYI: The Gnome release team just announced that Gnome will migrate fr=
om
> Subversion to Git:
>
> =C2=A0 =C2=A0http://thread.gmane.org/gmane.comp.gnome.infrastructure/=
1134

There does seem to be a typo in the release though.

"We realize that git is not perfect, and that the transition will
require significant and important changes to many GNOME processes."

s/ not//

There, fixed that.

Seriously, they should be advocating a c) there, contributing
improvements back to git (and whichever svn migration tool they used)
for the benefit of all, which I'm sure we'll see.

Mike
