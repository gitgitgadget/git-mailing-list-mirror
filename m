From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Fri, 9 Mar 2012 12:26:47 +0100
Message-ID: <CACBZZX79co-BiePQG0ZkgMRiCWQ_g2NCZpVKYBNx=Rpi2WzgMQ@mail.gmail.com>
References: <vpqobs65gfc.fsf@bauges.imag.fr> <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Mar 09 12:27:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5xyc-00059j-KQ
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 12:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484Ab2CIL1K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 06:27:10 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59688 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab2CIL1J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 06:27:09 -0500
Received: by eaaq12 with SMTP id q12so412958eaa.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 03:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=f0FY0vUfB15G3zKD8aq+V1PUSylidAV1pMNv1ZnAL0I=;
        b=yaVp+jnEJOzjyYxdNRpMqnRH0L2KNapJhKCrWE7oMtXkrjzeuvqo3M7hI120PrU9YF
         ooO/w6Dn1Si3OA4JENFOXyH8s5FqAFYR3k42VDcYWOaYq3QvtiZ+vqjdi3KsxbUOrYIQ
         1YrosAPRPtoJ1sRgP21xhYHMdCVCkpKSXi/wY6MgDjIeQmAAJX8wDYSZ7WuCz6hTISBx
         OmA5dnnfVx5eBH4ek8VcnuSkOSnvW9wPM3aSTut8H4DcHtZst6tLrwAELbcefFvuD3nx
         N7bQrhQTTvps4XBLctFnx1QqwUmaKgJhPcmtkIgfMzatDhIKmfCTAgyZRFIQFf2v7Frc
         1XDQ==
Received: by 10.14.99.76 with SMTP id w52mr357246eef.3.1331292428124; Fri, 09
 Mar 2012 03:27:08 -0800 (PST)
Received: by 10.213.2.147 with HTTP; Fri, 9 Mar 2012 03:26:47 -0800 (PST)
In-Reply-To: <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192710>

On Fri, Mar 9, 2012 at 09:31, Matthieu Moy <Matthieu.Moy@imag.fr> wrote=
:
> More inexperienced users will often push right after committing, and =
at
> that time they're still very much in the "working-on-one-branch" stat=
e of
> mind. =C2=A0"upstream" would be a safer default mode of operation for=
 'git push'
> for them even when they have their personal publishing repository (al=
so in
> a shared public repository settings, "matching" is rarely the right
> default mode).

I very much like changing the default, thanks for working on this,
this'll make Git a lot more sensible by default.

</aol>
