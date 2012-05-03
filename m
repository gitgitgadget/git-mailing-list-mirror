From: Ronan Keryell <Ronan.Keryell@hpc-project.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 13:19:41 -0700
Message-ID: <87obq5ggpu.fsf@an-dro.info.enstb.org>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org> <4F9F28F5.2020403@palm.com>
	<201205010137.q411bxaU002449@no.baka.org> <4F9F52B9.9060508@palm.com>
	<08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
	<4FA2D8EA.7030809@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Thu May 03 22:20:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ2VJ-0006qv-6J
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 22:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758568Ab2ECUTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 16:19:51 -0400
Received: from minou.info.enstb.org ([193.50.97.146]:56822 "EHLO
	minou.info.enstb.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758382Ab2ECUTv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 16:19:51 -0400
Received: from an-dro.info.enstb.org (localhost [127.0.0.1])
	by minou.info.enstb.org (8.14.4/8.14.4/Debian-2) with ESMTP id q43KJfno024548;
	Thu, 3 May 2012 22:19:43 +0200
In-Reply-To: <4FA2D8EA.7030809@palm.com> (Rich Pixley's message of "Thu, 03
	May 2012 12:13:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196954>

>>>>> On Thu, 03 May 2012 12:13:46 -0700, Rich Pixley <rich.pixley@palm.com> said:

    Rich> * the hg error messages are straightforward, clear, and don't
    Rich> require any deep knowledge of the source code control system
    Rich> or it's limitations.  (I still don't understand what the git
    Rich> message on collision is saying.)

This is a very good suggestion.

This would help people not having time to embrace all the advanced
details to understand easily what is happening.

At least, print a simpler message with some typical use case causing
this and some workflow ideas before the detailed explanation.

Or adding a new config message.style = expert | newbie | ...
and of course with newbie by default. :-)
-- 
  Ronan KERYELL                            |\/  Phone:  +1 408 658 9453
  Wild Systems / HPC Project               |/)
  5201 Great America Parkway, Suite 320    K    Ronan.Keryell@wild-systems.com
  Santa Clara, CA 95054                    |\   skype:keryell
  USA                                      | \  http://wild-systems.com
