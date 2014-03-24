From: Aleksey Mokhovikov <moxobukob@gmail.com>
Subject: Re: [PATCH][GSOC] Selection of the verbose message is replaced with
 generated message in install_branch_config()
Date: Mon, 24 Mar 2014 14:28:02 +0700
Message-ID: <lgomc3$rh0$1@ger.gmane.org>
References: <1395050104-19152-1-git-send-email-moxobukob@gmail.com> <loom.20140318T124348-742@post.gmane.org> <lg9l22$qto$1@ger.gmane.org> <CAPig+cQLACyFwVypi08ZGQ14mpc0zt0fRRNhPzswRjsTaFQz2A@mail.gmail.com> <lgekju$u6t$1@ger.gmane.org> <CAPig+cRv-WvoMVY0PDgtLawywe0QfpX8oPetzNwD-9Jq6BOjyw@mail.gmail.com> <xmqqr45vv5q8.fsf@gitster.dls.corp.google.com> <532CAB89.7030303@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 08:21:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRzCY-0002Er-Nz
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 08:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbaCXHVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 03:21:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:45919 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbaCXHVH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 03:21:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WRzBu-0001Ym-Lj
	for git@vger.kernel.org; Mon, 24 Mar 2014 08:21:02 +0100
Received: from 84.237.77.135 ([84.237.77.135])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 08:21:02 +0100
Received: from moxobukob by 84.237.77.135 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 08:21:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 84.237.77.135
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <532CAB89.7030303@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244811>

On 03/22/2014 04:13 AM, Michael Haggerty wrote:
> My expectation when I invented that microproject was that converting the
> code to be table-driven would be judged *not* to be an improvement.  I
> was hoping that a student would say "the 'if' statement is OK, but let's
> delete this ridiculous unreachable else branch".  Possibly they would
> convert the "if" chain into nested "if"s, which I think would allow some
> code consolidation in one of the branches.
>
> But not a single student agreed with me, so I must be in a minority of
> one (which, unfortunately, is the definition of lunacy).
>
> The multidimensional array lookup table is not so terrible, but I
> personally still prefer the "if".
>
> Michael
>

That was expectable. But the main goal for me was to participate in git
development process, to become familiar with it.
It looks hard to participate when not proposing a patch.
I thought about make a small change in if chain, but it looked to minor
to feel whole development process.
I've used git features for formatting and sending a patch to mailing list.
I've met the GNU gettext restrictions when proposed a first patch.
Proposed another patch and tried to show Pros and Cons.
It didn't look like applying a patch to git master branch was the main goal.
As for me that was quite interesting and useful.
