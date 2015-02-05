From: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] cpu: add device_add foo-x86_64-cpu
 support
Date: Thu, 05 Feb 2015 08:25:39 -0700
Organization: Red Hat, Inc.
Message-ID: <54D38B73.4060803@redhat.com>
References: <cover.1421214154.git.zhugh.fnst@cn.fujitsu.com> <20150205114914.GA10126@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vJVjbNUh2u8Cm4C2l7EKWuvU6V8d5oPi9"
Cc: qemu-devel@nongnu.org, tangchen@cn.fujitsu.com,
	chen.fan.fnst@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com,
	imammedo@redhat.com, guz.fnst@cn.fujitsu.com,
	anshul.makkar@profitbricks.com, afaerber@suse.de,
	git@vger.kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>,
	Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 18:05:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJPrw-0006Aw-R3
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 18:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758173AbbBERF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 12:05:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46660 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754266AbbBERF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 12:05:27 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t15H51uf015337
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Feb 2015 12:05:12 -0500
Received: from [10.3.113.189] (ovpn-113-189.phx2.redhat.com [10.3.113.189])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t15FPdHn006985;
	Thu, 5 Feb 2015 10:25:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150205114914.GA10126@stefanha-thinkpad.redhat.com>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263379>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vJVjbNUh2u8Cm4C2l7EKWuvU6V8d5oPi9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding git list to cc]

On 02/05/2015 04:49 AM, Stefan Hajnoczi wrote:
> On Wed, Jan 14, 2015 at 03:27:23PM +0800, Zhu Guihua wrote:
>> This series is based on the previous patchset from Chen Fan:
>> https://lists.nongnu.org/archive/html/qemu-devel/2014-05/msg02360.html=

>=20
> This email has an invalid charset:
> Content-Type: text/plain; charset=3D"y"
>=20
> I guess you entered "y" when asked how the message was encoded.
>=20
> Please don't do that, it means we can only guess at the charset.

In the past, people made a similar problem when 'git send-email' was
asking if a message was in-reply-to something else (the number of
messages incorrectly threaded to a message-id of 'y' or 'n' was evidence
of the poor quality of the question).  git.git commit 51bbccfd1b4a
corrected that problem.  Sounds like charset encoding is another case
where the interactive parser should be taught to balk at nonsense
encoding answers?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vJVjbNUh2u8Cm4C2l7EKWuvU6V8d5oPi9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJU04tzAAoJEKeha0olJ0NqukEH/R0mHwErOYfjPiISU76SpjXU
O9wxnaqwWh5vONIHz3z0bX6LFuECyRS51yCrqsSeHh8MUBTPv0by3083/akBPrcg
Mqtc15rlsR1p2iaJ7n3CBaPwcIPHxmsUn8JVB4L+a133cmj/8XhhKjmen3gKvuh3
B1YQkPQrn/hGOVw/lLYkWXxweqdLGRdWDXoo6CrO5uyVqnWyPujDaVE4nNAxO1Ri
qsAzaoeCoW7WCnfkGe0DKOQ6bK+ueL/7oerZiVRR1T9RRNNOSufsrGplApOEXPus
k/BY32OWQjheJPoBWk7WHMDAcfehS/mKBb221+BItKPReNEliTRkiHtTo7JZ7Bg=
=so7v
-----END PGP SIGNATURE-----

--vJVjbNUh2u8Cm4C2l7EKWuvU6V8d5oPi9--
