From: David Abrahams <dave@boostpro.com>
Subject: [doc] User Manual Suggestion
Date: Wed, 22 Apr 2009 15:38:52 -0400
Message-ID: <m24owgqy0j.fsf@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 21:40:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwiJO-00050R-I0
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbZDVTjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 15:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbZDVTjH
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:39:07 -0400
Received: from main.gmane.org ([80.91.229.2]:33566 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876AbZDVTjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:39:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LwiHg-0000Kd-9a
	for git@vger.kernel.org; Wed, 22 Apr 2009 19:39:04 +0000
Received: from 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com ([207.172.223.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 19:39:04 +0000
Received: from dave by 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 19:39:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.92 (darwin)
Cancel-Lock: sha1:dumBwOLhnXR5I3wdGetgVckbblE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117240>


http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#how-to-check-out
covers "git reset" way too early, IMO, before one has the conceptual
foundation necessary to understand what it means to "modify the current
branch to point at v2.6.17".  If this operation must be covered this
early in the manual, it should probably not be until
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#manipulating-branches

HTH,

-- 
Dave Abrahams
BoostPro Computing
http://www.boostpro.com
