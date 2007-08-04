From: Michael <barra_cuda@katamail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 4 Aug 2007 17:19:52 +0200
Message-ID: <200708041719.52682.barra_cuda@katamail.com>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net> <46B3F762.1050306@midwinter.com> <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Ismail =?iso-8859-1?q?D=F6nmez?= <ismail@pardus.org.tr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 17:19:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHLPb-0007tv-0O
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 17:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760014AbXHDPTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 4 Aug 2007 11:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759625AbXHDPTK
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 11:19:10 -0400
Received: from slim-3a.inet.it ([213.92.5.124]:59470 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756508AbXHDPTI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 11:19:08 -0400
Received: from host184-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.184]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.184+1LjHnxBAYIC; Sat, 04 Aug 2007 17:19:04 +0200
User-Agent: KMail/1.9.4
In-Reply-To: <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54864>

On Saturday 04 August 2007 06:38, Junio C Hamano wrote:
> It might be more worthwhile to research what other "Text-ish
> lightweight mark-up" systems are availble, and if there is one
> that is more efficient and can go to at least html and man,
> one-time convert our documentation source to that format using
> your Perl magic. =A0The minimum requirements are:
>=20
> =A0* The source is readable without too much mark-up distraction;
>=20
> =A0* Can go to roff -man;
>=20
> =A0* Can go to html.

I know about txt2tags, but I'm not sure it will be the right choice.

http://txt2tags.sourceforge.net/

It's in python, uses a markup similar to wiki, and can be used to
create documentation in man, html, plain txt.

But I haven't used it very much.
