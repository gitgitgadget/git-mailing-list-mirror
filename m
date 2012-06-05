From: Michael Schubert <schu@schu.io>
Subject: Re: introduction
Date: Tue, 05 Jun 2012 11:04:11 +0200
Message-ID: <4FCDCB8B.4000103@schu.io>
References: <CAA3EhHJCRF05Q0xzzOWupVMjmKPbWAq1KNcU9Mmp8g1iH2B0zA@mail.gmail.com> <CAA3EhH+P_JeVGhRmL-kHOc0cTCiGQmv505XjgAv0kT1PAfjTyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Leila <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 11:12:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbpoY-0001LI-31
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 11:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab2FEJMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 05:12:30 -0400
Received: from schu.io ([178.77.73.177]:49927 "EHLO
	lvps178-77-73-177.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751479Ab2FEJM3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2012 05:12:29 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jun 2012 05:12:29 EDT
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by lvps178-77-73-177.dedicated.hosteurope.de (Postfix) with ESMTPSA id 53EFEB77C713;
	Tue,  5 Jun 2012 11:06:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <CAA3EhH+P_JeVGhRmL-kHOc0cTCiGQmv505XjgAv0kT1PAfjTyw@mail.gmail.com>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199223>

On 06/04/2012 10:36 PM, Leila wrote:
> 1) Commands are cryptic: I was thinking I could provide a wrapper to
> simplify the commands, for example to undo a local commit, I can
> introduce a "git undo commit", that wraps "reset" and will undo the
> last commit. Or maybe "git rollback" is a better name?

There's Legit [1], Easy Git [2] and probably more.

> 2) git undo command, that will undo the last command (if possible)?

Not possible in general.

> 3) Just like we have git-svn, maybe a svn-git?

?

> Any help or if you can point me in the right direction, I'd appreciate
> it. I can also start out by fixing some bugs to get into it. I
> couldn't figure out how to see a list of bugs though.

There's no bugtracker, just the ML.

How to submit patches:
https://raw.github.com/gitster/git/master/Documentation/SubmittingPatches

You could check "old" GSoC Ideas:
https://github.com/peff/git/wiki/SoC-2012-Ideas

> How does one contribute to your documentation? Would it be submitting
> a patch just like with code?

Yes.

HTH.

[1] http://www.git-legit.org
[2] http://people.gnome.org/~newren/eg/
