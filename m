From: Kristis Makris <kristis.makris-tTJs1oqo2yY@public.gmane.org>
Subject: Re: Git and tagging hook
Date: Wed, 08 Oct 2008 09:47:25 -0700
Message-ID: <1223484445.4055.8.camel@localhost>
References: <1223268332.4072.7.camel@localhost> <48E9BB72.2080008@op5.se>
	<1223399613.20250.1.camel@localhost>  <gcg67d$4o2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_talos-13708-1223484613-0001-2"
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
To: Jakub Narebski <jnareb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org Wed Oct 08 18:51:04 2008
Return-path: <scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org>
Envelope-to: gcbsu-scmbug-users@m.gmane.org
Received: from 11-74-162-69.static.reverse.lstn.net ([69.162.74.11] helo=mail.loomcm.com)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KncDG-0002JP-Eh
	for gcbsu-scmbug-users@m.gmane.org; Wed, 08 Oct 2008 18:48:38 +0200
Received: from [69.162.74.11] ([::ffff:127.0.0.1])
  by talos with esmtp; Wed, 08 Oct 2008 09:50:13 -0700
  id 06171194.48ECE4C5.0000358C
Received: from [192.168.0.71] ([::ffff:67.40.69.52])
	by talos with esmtp; Wed, 08 Oct 2008 09:50:11 -0700
	id 06170BD2.48ECE4C3.00003566
In-Reply-To: <gcg67d$4o2$1@ger.gmane.org>
X-Mailer: Evolution 2.6.3 
X-BeenThere: scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: General Scmbug list <scmbug-users.lists.mkgnu.net>
List-Unsubscribe: <http://lists.mkgnu.net/cgi-bin/mailman/listinfo/scmbug-users>, 
	<mailto:scmbug-users-request-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.mkgnu.net/pipermail/scmbug-users>
List-Post: <mailto:scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org>
List-Help: <mailto:scmbug-users-request-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org?subject=help>
List-Subscribe: <http://lists.mkgnu.net/cgi-bin/mailman/listinfo/scmbug-users>, 
	<mailto:scmbug-users-request-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org?subject=subscribe>
Sender: scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
Errors-To: scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97804>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_talos-13708-1223484613-0001-2
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_talos-13708-1223484613-0001-3"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_talos-13708-1223484613-0001-3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-10-07 at 19:28 +0200, Jakub Narebski wrote:
> Kristis Makris wrote:
>=20
> > But the post-receive is NOT executed when I apply a tag.
> >=20
> > I want the integration when I apply the tag to a local repository, NOT
> > only when I push/pull.
>=20
> If you are talking about taging locally, you can simply make an alias
> or do something after tagging. Search archives for description when
> it is worth to add a hook, and when it is not.

I am looking for a guarantee that is better than casually saying
"simply". I will be providing the integration work to users that may not
be as comfortable with making aliases.=20

I still don't see why a hook on local tagging is not available. Is it
possible to add support in Git for such a hook ? Both pre-tag and
post-tag.

--=_talos-13708-1223484613-0001-3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI7OQd/KuTDwnYLxERAooWAKCefDbWUfWOPCpIV7C7Cpu76BebCQCggsOI
Zadoa7DA1mzOzai58aiU3VQ=
=xwVw
-----END PGP SIGNATURE-----

--=_talos-13708-1223484613-0001-3--

--=_talos-13708-1223484613-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
scmbug-users mailing list
scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
http://lists.mkgnu.net/cgi-bin/mailman/listinfo/scmbug-users

--=_talos-13708-1223484613-0001-2--
