From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] typo in git-gui/lib/sshkeys.tcl
Date: Sun, 30 Oct 2011 20:17:15 +0530
Message-ID: <CALkWK0nW5UFnhLnARPeLhi6EPKgHTCuR3DTVuRdku8-rjPt7Qg@mail.gmail.com>
References: <4EAD23AA.8000400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?RGVqYW4gUmliacSN?= <dejan.ribic@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 30 15:47:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKWfm-0000RA-I9
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 15:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934118Ab1J3Orh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Oct 2011 10:47:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58853 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934064Ab1J3Orh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Oct 2011 10:47:37 -0400
Received: by wwi36 with SMTP id 36so460325wwi.1
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aEbQ/waaN/a2SADro/qta3XDQ90DK0RFgEKxk9H/g1k=;
        b=ZnOZDiEbUC6satcPsKZb+M/t1LSPH6Ty4tzUSeWDIgWCAt0XlZPsd7q4cCAEx74f9Z
         jr6VwLN+A7PFHPcvNf0sJVJkEexEZOEih2FcjJeLCHuMzMNEGTyjM1YKTfB4rFrmbq75
         sl5Z/WJyVA1gyfGYVrTtpkGwuo1+hL6+jOvYA=
Received: by 10.216.160.72 with SMTP id t50mr3290596wek.10.1319986056091; Sun,
 30 Oct 2011 07:47:36 -0700 (PDT)
Received: by 10.216.52.197 with HTTP; Sun, 30 Oct 2011 07:47:15 -0700 (PDT)
In-Reply-To: <4EAD23AA.8000400@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184473>

Hi Dejan,

Dejan Ribi=C4=8D writes:
> =C2=A0 I am new at this, but I am trying to fix a few "bitesize" bugs=
 in
> Ubuntu for start and somebody suggested, that I post this patch to
> Upstream, so I'm doing this.

Welcome to the Git community.  Please read
Documentation/SubmittingPatches so that your patch can be considered
for inclusion: in short, prepare and send the patch using 'git
format-patch'/ 'git send-email' along with a nice commit message and
signoff.

> P.S.: I am not subscribed to this list, so please CC to me.

That's the default convention on this list- no need to specify explicit=
ly.

Cheers.

-- Ram
