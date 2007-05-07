From: David Kastrup <dak@gnu.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Mon, 07 May 2007 14:36:47 +0200
Message-ID: <86vef4yfmo.fsf@lola.quinscape.zz>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <8b65902a0705070440t40889af0p1fb8dbf7e2a072e4@mail.gmail.com> <20070507121603.GA3255@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 14:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl2Vk-0006TF-DO
	for gcvg-git@gmane.org; Mon, 07 May 2007 14:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933613AbXEGMkN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 May 2007 08:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933646AbXEGMkN
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 08:40:13 -0400
Received: from main.gmane.org ([80.91.229.2]:59934 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933613AbXEGMkL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 08:40:11 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Hl2VW-0000ve-5A
	for git@vger.kernel.org; Mon, 07 May 2007 14:40:02 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 May 2007 14:40:02 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 May 2007 14:40:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
Cancel-Lock: sha1:6fJzOZTVl/Za2wNzeAN9zlGkTbs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46457>

Karl Hasselstr=F6m <kha@treskal.com> writes:

> On 2007-05-07 13:40:33 +0200, Guilhem Bonnefille wrote:
>
>> In order to improve my productivity with Git, and in order to avoid
>> traps around moving from SVN to Git, I often use the Git Emacs mode.
>> It is really usefull for beginners as it works similarly for CVS,
>> SVN and Git: synthetic view of all modifications, easy selection of
>> what will be commited... The biggest drawback of this "porcelain":
>> using it, you do not understand the Git's index philosophy.
>
> git-gui is a good tool here (so good, in fact, that this is the secon=
d
> time today I spam the list about it).

Please be sure to _always_ include a URL whenever you are spamming.

--=20
David Kastrup
