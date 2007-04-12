From: Bernt Hansen <bernt@norang.ca>
Subject: Re: [PATCH] gitk doesn't handle filenames with space correctly
Date: Wed, 11 Apr 2007 20:00:08 -0400
Organization: Norang Consulting Inc
Message-ID: <87fy76h37b.fsf@gollum.intra.norang.ca>
References: <86slbd6kr0.fsf@mau.intra.tuxee.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 02:00:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbmjm-0000Jt-HK
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161361AbXDLAA1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 Apr 2007 20:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161365AbXDLAA1
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:00:27 -0400
Received: from main.gmane.org ([80.91.229.2]:55675 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161361AbXDLAA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:00:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hbmje-0002ca-Lw
	for git@vger.kernel.org; Thu, 12 Apr 2007 02:00:22 +0200
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([74.119.210.211])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Apr 2007 02:00:22 +0200
Received: from bernt by cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Apr 2007 02:00:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.95 (gnu/linux)
Cancel-Lock: sha1:28p86W0KMGDgh+oRk9JoIo7VVwo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44284>

=46r=C3=A9d=C3=A9ric Jolliton <gmane@frederic.jolliton.com> writes:

> Here is an attempt to fix gitk such that it can display filenames wit=
h
> space correctly, in the right column (Patch/Tree). I don't know TCL, =
so
> probably that a better solution exists.

Thanks Fr=C3=A9d=C3=A9ric!

This patch works great for me.

:)

Bernt
