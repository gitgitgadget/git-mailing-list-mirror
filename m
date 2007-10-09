From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: git: avoiding merges, rebasing
Date: Tue, 9 Oct 2007 20:06:59 +0200
Message-ID: <AAC50815-7438-4934-81EC-02EE08B38854@lrde.epita.fr>
References: <200709301421.52192.bruno@clisp.org> <46FF99E2.8050605@byu.net> <200709302141.25597.bruno@clisp.org> <C64152A3-A5A6-4320-864C-E78E3A60C8E6@lrde.epita.fr> <07BCEF3E-90DE-4BB7-8A8C-F03D12293B5F@lrde.epita.fr> <Pine.LNX.4.64.0710091141440.4174@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6-1045138515"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 20:07:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfJUf-0003uQ-6O
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 20:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbXJISHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 14:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbXJISHf
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 14:07:35 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:35994 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbXJISHe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 14:07:34 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IfJUS-0002Fw-KJ; Tue, 09 Oct 2007 20:07:32 +0200
In-Reply-To: <Pine.LNX.4.64.0710091141440.4174@racer.site>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60424>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-6-1045138515
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 9, 2007, at 12:43 PM, Johannes Schindelin wrote:

> Hi,
>
> On Mon, 8 Oct 2007, Benoit SIGOURE wrote:
>
>> [as usual, I forgot the attachment...]
>
> Two comments:
>
> - by not inlining you made it hard to review your script.  Therefore I
>   will not do it.

:|

>
> - Try to avoid naming the script git-merge-*; these scripts/ 
> programs are
>   merge _strategies_, not merge _drivers_ (and yes, we already have  
> two
>   programs violating this rule -- merge-base and merge-file -- but  
> that
>   does not mean that you are free to add to the pile).

I'm open to better suggestions.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-6-1045138515
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHC8NDwwE67wC8PUkRAl1IAKDMXu1aYkRlfxY6oG0TjmvFjQVKXgCfduGd
juuusepKCCAfAfM5bCSni0k=
=GY73
-----END PGP SIGNATURE-----

--Apple-Mail-6-1045138515--
