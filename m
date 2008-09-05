From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Git User's Survey 2008
Date: Fri, 5 Sep 2008 16:12:55 +0200
Message-ID: <20080905141255.GZ10544@machine.or.cz>
References: <200808312329.17312.jnareb@gmail.com> <48BB9742.3000109@gmail.com> <200809011034.48342.jnareb@gmail.com> <48BE8109.9030701@jaeger.mine.nu> <1a6be5fa0809030546n28e2a1besdc4435e874f2f0f9@mail.gmail.com> <94a0d4530809030949v7c8c6ec4uc60bc873a40637d0@mail.gmail.com> <e29894ca0809050646g2f198890le2312d065696d1dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Tor Arvid Lund <torarvid@gmail.com>,
	Christian Jaeger <christian@jaeger.mine.nu>
To: =?iso-8859-2?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 16:14:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbc4i-0006uS-U4
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 16:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbYIEONG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 10:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbYIEONF
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 10:13:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55931 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909AbYIEONF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 10:13:05 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id C5083393A370; Fri,  5 Sep 2008 16:12:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e29894ca0809050646g2f198890le2312d065696d1dd@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95014>

On Fri, Sep 05, 2008 at 04:46:02PM +0300, Marc-Andr=E9 Lureau wrote:
> If somebody could explain how they handle the git send-mail patches
> they recieve, I would be thankful. How do you create .mbox files? Wha=
t
> is your workflow when you deal with mails?

  In mutt, I tag the mails with patches, ;C them to an empty file and
git am the file.

				Petr "Pasky" Baudis
