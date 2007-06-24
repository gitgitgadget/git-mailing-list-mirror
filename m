From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Stupid quoting...
Date: Sun, 24 Jun 2007 22:17:47 +0200
Message-ID: <200706242217.48284.robin.rosenberg.lists@dewire.com>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <200706242139.44708.robin.rosenberg.lists@dewire.com> <85ejk1cexn.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Hudec <bulb@ucw.cz>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jun 24 22:17:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2YW5-0002Om-U4
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 22:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbXFXUQ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Jun 2007 16:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbXFXUQ6
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 16:16:58 -0400
Received: from [83.140.172.130] ([83.140.172.130]:16817 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbXFXUQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 16:16:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E66108026CB;
	Sun, 24 Jun 2007 22:10:08 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12801-07; Sun, 24 Jun 2007 22:10:08 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 8905E8026CA;
	Sun, 24 Jun 2007 22:10:08 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <85ejk1cexn.fsf@lola.goethe.zz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50817>

s=F6ndag 24 juni 2007 skrev David Kastrup:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
>=20
> > I was still in referernce to those "local conditions" at that
> > point. It was not meant as a universal statement. Substitutute that
> > for "A small bunch of swedish speaking people from Stockholm".
>=20
> A wrong encoding is a wrong encoding.  Escaping the characters in
> transition will not magically make the encodings adapt.  Escaping
> characters buys us exactly zilch _unless_ the _channel_ is not 8-bit
> clean.  In which case we should use a normal
> mail-armoring/attachment/inline data wrapper.
>=20
> In fact, when using editors with some heuristics regarding character
> sets (like Emacs), leaving 8-bit characters intact gives the editor a
> chance to guess the correct character set even if it is not the
> default on the receiving end.
>=20
> Escaping the characters, in contrast, just hides 8-bit usage away in
> transition.  An escaped character in the wrong encoding will get
> reconstituted into the wrong encoding.
>=20

Please don't quote me when the content is not in reference to me or wha=
t
I've written.

-- robin
