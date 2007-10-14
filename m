From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: Switching from CVS to GIT
Date: Sun, 14 Oct 2007 19:10:05 +0200
Message-ID: <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
References: <1192293466.17584.95.camel@homebase.localnet>
	<uy7e6keyv.fsf@gnu.org>
	<1192381040.4908.57.camel@homebase.localnet>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/mixed; boundary="===============0461327013=="
Cc: Make Windows <make-w32@gnu.org>
To: git list <git@vger.kernel.org>
X-From: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org Sun Oct 14 19:11:18 2007
Return-path: <make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org>
Envelope-to: gnu-make-w32@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih6zV-0008Ca-Ju
	for gnu-make-w32@m.gmane.org; Sun, 14 Oct 2007 19:11:01 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1Ih6zO-0006cR-9c
	for gnu-make-w32@m.gmane.org; Sun, 14 Oct 2007 13:10:54 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1Ih6zJ-0006bX-HE
	for make-w32@gnu.org; Sun, 14 Oct 2007 13:10:49 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1Ih6zI-0006aN-Kh
	for make-w32@gnu.org; Sun, 14 Oct 2007 13:10:49 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1Ih6zI-0006aH-HR
	for make-w32@gnu.org; Sun, 14 Oct 2007 13:10:48 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]
	helo=kualalumpur.lrde.epita.fr)
	by monty-python.gnu.org with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60) (envelope-from <tsuna@lrde.epita.fr>)
	id 1Ih6zB-0002VP-GA; Sun, 14 Oct 2007 13:10:41 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa
	(TLS-1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Ih6z9-0005w2-R1; Sun, 14 Oct 2007 19:10:39 +0200
In-Reply-To: <1192381040.4908.57.camel@homebase.localnet>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
X-detected-kernel: by monty-python.gnu.org: Linux 2.6 (newer, 3)
X-BeenThere: make-w32@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Discussion of Windows-specific issues with GNU make <make-w32.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/make-w32>
List-Post: <mailto:make-w32@gnu.org>
List-Help: <mailto:make-w32-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=subscribe>
Sender: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Errors-To: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60873>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0461327013==
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-63--673758817"
Content-Transfer-Encoding: 7bit

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-63--673758817
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Context: GNU make seems to be willing to switch from CVS to ...  
something else.

On Oct 14, 2007, at 6:57 PM, Paul Smith wrote:

> [...] the big thing no one else seems to have addressed much in
> other discussions I've seen is portability.  It LOOKS like there are
> native ports of GIT to MINGW, but I have no idea how complete and  
> usable
> they are.  If someone who has a Windows system could look into that it
> would be a big help.

I think the best thing to do is to ask directly on the Git ML.

Someone already pointed out that he'd like to use Git on Windows but  
doesn't want to install either Cygwin or MSYS.  Is this possible, or  
will it be possible in the near future?  Is it possible to use one of  
the various GUIs (git-gui, gitk, qgit) on Windows without requiring a  
POSIXish shell etc.?

When will the librarification of Git be finished?  (if Git is  
available as a library, and if this library works on Windows, it will  
greatly help truly native Windows ports).

Not that I like Windows in any way, right, but it's legitimate for  
people working on Windows ports of various software to be willing to  
have a truly native port of Git for Windows.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-63--673758817
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHEk1twwE67wC8PUkRAqZSAJ9Y9XlGn6S7yVDud2y+QUJsB9iTEgCg2Dn2
OjD6eWV63RvJ/kGHC3Z3/KE=
=jnln
-----END PGP SIGNATURE-----

--Apple-Mail-63--673758817--



--===============0461327013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Make-w32 mailing list
Make-w32@gnu.org
http://lists.gnu.org/mailman/listinfo/make-w32

--===============0461327013==--
