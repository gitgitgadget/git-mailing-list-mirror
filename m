From: John Gamboa <vaulttech@gmail.com>
Subject: GSoC Improving parallelism in various commands
Date: Sat, 24 Mar 2012 22:06:00 +0100
Message-ID: <CAM6-U1QwaMiSHcRvzgwQVYfAU7=v9gxiAaRrcVBmPpWw2wic4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 22:06:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBYAE-0006CR-VS
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 22:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab2CXVGD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 17:06:03 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53449 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659Ab2CXVGB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2012 17:06:01 -0400
Received: by qcqw6 with SMTP id w6so2664702qcq.19
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 14:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=yvE70m3YJgItF9ZpTz6aobT9Kds09+W7fl+jd7Xbpn8=;
        b=u9/2R+i3WDg/xCy5celLNp4NADPmeq6k3pEXzznaahiBW8ybHmIcZ5zGh+pRpUMpja
         r/1tUAP0tFiKN2DEmpXSD1A3DvkiAvDKAEcNbpdygfd3VGaeqmDiUeB8C/0PO1EwXEpv
         ASY59cKU3unvtIOift/JS0x+2Ff2rt/eUwS/Jl/Iyikg6d6Rsw8Auk0mGq8sVM6tbRPW
         c/r9bSm48o4mYDJyekQs9oh1Ber5f2j3J2eNMIh3Z9njaS51V9alcmJS0yVgsgqSuMm3
         mOaOuGxGCepSv0uGp0ebRC2fMsT3fLNLR2ogI3gKr9NlF1yj0+UAlXmiq3ZndOhKV98K
         W8xg==
Received: by 10.224.58.147 with SMTP id g19mr21602582qah.58.1332623160947;
 Sat, 24 Mar 2012 14:06:00 -0700 (PDT)
Received: by 10.229.147.5 with HTTP; Sat, 24 Mar 2012 14:06:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193849>

Hello...

I'm a Computer Science student and, well, as the topic of this e-mail
suggests, I'm planning to submit a project to GSoC on git. I went into
the ideas page and found the Git Project Ideas for GSoC page, where I
found this idea about improving parallelism in some git commands.

I saw that the idea in the Git Ideas page is very well explained, but,
well, I never touched the Git code and I really don't know how
difficult it would be, and how many commands are there to be
"paralelized". Anyway, I really like parallelism and I found this a
very good oportunity to improve my knowledge =A0about it (although I ca=
n
say I've already played/worked enough to feel confortable on this).

Is there any place where I could find more information on what
commands are already parallel? And do anyone have any idea on how many
commands could benefit from parallelism? As I said, I never touched
the Git code. Would someone recommend me to take a look at some place
at first?

Thanks, in advance...

(I tried to send this same e-mail before with some links to the ideas
page, but it seems the it was considered a spam and thus it didn't
reach its destination. Sorry)

--
John Gamboa
