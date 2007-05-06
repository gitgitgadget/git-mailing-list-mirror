From: =?iso-8859-1?Q?Thomas_H=FChn?= <newsgroups@thomas-huehn.de>
Subject: Re: git cvsimport fails
Date: Sun, 06 May 2007 09:04:38 +0200
Message-ID: <87ejlu1lh5.fsf@mid.thomas-huehn.de>
References: <87ejm0mtpy.fsf@mid.thomas-huehn.de>
	<87abwomtdl.fsf@mid.thomas-huehn.de>
	<87lkg2v4ha.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 09:05:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkanj-0006Tc-MA
	for gcvg-git@gmane.org; Sun, 06 May 2007 09:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbXEFHE5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 03:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755287AbXEFHE4
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 03:04:56 -0400
Received: from main.gmane.org ([80.91.229.2]:41483 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274AbXEFHE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 03:04:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hkand-0005ip-4f
	for git@vger.kernel.org; Sun, 06 May 2007 09:04:53 +0200
Received: from p54a0cd78.dip.t-dialin.net ([84.160.205.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 May 2007 09:04:53 +0200
Received: from newsgroups by p54a0cd78.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 May 2007 09:04:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54a0cd78.dip.t-dialin.net
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:z/td7rymrHPm1dH1TVJGbw9fvIs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46308>

=46lorian Weimer <fw@deneb.enyo.de> writes:

> * Thomas H=FChn:
>
>> HEAD contains "ref: refs/heads/master", but refs/heads contains no
>> "master", just other files.
>>
>> Can I find out, which hash master should point at?
>
> After the initial checkout, it should point to "origin"; this is the
> HEAD of the CVS repository.  Of course, if your main development line
> resides on another branch, you should use that.

Okay, thanks. I'll enter that.

Thomas
