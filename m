From: Sam Vilain <sam@vilain.net>
Subject: Re: Stripping 'git-svn-id' from commit messages, and switching to
 svn.noMetadata
Date: Fri, 25 Jan 2008 10:19:27 +1300
Message-ID: <479900DF.9010904@vilain.net>
References: <877ii0p89b.fsf@adler.orangeandbronze.com> <4797D6C6.207@vilain.net> <4798CC88.505@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: JM Ibanez <jm@orangeandbronze.com>, git <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Thu Jan 24 22:20:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI9UR-0002YU-4b
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 22:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534AbYAXVTc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 16:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756561AbYAXVTc
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 16:19:32 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:59158 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756419AbYAXVTb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 16:19:31 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id A38DA21D12B; Fri, 25 Jan 2008 10:19:30 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 67BC921C7F9;
	Fri, 25 Jan 2008 10:19:27 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <4798CC88.505@obry.net>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71665>

Pascal Obry wrote:
> Sam Vilain a =E9crit :
>> Use a graft.  in .git/info/grafts, put (expanding to the full SHA1s)=
:
>=20
> It is not the first time I see somebody talking about graft... I stil=
l=20
> don't know exactly what it is. Any pointers to literature about this?

Documentation/repository-layout.txt in the distribution

Debian for one installs this to
/usr/share/doc/git-doc/repository-layout.html

Sam.
