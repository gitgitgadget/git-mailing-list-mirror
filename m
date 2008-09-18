From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [TopGit PATCH] .gitignore += vim swap files
Date: Thu, 18 Sep 2008 21:30:03 +0400
Organization: St.Petersburg State University
Message-ID: <20080918173003.GJ11602@roro3>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru> <1221755370-6817-2-git-send-email-kirr@landau.phys.spbu.ru> <20080918172418.GA28942@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgNTc-0001he-DP
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 19:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbYIRRi1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Sep 2008 13:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbYIRRi1
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 13:38:27 -0400
Received: from vs281.server4u.cz ([81.91.85.31]:43874 "EHLO vs281.server4u.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754236AbYIRRi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 13:38:26 -0400
Received: from localhost ([127.0.0.1] helo=roro3)
	by vs281.server4u.cz with esmtp (Exim 4.69)
	(envelope-from <kirr@landau.phys.spbu.ru>)
	id 1KgNYy-00009X-K8; Thu, 18 Sep 2008 19:45:08 +0200
Received: from kirr by roro3 with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1KgNKN-0002oC-NI; Thu, 18 Sep 2008 21:30:03 +0400
Content-Disposition: inline
In-Reply-To: <20080918172418.GA28942@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96226>

On Thu, Sep 18, 2008 at 06:24:18PM +0100, martin f krafft wrote:
> also sprach Kirill Smelkov <kirr@landau.phys.spbu.ru> [2008.09.18.172=
9 +0100]:
> > +
> > +*.swp
>=20
> This should be .*.sw?

Right.

Should I resend the patch or will Petr correct it when applying?

--=20
    =D0=92=D1=81=D0=B5=D0=B3=D0=BE =D1=85=D0=BE=D1=80=D0=BE=D1=88=D0=B5=
=D0=B3=D0=BE, =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB.
