From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Missing documentation for GIT_DIFF_OPTS and GIT_EXTERNAL_DIFF
Date: Wed, 14 Feb 2007 02:27:50 +0100
Organization: At home
Message-ID: <eqtof8$8id$1@sea.gmane.org>
References: <20070213223657.GC4266@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 02:26:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH8uj-00029S-VG
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 02:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbXBNB00 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 20:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbXBNB00
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 20:26:26 -0500
Received: from main.gmane.org ([80.91.229.2]:52882 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494AbXBNB0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 20:26:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HH8uN-0005t4-VY
	for git@vger.kernel.org; Wed, 14 Feb 2007 02:26:07 +0100
Received: from host-81-190-25-81.torun.mm.pl ([81.190.25.81])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 02:26:07 +0100
Received: from jnareb by host-81-190-25-81.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 02:26:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-81.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39607>

Yann Dirson wrote:

> I noticed today, after unsuccessfully trying GIT_DIFF_OPTS=-U2, that
> 1) it did not work, 2) the doc in 1.4.4.4 tells about using
> "GIT_DIFF_OPTS=-c", which does not work either and 3) there is
> virtually no more doc about it in HEAD.
> 
> It would be useful to document which flags are recognized, and notably
> that -u<n> has to be used instead of GNU diff's -U<n>.
> 
> At the same time, I noticed that GIT_EXTERNAL_DIFF is not described in
> the diff docs either, although it is described in the main git.txt
> page (which may not be the place where users would look for it - at
> least, only my grep aiming to be accurate before composing this mail
> finally found it).

GIT_DIFF_OPTS are also described there.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
