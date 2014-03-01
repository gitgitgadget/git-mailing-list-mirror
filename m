From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: `git stash pop` UX Problem
Date: Sat, 01 Mar 2014 02:41:26 -0600
Message-ID: <85fvn21fbd.fsf@stephe-leake.org>
References: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de>
	<vpqmwhexidi.fsf@anie.imag.fr> <85fvn40ws9.fsf@stephe-leake.org>
	<CANUGeEZTeqBpf0VP4gCG9iN=v20U4axxoSjX9JbLPp_ppX3QiA@mail.gmail.com>
	<851tynz2yg.fsf@stephe-leake.org> <vpq38j3z1jj.fsf@anie.imag.fr>
	<85vbvz171p.fsf@stephe-leake.org> <vpqppm7t41g.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 09:41:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJfUE-0004lk-Oq
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 09:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbaCAIlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 03:41:31 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:43127 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752435AbaCAIla (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Mar 2014 03:41:30 -0500
Received: from [70.94.38.149] ([70.94.38.149:50018] helo=TAKVER)
	by cdptpa-oedge02 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id FD/57-15561-83D91135; Sat, 01 Mar 2014 08:41:29 +0000
In-Reply-To: <vpqppm7t41g.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	28 Feb 2014 20:45:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.130:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243053>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Stephen Leake <stephen_leake@stephe-leake.org> writes:
>
>> So a message "merge complete; you can drop the stash" would be the most
>> git should do.
>
> From the user experience point of view, that would be good. It could
> bother some users, but we have advice.* to silent this kind of warnings.
>
> <snip explanation of implementation issues>
>
> So, I wouldn't object, but I don't think the implementation cost is
> worth the benefit.

Ok, that makes sense.

-- 
-- Stephe
