From: David Kastrup <dak@gnu.org>
Subject: Re: Draft of Git Rev News edition 1
Date: Sun, 22 Mar 2015 12:21:44 +0100
Message-ID: <87lhipnupj.fsf@fencepost.gnu.org>
References: <CAP8UFD1WtwKri8cWABnzeRvxKhdNmUfVw5xm=F4oLrevuOGyUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Paul Tan <pyokagan@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dongcan Jiang <dongcan.jiang@gmail.com>,
	Jeff King <peff@peff.net>, Doug Kelly <dougk.ff7@gmail.com>,
	Bharat Suvarna <bharat.bs84@icloud.com>,
	Kevin D <me@ikke.info>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 12:24:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZdzd-0001yT-Ja
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 12:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbbCVLYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 07:24:21 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:33239 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbbCVLYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 07:24:21 -0400
Received: from localhost ([127.0.0.1]:60509 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1YZdzN-0006Am-Tk; Sun, 22 Mar 2015 07:24:18 -0400
Received: by lola (Postfix, from userid 1000)
	id 6F496DF3D9; Sun, 22 Mar 2015 12:21:44 +0100 (CET)
In-Reply-To: <CAP8UFD1WtwKri8cWABnzeRvxKhdNmUfVw5xm=F4oLrevuOGyUA@mail.gmail.com>
	(Christian Couder's message of "Sun, 22 Mar 2015 12:03:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266068>

Christian Couder <christian.couder@gmail.com> writes:

> Hi,
>
> A draft of Git Rev News edition 1 is available here:
>
> https://github.com/git/git.github.io/blob/master/rev_news/draft/edition-1.md
>
> Everyone is welcome to contribute in any section either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
>
> https://github.com/git/git.github.io/issues/17
>
> You can also reply to this email.

I've seen

    David Kastrup (dak at gnu.org) previously reimplemented significant
    parts of "git blame" for a vast gain in performance with complex
    histories and large files. As working on free software is his sole
    source of income, please consider contributing to his remuneration
    if you find this kind of improvements useful.

Thank you very much for this heads-up.  However, I'd replace
"previously" with "as of version 2.1.0".  That's where the big
difference is, so if people actually are impacted they'll know whether
and what to benchmark and/or upgrade.

-- 
David Kastrup
