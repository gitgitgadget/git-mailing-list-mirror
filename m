From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 03/10] glossary: expand and clarify some definitions, prune cross-references
Date: Mon, 14 May 2007 19:00:48 +0200
Organization: At home
Message-ID: <f2a4b4$ein$3@sea.gmane.org>
References: <5520.48510076037$1179156136@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 19:00:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnduB-0004qI-7A
	for gcvg-git@gmane.org; Mon, 14 May 2007 19:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbXENRAJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 14 May 2007 13:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbXENRAI
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 13:00:08 -0400
Received: from main.gmane.org ([80.91.229.2]:49295 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658AbXENRAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 13:00:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Hndty-00086g-6U
	for git@vger.kernel.org; Mon, 14 May 2007 19:00:02 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 May 2007 19:00:02 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 May 2007 19:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47272>

J. Bruce Fields wrote:

> +[[def_detached_HEAD]]detached HEAD::
> +=A0=A0=A0=A0=A0=A0=A0Normally HEAD refers to the tip of a
> +=A0=A0=A0=A0=A0=A0=A0<<def_branch,branch>>.

Normally HEAD refers to the branch _name_ (names current branch).
=46rom this sentence one can think that normally HEAD is pointer
to commit which is tip of current branch.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
