From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: Submodule and proxy server.
Date: Mon, 22 Jun 2015 17:43:21 +0200
Message-ID: <20150622154321.GA13063@leeloo.kyriasis.com>
References: <CACnwYoPvcyERhtmqGeF4MJBuwCYX=sabUA5D=XVtT33vXe4HFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 17:43:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73sp-0007qU-9o
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbbFVPna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:43:30 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:48123 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930AbbFVPn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:43:26 -0400
Received: from theos.kyriasis.com (localhost.localdomain [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id af5ebc87;
	for <git@vger.kernel.org>;
	Mon, 22 Jun 2015 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=SrKfzQ/kXcZbH3MBa5813uJKX7A=; b=fOk8yD
	qQAxmUuZt7ug2pD4ntypSMHflbzmThJa4cekjdo/+F2Ll6PB9u3T6IFbADZ88ELS
	KTsPz35LUraQoGwPBpXxPouaZTBHHGDkYKYLwCLIroaEIRIt8VWhZoFSmI6pwoHN
	Z1litZjxk1Y8euoyBbiGrUy5/2rjZfObESNjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=ZrWCfy2l2RovAUlcmu7hqAMM5EimZwZF
	Aj5vuT/0XJKJpL+gsfroMIAliDvE92ylczZIJCnCymmBuy307J6M87BgTWmHUh7V
	y8lYZ1OfSYonwz+K+FGbZo4j4oRcfP84Rl7gNe9rQn2fu/7uQzQ97Gmm03BA7Dko
	Em5CLIypVRw=
Received: from leeloo.kyriasis.com (47.67.24.31.in-addr.zone [31.24.67.47]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 2dcc0777;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Mon, 22 Jun 2015 15:43:24 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CACnwYoPvcyERhtmqGeF4MJBuwCYX=sabUA5D=XVtT33vXe4HFQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272392>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22/06, Jamie Archibald wrote:
>fatal: unable to access
>'http://http://path/to/submodule/MySubmodule.git/': The requested URL
>returned error: 502
>

Did you copy this error verbatim?

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJViC0WAAoJEJAcHDIOsNRdAWQf/jVGUPvW/V98qrZa4H4eciGp
AYMUNLQSf3APHkeDuOHLU9nZmv630O6f5Tp8iijs/G30FP4ve4/UJq2qA51Rvjf+
VdwFCEibXc/ljkhFOjFQAb1Awy/on/SN5q4gGJsKxW4ut/AzHDpAm/ei9C8Dl5fd
eFx+p3uUJwUwlCO5OfRUV1odGjI1ObjPaHu6YStK5exv3X+g9J8V6dQB5tTh4Rbq
ocdRTzfitJFtCg9BDPIKmowrtLUu3FHHClhTs2n7fZBJgJCBHEi0Dq814rL8tDif
cJ3MTwjLzIx7Bu6c3wqocgkVhptQy+semjFX9QnEk60M2LqjC7wHCBurKRE4p8MV
dwpDp6DfUYluN/oDA7uNiPWxxyWBh7G/vv6dr78TMBLN+/vetZG9hcRFgTDeTYHM
2PwF4wTDEH/pm9af2RHDDnrqO2MEZt4+CMR8O5Yvnwn48DRaANJi4M3m7i/fh6gW
RoWggxzr11aERyYvGPdg2BPJ/wkMv7FSvk45F6S/eEre06G3Wib6X/BSvkgHApXo
3lbuN/NtlgPCeinSaKWLoGRcE/wvzecHXTnkDtDu2XjFkiE49+CbemZlmVH+oan2
hon4nP+Z2TvNRYDKp55j41ioq+BXaCHwE9A8ZrtBS0WI/sfb5sxquXP/z1e8lG9T
bXztem0VY2F3Th0YMgrUV92nTK6vPxFuL/uuggEQja49BGZROJkGprm7XFndQ3rl
iqTQ8ZMogrlD+O9OOehDP3BHelc7b3n5DNquLKf31xvz/tV8k35R5dt+CTAq9jEp
PP3xx5dvhvBM55eBdZtSCrnyd/nBOCxhwuFYjj911GfDn6T6NQiAnjApS8muMs0I
1PqMU/acdVb1FIIRByCE4kfeMP5queMUZrV5+D1QNh0OuPN1vj5mWvVGvJJ1ADFn
PP3svV5VplLx1Uh2ODk87RZ8vGrnhuqYwXNYIIUT8L7SxtRtcN7iktepWNw/vkSy
0G8WPGhwi6y8/H1Ypc86snzrj1ALAX4OvV2+GKbXoru8+5YOS5RHXmAtpksc+FjC
B1OHZCOdK+XSvXW3Jnb2Yc/dknQK3G+kJ3HihCcIk3dqk2SQvu4jHH2uw3CKbTUS
FaxEl3pUnOrE2ENT3tlr4TOqMYB2rxdOS7tP+BivRiTNjEDFNsQBMU9R6q9JDm8Q
LRALqkpAD/6nYTMhZUDdRED92V5GPDcrL/wKTHeDIGLeoyK+GvA1I4hyjZMcfqLh
qu9TXQYSBRPBlmw/vVwmf+VTVqVwlI/JGsm4I7lRbHOl23inSQvuw32INdsZvCbV
f91SrWbdEnp3xXeq1K8jxd1n3B0COvB/j9mqvz2Uqz8NJVrS19aNe8VmJqzjfog=
=sv1m
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
