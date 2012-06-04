From: Leila <muhtasib@gmail.com>
Subject: introduction
Date: Mon, 4 Jun 2012 13:36:55 -0700
Message-ID: <CAA3EhH+P_JeVGhRmL-kHOc0cTCiGQmv505XjgAv0kT1PAfjTyw@mail.gmail.com>
References: <CAA3EhHJCRF05Q0xzzOWupVMjmKPbWAq1KNcU9Mmp8g1iH2B0zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 22:37:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbe1h-0000az-Ia
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 22:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab2FDUhR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 16:37:17 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:45784 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894Ab2FDUhQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 16:37:16 -0400
Received: by vbbff1 with SMTP id ff1so2737262vbb.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 13:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=dMZUgMQ6wNT5KKCJGSDN/w+FbsEHT+Hrli4zGxIFocA=;
        b=cEJPfZ5K97nQTC3UtSvrC4s9l3GhEaBKf7MXISWXRjIkPyxmzvn72Xo7exIt3LR+Jl
         eLRa7ZJCUMbQ2vEen6UNEuqM+bh3/X4DtIl0x3yBgHa4AiRn1cnpysSaZ83qozu3+g/d
         /0rg7z097DpPT+P1Dn28+/nd+olw/LFxeURoN41H8eERtkGKaR0RmLjjGnojdeBlCyYZ
         UVV6xaSUn4cxinvYjx3ru1+BJfJWj0iWN1SLC0TQgRrr1dTFVusDMNMRUkluAtyCY1/E
         ksk/ozuMlwE0v9wULggyQP9Rum5YX/1Tn7tooPVmwsU3/jMGBLNBg4VmGCy5OcFOYgsv
         UFkw==
Received: by 10.52.97.41 with SMTP id dx9mr11769691vdb.89.1338842235216; Mon,
 04 Jun 2012 13:37:15 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Mon, 4 Jun 2012 13:36:55 -0700 (PDT)
In-Reply-To: <CAA3EhHJCRF05Q0xzzOWupVMjmKPbWAq1KNcU9Mmp8g1iH2B0zA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199184>

Hi everyone,

I'm attending Hacker School and was interested in contributing to git
this summer and possibly afterwards. At Hacker School they encourage
us to contribute to open source software and projects were are
interested in. I'm in love with git, so naturally I want to contribute
to you guys. Why git? Because it's an awesome tool that has many well
thought out features that other source control tools lack like offline
mode. I'd like to see more people using git, and I'd like to see it
chosen as the source control tool used for team projects. So I was
thinking about contributing the following (which are the reasons I've
heard why people don't use git):

1) Commands are cryptic: I was thinking I could provide a wrapper to
simplify the commands, for example to undo a local commit, I can
introduce a "git undo commit", that wraps "reset" and will undo the
last commit. Or maybe "git rollback" is a better name?

2) git undo command, that will undo the last command (if possible)?

Other ideas:

3) Just like we have git-svn, maybe a=A0svn-git?

Any help or if you can point me in the right direction, I'd appreciate
it.=A0I can also start out by fixing some bugs to get into it. I
couldn't figure out how to see a list of bugs though.

How does one contribute to your documentation? Would it be submitting
a patch just like with code?

Please let me know what you think!

Thanks,
Leila
