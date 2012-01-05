From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git-subtree
Date: Thu, 5 Jan 2012 21:02:16 +0530
Message-ID: <CALkWK0k+AwCsizZFwbKKxuz0B4xLoyC4hAy3WRD=sLCq-HvvCw@mail.gmail.com>
References: <nngaa638nwf.fsf@transit.us.cray.com> <CALkWK0nU9iO_6CCbWw8c_Fz=xodkaAW4300Jpc7M7D+kBP=QRg@mail.gmail.com>
 <87ipkq199w.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Greene <dag@cray.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Thu Jan 05 16:33:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RipJI-0008Vh-TW
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 16:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620Ab2AEPcj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 10:32:39 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33007 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932549Ab2AEPci convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2012 10:32:38 -0500
Received: by wgbdr13 with SMTP id dr13so755623wgb.1
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 07:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=j86om6e7eyUnURPlFI0fXB0z08ySbG4dlD6CM0o9kfU=;
        b=fJ8qH6DLVrIOpx9VQf7XW2mgceEXrferirmBJk5UA/HL83GpdJYgckelYBYc6fHvWj
         VgNdTqV66ouhTGkkPdQR7VoxeuNp+PRWvgCfYJE8tm1gFYp8BMe3M73XE9rfHGFThg7k
         hoAEPI+LKaUZ7oQSQvzdXkfjPlq0326YBBz/I=
Received: by 10.227.197.19 with SMTP id ei19mr2191459wbb.6.1325777557341; Thu,
 05 Jan 2012 07:32:37 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Thu, 5 Jan 2012 07:32:16 -0800 (PST)
In-Reply-To: <87ipkq199w.fsf@smith.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187982>

Hi again,

[+CC: Junio Hamano, our maintainer]

David A. Greene wrote:
> I've read that document. =C2=A0The issue is that I didn't develop the=
 code,
> Avery did.

Not an issue as long as you have Avery's signoff.

>=C2=A0It's a lot of time to learn a
> completely new codebase. =C2=A0I was hoping to submit something soon =
and then
> learn the codebase gradually during maintenance/further development.

We certainly don't want badly reviewed code that nobody understands
floating around in the codebase- so, I'd suggest sending out whatever
you think is appropriate for the first round of reviews, and see how
things shape up from there.

> How have completely new tools be introduced into the git mainline in =
the
> past?

Yes.  For an example of something I was involved with but didn't
author, see vcs-svn/.

-- Ram
