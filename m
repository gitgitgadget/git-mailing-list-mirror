From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: Re: Documentation (mostly user manual) patches
Date: Sat, 10 Mar 2007 23:35:25 -0500
Message-ID: <11735877311383-git-send-email-bfields@citi.umich.edu>
References: <7vr6s42xgm.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 05:36:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQFmt-0000sT-UB
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 05:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131AbXCKEfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 23:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933122AbXCKEfu
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 23:35:50 -0500
Received: from pool-138-88-140-139.esr.east.verizon.net ([138.88.140.139]:50469
	"EHLO pad.fieldses.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933120AbXCKEfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 23:35:48 -0500
Received: from pad.fieldses.org (pad.fieldses.org [127.0.0.1])
	by pad.fieldses.org (8.13.8/8.13.8) with ESMTP id l2B4ZV8j022217;
	Sat, 10 Mar 2007 23:35:32 -0500
Received: (from bfields@localhost)
	by pad.fieldses.org (8.13.8/8.13.8/Submit) id l2B4ZV9A022216;
	Sat, 10 Mar 2007 23:35:31 -0500
X-Mailer: git-send-email 1.5.0.gb75812-dirty
In-Reply-To: <7vr6s42xgm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41907>

> If it is not too much to ask, I'd prefer future pull insns for
> two branches from your side.  Please maintain a fork of my
> 'maint' and a fork of my 'master' on your side, and apply all
> updates to the manual that is applicable to 1.5.0 series on your
> 'maint'.  If there are updates to the manual that talks about
> new material that will appear in 1.5.1, merge your 'maint' to
> your 'master' and then apply the updates there.

OK, I hope I've understand what you're asking for: the following small
(mainly user-manual) fixes all make sense for both 1.5.0 and 1.5.1, so
(in addition to emailing them), I've applied them to the top of the
"maint" branch at:

	git://linux-nfs.org/~bfields/git.git

which is just a fork of your "maint".

I haven't done anything to my "master", since I've got nothing
1.5.1-specific, and since I assume you'll take care of pulling this
stuff into master some time later.

--b.
