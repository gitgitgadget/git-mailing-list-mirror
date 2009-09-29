From: Anteru <newsgroups@catchall.shelter13.net>
Subject: Re: Deciding between Git/Mercurial
Date: Tue, 29 Sep 2009 08:32:23 +0200
Message-ID: <h9s9ll$kqb$1@ger.gmane.org>
References: <h9nlhj$heq$1@ger.gmane.org> <m33a66br69.fsf@localhost.localdomain>
Reply-To: newsgroups@catchall.shelter13.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 08:34:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsWI1-0002iC-KM
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 08:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbZI2GeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 02:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbZI2GeI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 02:34:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:59968 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbZI2GeH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 02:34:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MsWHo-0002en-3V
	for git@vger.kernel.org; Tue, 29 Sep 2009 08:34:08 +0200
Received: from lmontsouris-156-26-18-33.w80-14.abo.wanadoo.fr ([80.14.177.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 08:34:08 +0200
Received: from newsgroups by lmontsouris-156-26-18-33.w80-14.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 08:34:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: lmontsouris-156-26-18-33.w80-14.abo.wanadoo.fr
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <m33a66br69.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129283>

> First, you have to remember that this 'number of commit' thingy is
> *local* to your repository, so you cannot use commit numbers to
> communicate with other developers.  This is inherent and unavoidable
Ah cool, thanks for clarifying this.

>> So far, my key arguments are that git is more robust (more projects
>> using it, larger developer base), of course git's excellent performance
>> and the much better support for SVN, which is important for us as we can
>> slowly migrate from SVN->Git, while hgmercurial is still in the making
>> (and Python's SVN->Hg switch is for instance waiting for it).
> 
> hgmercurial? or hgsubversion?
hgsubversion of course, which is supposed to be what git-svn is already.
At the moment, I already use git with our SVN server, so I can show some
of the advantages (for instance, renaming works much better than with
SVN itself :) ), and I guess it also makes the migration easier as
everyone can try with Git locally and we switch from SVN to Git once
everyone has switched locally.

Thanks for all the input so far!

Cheers,
  Anteru
