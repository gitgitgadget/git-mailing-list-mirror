From: "Octavio Alvarez" <alvarezp@alvarezp.ods.org>
Subject: Re: Looks like --amend create commit... don't understand
Date: Thu, 25 Feb 2010 14:25:26 -0800
Message-ID: <op.u8pe8ovd4oyyg1@alvarezp-ws>
References: <4B8599C4.1050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: mat <matthieu.stigler@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 23:30:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkmEM-0001wu-Ia
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 23:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934256Ab0BYWap convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2010 17:30:45 -0500
Received: from [207.210.217.159] ([207.210.217.159]:54165 "EHLO
	spider.alvarezp.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S934167Ab0BYWao (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 17:30:44 -0500
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2010 17:30:44 EST
Received: from alvarezp-ws (host-193-99-in-prt.caliente.com.mx [201.139.193.99] (may be forged))
	(authenticated bits=0)
	by spider.alvarezp.com (8.13.8/8.13.8/Debian-3) with ESMTP id o1PMPUph013764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 25 Feb 2010 14:25:32 -0800
In-Reply-To: <4B8599C4.1050409@gmail.com>
User-Agent: Opera Mail/10.20 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141074>

On Wed, 24 Feb 2010 13:27:32 -0800, mat <matthieu.stigler@gmail.com> wr=
ote:

> I mean: with git log, there is only one commit, but on gitk, I see ma=
ny, =20
> with the same name but different revision ID.... My understanding was=
 =20
> that it would only replace, not create each time a new revision.. Cou=
ld =20
> you please explain me where I=C3=A0m wrong and what is happening exac=
tly?

Try doing "reload" (as opposed to just "update") using CTRL+F5 after yo=
u
amend in order to see only the new commits, and ignore the old ones. If
you have an old version of gitk, you might need to do it directly from
the menu.
