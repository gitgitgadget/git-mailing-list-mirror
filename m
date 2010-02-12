From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Individual file snapshots
Date: Fri, 12 Feb 2010 21:41:42 +0100
Message-ID: <4B75BD06.1010802@lsrfire.ath.cx>
References: <ron1-CD3223.04030512022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 21:42:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng2L9-0000eo-2u
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 21:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757136Ab0BLUmK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 15:42:10 -0500
Received: from india601.server4you.de ([85.25.151.105]:43714 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab0BLUmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 15:42:09 -0500
Received: from [10.0.1.100] (p57B7C088.dip.t-dialin.net [87.183.192.136])
	by india601.server4you.de (Postfix) with ESMTPSA id 61DDD2F8050;
	Fri, 12 Feb 2010 21:42:05 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <ron1-CD3223.04030512022010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139744>

Am 12.02.2010 13:03, schrieb Ron Garret:
> Before I reinvent the wheel...
>=20
> I would like to be able to store snapshots of individual files withou=
t=20
> making a commit on the main branch.  The scenario is that I've writte=
n=20
> some experimental code that I have decided not to keep as part of the=
=20
> main project, but which I might want to refer back to some day.  Is=20
> there any easy way of doing that in git?

You could keep the experimental files (or changes) in a separate,
private branch on your local repository.

Ren=C3=A9
