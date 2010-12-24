From: "Steven E. Harris" <seh@panix.com>
Subject: Re: Dangerous "git am --abort" behavior
Date: Thu, 23 Dec 2010 19:24:49 -0500
Organization: SEH Labs
Message-ID: <m2pqss586m.fsf@Spindle.sehlabs.com>
References: <AANLkTinP4SArMkjvTXOEG=tf=8EcEdP9fPAB7F=iitSc@mail.gmail.com>
	<loom.20101220T203122-271@post.gmane.org>
	<1292881979.23145.5.camel@drew-northup.unet.maine.edu>
	<AANLkTikUn+Mco3YeJ7Rj=xZrr1H5xr1Z0=cknf1MdCqC@mail.gmail.com>
	<m2tyi45ell.fsf@Spindle.sehlabs.com>
	<7vtyi415oo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 24 01:25:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVvT6-0006Od-MR
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 01:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab0LXAZE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Dec 2010 19:25:04 -0500
Received: from lo.gmane.org ([80.91.229.12]:33420 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619Ab0LXAZD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Dec 2010 19:25:03 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PVvSv-0006Ga-JV
	for git@vger.kernel.org; Fri, 24 Dec 2010 01:25:01 +0100
Received: from 75-144-0-121-busname-pa.hfc.comcastbusiness.net ([75.144.0.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 01:25:01 +0100
Received: from seh by 75-144-0-121-busname-pa.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 01:25:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 75-144-0-121-busname-pa.hfc.comcastbusiness.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.50 (darwin)
Cancel-Lock: sha1:qJCkUsWCOUEqW2tvYGPYEFX70r8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164141>

Junio C Hamano <gitster@pobox.com> writes:

> There is this gem in the completion script:

Thanks. I use zsh, and didn't want to force zsh to load the bash
completion scripts. After fumbling around first with the "vcs_info"
facility from zshcontrib, which worked acceptably, I found the
"zsh-git-prompt" project=C2=B9, integrated that, and am now amazed.


=46ootnotes:=20
=C2=B9 https://github.com/olivierverdier/zsh-git-prompt

--=20
Steven E. Harris
