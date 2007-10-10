From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH] git-gui: update Italian translation
Date: Wed, 10 Oct 2007 16:07:55 +0200
Message-ID: <200710101607.55452.barra_cuda@katamail.com>
References: <200710101533.17290.barra_cuda@katamail.com> <4d8e3fd30710100641p6fc6f610g435d2fe66462c05b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 16:07:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfcCN-0008H5-0V
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 16:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbXJJOEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2007 10:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbXJJOEJ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 10:04:09 -0400
Received: from slim-3c.inet.it ([213.92.5.125]:36121 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752506AbXJJOEI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2007 10:04:08 -0400
Received: from host200-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.200]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.200+CUvXg7p5SpE; Wed, 10 Oct 2007 16:04:05 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <4d8e3fd30710100641p6fc6f610g435d2fe66462c05b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60499>

On Wednesday 10 October 2007, Paolo Ciarrocchi wrote:
> > =A0#: git-gui.sh:1527
> > =A0msgid "Modified, not staged"
> > -msgstr "Modificato, non pronto per il commit"
> > +msgstr "Modificato, non preparato per l'archiviazione"
>=20
> I vote for leaving the word commit.
> I would be confused by the word "archiviazione".

Well, yes, most people currently using git will be as well.
But that's because they're used to it. The thread that talked
about the German translation decided to look for a fitting
German word, so I decided to follow them. If you're vetoing
these changes, I'll redo them. Otherwise, if you don't have
a strong adverse opinion, I think this translation is quite
clear, and would leave less people asking
"What's a commit?". Don't you think?
