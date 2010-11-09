From: Drew Northup <drew.northup@maine.edu>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Tue, 09 Nov 2010 15:29:21 -0500
Message-ID: <1289334561.9556.13.camel@drew-northup.unet.maine.edu>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
	 <vpqd3qe5jxs.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Nov 09 21:30:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFupm-0007at-Ka
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 21:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120Ab0KIUaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 15:30:21 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:36685 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953Ab0KIUaU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 15:30:20 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id oA9KTR8Y006401
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 9 Nov 2010 15:29:32 -0500
In-Reply-To: <vpqd3qe5jxs.fsf@bauges.imag.fr>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=3
	Fuz1=3 Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oA9KTR8Y006401
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1289939375.9474@E6ne9ElQcwBZ1qdMencEXg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161071>


On Tue, 2010-11-09 at 21:19 +0100, Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > * mm/phrase-remote-tracking (2010-11-02) 10 commits
> >  - git-branch.txt: mention --set-upstream as a way to change upstream configuration
> >  - user-manual: remote-tracking can be checked out, with detached HEAD
> >  - user-manual.txt: explain better the remote(-tracking) branch terms
> >  - Change incorrect "remote branch" to "remote tracking branch" in C code
> >  - Change incorrect uses of "remote branch" meaning "remote-tracking"
> >  - Change "tracking branch" to "remote-tracking branch"
> >  - everyday.txt: change "tracking branch" to "remote-tracking branch"
> >  - Change remote tracking to remote-tracking in non-trivial places
> >  - Replace "remote tracking" with "remote-tracking"
> >  - Better "Changed but not updated" message in git-status
> >
> > Is everybody happy with this round?  I'd prefer to merge it to 'next' or
> > even 'master' and have further polishing be done, if necessary,
> > in-tree.
> 
> The version in pu is the right one (I have to admin I did not make the
> task easy ;-), thanks. I didn't get comment for a while, so I guess
> it's OK for next, or master if you want.

I'm happy-enough with them. If I'm going to complain I can offer up
patches and let people fight over those. ;-)

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
