From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [wishlist] support git flow-like view
Date: Wed, 21 Nov 2012 10:56:26 +1100
Message-ID: <CAH5451nrcEo3Uxm0x6b39Hq1k-J4=OZPi-Cao7osaiS-w_Z1+Q@mail.gmail.com>
References: <201211202043.00293.perezmeyer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Lisandro_Dami=C3=A1n_Nicanor_P=C3=A9rez_Meyer?= 
	<perezmeyer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 00:57:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Taxgb-0003cG-PK
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 00:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598Ab2KTX4s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2012 18:56:48 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52736 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab2KTX4r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2012 18:56:47 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so4334235qcr.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 15:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=625Scjj7tmlJ9Hjp/PZXL1D8Ql1fMCkPuiYIeHb5cWg=;
        b=DK0N4FSVPdhVtOzs0SQJdocd+cgF8VWv/OHkBWEY/X3pB++lrjkaV/BQkrrA+DdaJJ
         xivBVAZPVDUzJRM7QTOUtMm7f44HLGiEjaEx1SCz5x9j1otypT8qV9JfiRYvginSoq8D
         WjJ64/ERqPo9AMtirXRr91Ycd1x6eB12US3SGfJ9gsKH3ye2YadXRG393WrG8NORDBYG
         EuqSr4dFaVWAzLyYcfDR3Kqd9Bsm+42GCPdcHliH7Y8iLmrp2q0MAsqlbyzHMcnNC8yF
         PEN5N5uR3LZekSNX0ajhu5PFpAyqFGZEY9xwncKmtcGezz/AseRd/yOYGrA4YWSg89of
         JOiA==
Received: by 10.224.168.80 with SMTP id t16mr16477949qay.8.1353455806668; Tue,
 20 Nov 2012 15:56:46 -0800 (PST)
Received: by 10.49.119.65 with HTTP; Tue, 20 Nov 2012 15:56:26 -0800 (PST)
In-Reply-To: <201211202043.00293.perezmeyer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210125>

On 21 November 2012 10:42, Lisandro Dami=C3=A1n Nicanor P=C3=A9rez Meye=
r
<perezmeyer@gmail.com> wrote:
>
> Hi! I am not suscribed to the list, so please CC-me.

That is the default etiquette on this list :)

> I think this may have been proposed before, but I could not find anyt=
hing in
> the web, so I better try myself :)
>
> The idea would be to gitk to show a "git flow-like"[0] view when it d=
etects
> git flow (or the user ask for it or...)

What does it mean to 'show a "git flow-like" view'? Show multiple
branches? Place commits on each branch in 'swim-lanes', rather than
moving them around on the horizontal to fit the space available? Some
more detail, or even a mock-up would help a lot here.

> Basiccaly, you can show the main two branches: master and develop. Of=
 course,
> having the possibility to show feature/release/hotfixes branches woul=
d be
> ideal.

It is already possible to show multiple branches in gitk at the same
time. You probably have some more specific needs beyond simply showing
the different branches. Maybe you can be more specific?

Regards,

Andrew Ardill
