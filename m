From: Hannu Koivisto <azure@iki.fi>
Subject: Re: "Your local changes ... would be overwritten" bug
Date: Tue, 06 Sep 2011 12:46:01 +0300
Organization: NOYB
Message-ID: <831uvu3sx2.fsf@kalahari.s2.org>
References: <8362l73qi6.fsf@kalahari.s2.org> <20110906073436.GA28490@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 11:46:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0sEa-0008UQ-Vd
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 11:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab1IFJqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 05:46:21 -0400
Received: from lo.gmane.org ([80.91.229.12]:40476 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322Ab1IFJqT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 05:46:19 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R0sEU-0008Rb-Hy
	for git@vger.kernel.org; Tue, 06 Sep 2011 11:46:18 +0200
Received: from s2.org ([80.83.7.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 11:46:18 +0200
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 11:46:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.3 (gnu/linux)
Cancel-Lock: sha1:Mn/ASWTWlIbV7aSwMuXePfPaPkU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180782>

Clemens Buchacher <drizzd@aon.at> writes:

> Could you set a breakpoint in add_rejected_path and send us the
> backtrace? Like this:

Since the binary from the package doesn't come with debug
information, I built the latest git master (1.7.7.rc0.72.g4b5ea)
and it turns out the problem cannot be reproduced with this version
anymore.  I guess I should have tried that right away.  Sorry for
the noise.

-- 
Hannu
