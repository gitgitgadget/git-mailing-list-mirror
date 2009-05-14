From: Michael Radziej <mir@noris.de>
Subject: Re: [Q] merge squash unexpected conflicts
Date: Thu, 14 May 2009 09:01:29 +0200
Message-ID: <20090514070129.GL8212@noris.de>
References: <bb9d69200905131706m61b0dda1xc347ca2e719ec142@mail.gmail.com> <bb9d69200905131942t7a43a29fh9638d2548e9f12dc@mail.gmail.com> <7v4ovo1iap.fsf@alter.siamese.dyndns.org> <bb9d69200905132057u60adc2f8vb9ba9a35791f72ac@mail.gmail.com> <7veiusz45w.fsf@alter.siamese.dyndns.org> <bb9d69200905132334m7a4e3a4akde3529abeab5a09@mail.gmail.com> <7v4ovoxk0n.fsf@alter.siamese.dyndns.org> <bb9d69200905132354h6b64171g24351840fb1d0893@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Cory Sharp <cory.sharp@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 09:10:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4V5i-0006UU-Ir
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 09:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbZENHKp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 03:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbZENHKo
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 03:10:44 -0400
Received: from mail04.noris.net ([62.128.1.224]:50113 "EHLO mail04.noris.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbZENHKo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 03:10:44 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 May 2009 03:10:44 EDT
Received: from mail03.noris.net ([62.128.1.223])
	by mail04.noris.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mir@noris.de>)
	id 1M4Uws-00018I-1c
	for git@vger.kernel.org; Thu, 14 May 2009 09:01:46 +0200
Received: from mail-intern.backup.noris.net ([10.1.0.25] helo=mail.office.noris.de)
	by mail03.noris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1M4Uwb-0005sj-Cz; Thu, 14 May 2009 09:01:29 +0200
Received: from mir.office.noris.de ([10.2.6.66] ident=postfix)
	by mail.office.noris.de with esmtp (Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1M4Uwb-00006B-9H; Thu, 14 May 2009 09:01:29 +0200
Received: by mir.office.noris.de (Postfix, from userid 294)
	id 361871107F6C; Thu, 14 May 2009 09:01:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bb9d69200905132354h6b64171g24351840fb1d0893@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Noris-IP: 10.1.0.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119156>

On Wed, May 13, Cory Sharp wrote:

> Yeah I'm not quite getting it.  Thanks for trying to explain, though.

git merge --squash is not a merge at all. It only creates a regular com=
mit
with one parent. It is useful only in very special circumstances.


Michael

--=20
noris network AG - Deutschherrnstra=DFe 15-19 - D-90429 N=FCrnberg -
Tel +49-911-9352-0 - Fax +49-911-9352-100
http://www.noris.de - The IT-Outsourcing Company
=20
Vorstand: Ingo Kraupa (Vorsitzender), Joachim Astel, Hansjochen Klenk -=
=20
Vorsitzender des Aufsichtsrats: Stefan Schnabel - AG N=FCrnberg HRB 176=
89
