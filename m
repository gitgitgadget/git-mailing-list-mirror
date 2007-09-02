From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 02 Sep 2007 09:08:47 +0200
Organization: Organization?!?
Message-ID: <85642tv91c.fsf@lola.goethe.zz>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 09:09:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRjaP-0002qW-Q5
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 09:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbXIBHJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 03:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753659AbXIBHJI
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 03:09:08 -0400
Received: from main.gmane.org ([80.91.229.2]:48210 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753804AbXIBHJG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 03:09:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IRjZr-0004H1-AQ
	for git@vger.kernel.org; Sun, 02 Sep 2007 09:08:59 +0200
Received: from dslb-084-061-038-061.pools.arcor-ip.net ([84.61.38.61])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 09:08:59 +0200
Received: from dak by dslb-084-061-038-061.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 09:08:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-038-061.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:Pn4Gv/HV/Cgv0dpiT/jXHbS65gI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57301>

Junio C Hamano <gitster@pobox.com> writes:

> The latest feature release GIT 1.5.3 is available at the usual
> places:
>
>   http://www.kernel.org/pub/software/scm/git/
>
>   git-1.5.3.tar.{gz,bz2}			(tarball)
>   git-htmldocs-1.5.3.tar.{gz,bz2}		(preformatted docs)
>   git-manpages-1.5.3.tar.{gz,bz2}		(preformatted docs)
>   RPMS/$arch/git-*-1.5.3-1.$arch.rpm	(RPM)
>
> GIT v1.5.3 Release Notes
> ========================

Initial info doc support might have been mentioned.  While it is not
really something to write home about yet, the mention might draw
people willing to work on it, like providing indexing tags or muscling
AsciiDoc into including manpages in an appendix (both of which would
also benefit the Docbook output).  Well, something for the 1.5.4
release announcement.  Sorry for overlooking this before the actual
announcement.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
