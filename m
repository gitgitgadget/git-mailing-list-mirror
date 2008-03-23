From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [SoC RFC] git statistics - information about commits
Date: Sun, 23 Mar 2008 10:31:03 -0700
Message-ID: <7vzlsp73fs.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0803210152o529f3b4fi15c515f5385d8f88@mail.gmail.com>
 <7vmyospgz7.fsf@gitster.siamese.dyndns.org>
 <7v3aqik0nz.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0803230707w29e31d89kf65cf4ac7ad3c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "alturin marlinon" <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 18:32:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdU3A-0006st-2A
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 18:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbYCWRbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 13:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbYCWRbQ
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 13:31:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYCWRbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 13:31:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 68D9B2A18;
	Sun, 23 Mar 2008 13:31:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CF3442A17; Sun, 23 Mar 2008 13:31:10 -0400 (EDT)
In-Reply-To: <bd6139dc0803230707w29e31d89kf65cf4ac7ad3c8@mail.gmail.com>
 (alturin marlinon's message of "Sun, 23 Mar 2008 15:07:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77929>

"alturin marlinon" <alturin@gmail.com> writes:

> On Sat, Mar 22, 2008 at 8:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
> The question now though, is which of these features are feasible to do
> in one GSoC project? That is, which one should be done first, as I
> want to finishing this feature even if I can't finish it all in three
> months.

Hey, don't get me wrong.  Please do not start your thought with "which of
these features".  Proposed feature set should come from you.  It's your
project after all.

I was NOT giving you an instruction "You should do all of these" (I am not
your mentor), an opinion "These are all important" (I haven't thought
things through), nor criteria "Unless you do your feature this way, you
fail" (I am not GSoC admin to judge your application nor evaluate at the
end of project).  Nothing of that sort.  They are just random ideas, I
haven't even thought through the feasibility of, and/or possible approach
to solution for, some of them.

If you find any of them interesting, you are welcome to include them in
your target feature set.  Other uninteresting ones and unrealistic ones
you can discard without even commenting.
