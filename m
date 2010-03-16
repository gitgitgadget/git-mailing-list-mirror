From: Harry Putnam <reader@newsguy.com>
Subject: Retrieve a specific file from some revision.
Date: Tue, 16 Mar 2010 13:55:38 -0500
Organization: Still searching...
Message-ID: <87vdcwxfit.fsf@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar@lists.canonical.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 22:46:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NreZz-0002FK-AP
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 22:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886Ab0CPVpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 17:45:30 -0400
Received: from lo.gmane.org ([80.91.229.12]:39162 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794Ab0CPVp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 17:45:29 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NreZT-0001hd-VZ
	for git@vger.kernel.org; Tue, 16 Mar 2010 22:45:03 +0100
Received: from c-98-215-178-110.hsd1.in.comcast.net ([98.215.178.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 22:45:03 +0100
Received: from reader by c-98-215-178-110.hsd1.in.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 22:45:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-98-215-178-110.hsd1.in.comcast.net
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:Q8EHUGTuuq7kSvqOFhjkJ/HAOeE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142351>

First, let me just make sure this group is the general
question/discussion group for the versioning tool `bazaar' on the web
at:  http://bazaar.canonical.com/en/

I asked this question on a mercurial group too.  Probably should have
just crossposted so as not to have two different messgae-ids involved.
I have done that with this post on bazarre-ng and git groups.

I'm not just jerking around but want to know how this would be done.
Just reading docu doesn't usually really help me until wade into
something but this time I want to choose a versioning tool that I can
readily do things I've learned to rely on.

Reprint:
-------        ---------       ---=---       ---------      -------- 

I've never used any versioning tool but cvs.  Something I do often
with cvs is retrieve a previous state of a single file..

Say I wanted to use the hosts file as it was at revision 1.23.
Not just a diff, but the actual file.
(I would)
  cd cvsrepo
    cvs update -p -r1.23 <HOST>/etc/hosts > ~/hosts_HOST_r1.23

  Would create the file as it was at rev. 1.23 for host HOST.

How would I do that in bazaar/git? (which ever newsgroup this is on)


 
