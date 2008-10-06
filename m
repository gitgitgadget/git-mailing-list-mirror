From: Kristis Makris <kristis.makris-tTJs1oqo2yY@public.gmane.org>
Subject: Git and tagging hook
Date: Sun, 05 Oct 2008 21:45:32 -0700
Message-ID: <1223268332.4072.7.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_talos-24295-1223268494-0001-2"
Cc: scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
To: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org Mon Oct 06 06:46:52 2008
Return-path: <scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org>
Envelope-to: gcbsu-scmbug-users@m.gmane.org
Received: from 11-74-162-69.static.reverse.lstn.net ([69.162.74.11] helo=mail.loomcm.com)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmhze-000807-KA
	for gcbsu-scmbug-users@m.gmane.org; Mon, 06 Oct 2008 06:46:50 +0200
Received: from [69.162.74.11] ([::ffff:127.0.0.1])
  by talos with esmtp; Sun, 05 Oct 2008 21:48:14 -0700
  id 06320616.48E9988E.00005EE7
Received: from [192.168.0.70] ([::ffff:67.40.69.52])
	by talos with esmtp; Sun, 05 Oct 2008 21:48:08 -0700
	id 063205F8.48E99889.00005EB3
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97560>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_talos-24295-1223268494-0001-2
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_talos-24295-1223268494-0001-3"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_talos-24295-1223268494-0001-3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

It seems that Git (at least v1.5.6) does not offer hooks on tag creation
(a pre-tag and a post-tag hook). I need such a hook for integrating tag
activities with an issue-tracker. Is it possible to add this hook ?

I had asked about this in the past, but did not receive a response.

http://bugzilla.mkgnu.net/show_bug.cgi?id=3D991

Thanks,
Kristis

--=_talos-24295-1223268494-0001-3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI6Zfs/KuTDwnYLxERArizAJ9qoX1fyfOxnzSv6iUmCxJXdwytywCgoKR0
R6k+TP1wZXWPme1MP6ZgwVU=
=Oo8P
-----END PGP SIGNATURE-----

--=_talos-24295-1223268494-0001-3--

--=_talos-24295-1223268494-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
scmbug-users mailing list
scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
http://lists.mkgnu.net/cgi-bin/mailman/listinfo/scmbug-users

--=_talos-24295-1223268494-0001-2--
