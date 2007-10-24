From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: UI and git-completion.sh
Date: Tue, 23 Oct 2007 17:50:05 -0700
Message-ID: <868x5t9w02.fsf@blue.stonehenge.com>
References: <20071023234617.45a4fc64@paolo-desktop>
	<471E6EF0.2060403@midwinter.com> <86ve8x9z1f.fsf@blue.stonehenge.com>
	<vpqir4xgzep.fsf@bauges.imag.fr> <86prz59y9s.fsf@blue.stonehenge.com>
	<vpqbqapgx0j.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Oct 24 02:50:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkURw-0006jJ-9P
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 02:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbXJXAuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 20:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbXJXAuI
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 20:50:08 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:41814 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbXJXAuG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 20:50:06 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 1D4FE1DEC94; Tue, 23 Oct 2007 17:50:06 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.13.14; tzolkin = 3 Ix; haab = 2 Zac
In-Reply-To: <vpqbqapgx0j.fsf@bauges.imag.fr> (Matthieu Moy's message of "Wed, 24 Oct 2007 02:46:20 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62179>

>>>>> "Matthieu" == Matthieu Moy <Matthieu.Moy@imag.fr> writes:

Matthieu> http://zsh.cvs.sourceforge.net/zsh/zsh/Completion/Unix/Command/_git

Matthieu> Try adding it to your $fpath, hopefully, the new _git doesn't use the
Matthieu> other new zsh features, and it will work (I have a CVS _git with a
Matthieu> 4.3.4 zsh, and it works like a charm).

Do I add it as _git below my $fpath?  Or do I need to put it into a subdir?
How will it know it is there?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
