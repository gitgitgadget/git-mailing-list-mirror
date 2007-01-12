From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Fri, 12 Jan 2007 21:20:53 +0100
Organization: At home
Message-ID: <eo8qie$ap7$1@sea.gmane.org>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jan 12 21:20:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5StM-0003bS-AJ
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 21:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbXALUUp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 12 Jan 2007 15:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbXALUUp
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 15:20:45 -0500
Received: from main.gmane.org ([80.91.229.2]:37900 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030250AbXALUUp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 15:20:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H5StE-0004By-N2
	for git@vger.kernel.org; Fri, 12 Jan 2007 21:20:40 +0100
Received: from host-81-190-18-73.torun.mm.pl ([81.190.18.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 21:20:40 +0100
Received: from jnareb by host-81-190-18-73.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 21:20:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-73.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36702>

[Cc: git@vger.kernel.org]

Chris Riddoch wrote:

> I've got a very, very old codebase I'm trying to wrap my head around.
> It was apparently once tracked with RCS, but the ,v files are long
> gone and all that remains are a series of tarballs on an FTP site
> containing alpha, beta, and final releases of various versions of the
> project. =A0There's a logical progression, but between each there are
> new files, deleted files, and lots of changed files. =A0gitk will at
> least help me make sense of the actual changes. =A0I've got part of a
> shell script to automate this process.

http://git.or.cz/gitwiki/GitFaq#import-tar

(because this kind usage is/should be rare, using plumbing here is not =
an
error, I think).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
