From: Ronan Keryell <Ronan.Keryell@hpc-project.com>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Tue, 07 Feb 2012 09:27:43 -0800
Message-ID: <8762fi365s.fsf@an-dro.info.enstb.org>
References: <201202042045.54114.jnareb@gmail.com>
	<201202061814.58346.jnareb@gmail.com>
	<CALKQrgcUdigB5zB_bqgpW8=o-TuGChs+q2nYoXu5YdyWu+oWZw@mail.gmail.com>
	<201202071531.08385.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 18:35:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuoxI-0004kH-3C
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 18:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866Ab2BGRfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 12:35:44 -0500
Received: from minou.info.enstb.org ([193.50.97.146]:46347 "EHLO
	minou.info.enstb.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338Ab2BGRfn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 12:35:43 -0500
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Feb 2012 12:35:43 EST
Received: from an-dro.info.enstb.org (localhost [127.0.0.1])
	by minou.info.enstb.org (8.14.4/8.14.4/Debian-2) with ESMTP id q17HRhxo003379;
	Tue, 7 Feb 2012 18:27:45 +0100
In-Reply-To: <201202071531.08385.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 7 Feb 2012 15:31:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190188>

>>>>> On Tue, 7 Feb 2012 15:31:07 +0100, Jakub Narebski <jnareb@gmail.com> said:

    >> Agreed, but AFAICS (and modulo the addition of pre-rewrite and
    >> pre/post-push hooks mentioned earlier) all of the things
    >> discussed so far in this thread can be implemented as hooks.

    Jakub> That would be nice.

    Jakub> And the new hooks (pre-rewrite, pre/post-push) would be
    Jakub> useful anyway, I think.

Yes, to deal with file metadata in git for example. :-)
-- 
  Ronan KERYELL                      |\/  Phone:  +1 408 844 4720
  Wild Systems / HPC Project, Inc.   |/)  Cell:   +33 613 143 766
  5201 Great America Parkway #3241   K    Ronan.Keryell@hpc-project.com
  Santa Clara, CA 95054              |\   skype:keryell
  USA                                | \  http://hpc-project.com
