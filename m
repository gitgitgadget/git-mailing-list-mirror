From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Gitbox
Date: Thu, 14 Apr 2011 09:55:47 -0400
Message-ID: <BANLkTim-fKZr2Y3FCjJJV4yoXQKOoeoyLg@mail.gmail.com>
References: <BANLkTikfCDm-5Yde=2Cm-ROc1dcMwopvOg@mail.gmail.com>
 <4238CC86-13A5-4DB8-B8B2-BC3AA2F2DA5E@gmail.com> <4DA654D4.5040104@medialab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Juran <jjuran@gmail.com>,
	Daniel Searles <daniel.paul.searles@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Drew Northup <drew.northup@maine.edu>, oleganza@gmail.com,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Searles <dsearles@medialab.com>
To: Chris Perkins <cperkins@medialab.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 15:56:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAN1q-0002Up-OP
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 15:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758029Ab1DNN4J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 09:56:09 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39945 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757881Ab1DNN4I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 09:56:08 -0400
Received: by gyd10 with SMTP id 10so446851gyd.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=0n4G6LFuSJO1492MSSTm2csIqQh3eRUjhtqPra4SUTc=;
        b=CqwIrln1T9Get4lRK5EGZuW+0iEyKHDcFKbRyzQYIzxhFs757mMxaEwqWsF4K9zsjp
         obVQvnHN2k9TR4X0sVeakCz0nYBVymITK/P39L2pM5fdGAT7MtN1tCu1WZLZk5RVE5HZ
         mLAzoLqffY8RyxC/AypIk2dLahyQcxXu9Z270=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SWmjRmMmK/BUUPqW+J4DQUlKG/gofS9kpGOK7Fid0zj0YQVzilxtWNKsShw47MBZmt
         +cecylTBWdgE988y3UsT59riXzYPff2fBulGf0l6doQnqX7RrqShQMId6teMBw5paLHG
         3kV13Fb1hDay9zxprzPJOeccLbfDJDyndK8rI=
Received: by 10.91.69.28 with SMTP id w28mr1633472agk.143.1302789367102; Thu,
 14 Apr 2011 06:56:07 -0700 (PDT)
Received: by 10.90.103.9 with HTTP; Thu, 14 Apr 2011 06:55:47 -0700 (PDT)
In-Reply-To: <4DA654D4.5040104@medialab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171518>

On Wed, Apr 13, 2011 at 9:58 PM, Chris Perkins <cperkins@medialab.com> =
wrote:
> Let's look at this at a slighty different way. Let's say someone writ=
es
> a GUI wrapper for Git, bundles it with Git, and then offers for sale =
a
> new proprietary SVC system. They list off all the wonderful features
> that it has. =A0On the back page of their website is a small 'License=
s'
> disclosure and the source code to Git comes with the download buried =
in
> a subdirectory. =A0None of the users realize the software is using Gi=
t.
>
> Is that a violation of the GPL? I would say that it absolutely is.

It absolutely is not. Lots of companies do this, and it is perfectly
kosher -- either bundle the src somewhere or offer a link to download
the source somewhere.

While IANAL, and specifically not _your_ lawyer, I have been in this
field for >10 years, and studied law @ masters level on software
licensing. You are reading the GPL wrong, and you're not aware of
widespread industry practices around it.

Anyone who is curious about this gitbox thing, and interested in
*facts* instead of fiction, could advance our knowledge with a simple
procedure:

 - Download the "free" version (or payfor the paid version!). It's a
zipfile, no need to hurt any Macs.

 - See if it includes the src or a link to download the src -- it will
probably be in a corner of the documentation or license. Maybe there's
an offer to provide the src in a different way, but a download link is
the usual trick.

 - Does the link work? Can you effectively get the src?

 - Does the src match the binaries you got?

cheers,



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
