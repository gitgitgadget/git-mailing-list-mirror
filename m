From: P Rouleau <prouleau72@gmail.com>
Subject: Re: Setting up Git Server
Date: Thu, 15 Sep 2011 12:11:05 +0000 (UTC)
Message-ID: <loom.20110915T140243-187@post.gmane.org>
References: <CAOZxsTqFfOR+Eb3rqz5hZSJRTe=a1N-CEM--GGGGO2yayT-HLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 19:50:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4G4k-0006DZ-Kn
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 19:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934095Ab1IORuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 13:50:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:38983 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934054Ab1IORuH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 13:50:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R4G4a-00068J-IR
	for git@vger.kernel.org; Thu, 15 Sep 2011 19:50:04 +0200
Received: from modemcable176.18-203-24.mc.videotron.ca ([24.203.18.176])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 19:50:04 +0200
Received: from prouleau72 by modemcable176.18-203-24.mc.videotron.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 19:50:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.203.18.176 (Opera/9.80 (Windows NT 6.0; U; en) Presto/2.9.168 Version/11.51)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181481>

Joshua Stoutenburg <jehoshua02 <at> gmail.com> writes:

>=20
> Looking for some guidance in setting up a git server customized to my
> specific needs. =C2=A0Could anybody walk me through the process?
>=20
> I have a VirtualBox VM server on which I want to set up a cluster of =
VMs
> each one for a different purpose -- experimentation, web hosting, and=
,
> of course, git.
>=20
> I'm using Ubuntu 10.04 LTS for the operating system. =C2=A0I have a s=
ingle
> public ip address.

As you are using VMs, you should have a look at Turnkey-Linux
(http://turnkey-linux.com/). They offer ready-to-use linux appliances,=20
which are based on Ubuntu.=20

There is two for code revision which already include git, hg and subver=
sion.
There is also others appliances made to be web server.
