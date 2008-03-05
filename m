From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on maxsize reached
Date: Wed, 5 Mar 2008 14:58:03 +0100
Organization: NextSoft
Message-ID: <200803051458.03593.michal.rokos@nextsoft.cz>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <200803050937.40345.michal.rokos@nextsoft.cz> <F5DC9F11-FD88-4713-AD1A-6566C345852A@manchester.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 15:01:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWu94-0001LA-AC
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 14:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbYCEN6M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 08:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbYCEN6L
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 08:58:11 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:45197 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbYCEN6K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 08:58:10 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id 120CE861; Wed,  5 Mar 2008 14:58:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 4AAED872
	for <git@vger.kernel.org>; Wed,  5 Mar 2008 14:58:08 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28635-07 for <git@vger.kernel.org>;
	Wed, 5 Mar 2008 14:58:08 +0100 (CET)
Received: from 89-24-238-42.i4g.tmcz.cz (89-24-238-42.i4g.tmcz.cz [89.24.238.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id B9506756
	for <git@vger.kernel.org>; Wed,  5 Mar 2008 14:58:07 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <F5DC9F11-FD88-4713-AD1A-6566C345852A@manchester.ac.uk>
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76216>

Hello,

On Wednesday 05 March 2008 11:35:25 Robert Haines wrote:
> > Could somebody else try to run testcase above on some other OSes?

thank you all for testing on SunOS, Windows, AIX, and MacOS!

Michal

--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
phone:  +420 267 224 311
fax:    +420 267 224 307
mobile: +420 736 646 591
e-mail: michal.rokos@nextsoft.cz
