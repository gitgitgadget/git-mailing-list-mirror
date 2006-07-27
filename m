From: Pavel Roskin <proski@gnu.org>
Subject: Re: Git clone stalls at a read(3, ...) saw using strace
Date: Thu, 27 Jul 2006 12:38:22 -0400
Message-ID: <1154018302.13273.0.camel@dv>
References: <b8bf37780607270516i7fbd8844he03e107b15fd2ed7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 27 18:39:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G68sX-0004Jj-TO
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 18:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWG0Qi0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 27 Jul 2006 12:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWG0Qi0
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 12:38:26 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:49599 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750874AbWG0Qi0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 12:38:26 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1G68sT-0001zl-8r
	for git@vger.kernel.org; Thu, 27 Jul 2006 12:38:25 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1G68sQ-0000uR-Ii; Thu, 27 Jul 2006 12:38:22 -0400
To: =?ISO-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
In-Reply-To: <b8bf37780607270516i7fbd8844he03e107b15fd2ed7@mail.gmail.com>
X-Mailer: Evolution 2.7.4 (2.7.4-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24297>

On Thu, 2006-07-27 at 08:16 -0400, Andr=E9 Goddard Rosa wrote:
> Hi, all!
>=20
>     Please CC me as I'm not subscribed.
>=20
>     Using  GIT 1.4.1, I tried to get this repository:

Please try git 1.4.1.1, it fixes git-clone.

--=20
Regards,
Pavel Roskin
