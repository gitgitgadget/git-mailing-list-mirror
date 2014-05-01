From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Pull is Evil
Date: Thu, 1 May 2014 16:59:33 -0700
Message-ID: <20140501235933.GA28634@odin.tremily.us>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <E699B6CE8ADD46618D52F05DB8EF6F07@PhilipOakley>
 <5362d9eeb8b30_12fe14dd310e6@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
	Marat Radchenko <marat@slonopotamus.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 01:59:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg0tB-0004xS-8B
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 01:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbaEAX7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 19:59:37 -0400
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:51230
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752076AbaEAX7g (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 19:59:36 -0400
Received: from omta05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by qmta08.westchester.pa.mail.comcast.net with comcast
	id wnr61n0030vyq2s58nzbeo; Thu, 01 May 2014 23:59:35 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta05.westchester.pa.mail.comcast.net with comcast
	id wnzZ1n00L152l3L3RnzaDB; Thu, 01 May 2014 23:59:35 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 5145A11739D0; Thu,  1 May 2014 16:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1398988773; bh=/RsjkSIf7x2ZPxHfBUfd+i4AZJnndS1JbIw6VX5f8YE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W8C+0A4oTEXvJJ3igGNxNHQwqO4kmCNKP+TI82HW99+hh9TA0corEszhSZkCPssmk
	 36hc721cK2rIP+p86SZqVQCksI9Bmr5ml/cyIeaTyep7RNL2dt/5ODUmRhoRgA79GQ
	 ITmRw1TWy8JiY1TlQMy4adopTYpnRtl8rNU2GkUw=
Content-Disposition: inline
In-Reply-To: <5362d9eeb8b30_12fe14dd310e6@nysa.notmuch>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1398988775;
	bh=saFg4+Bgg5oTgmnFTp3sEK/fvji6H+XYq76NfCuakdk=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=aJaYjM/RvwqbGpUBp6M7J7IZgcGbsHH/CMDoltVU0hp7VGwChH/5mgY/crVUVdeqe
	 bNC5ea8nSSHcVFoUP6umKu7lMsWZiw36AfTIQyC4+hAXbSmLbGGCWkRAzJSlKmn4rS
	 oTv89sXoRNgarWsRlgTdPcTx8MRCnkcXgyuTn2S83rCsxjPDe63fXpunkuCp21cC2H
	 QuZj5JtlpJCAKJPSGg4NFMzG7RwBl2ol9EqgJ6HPq4zOYK2XZE4xSPYVqLb+HFlZwF
	 6H6BcBT/70Wgqe/Ln5FIGz4SjEF5vOVOXyUduEiDumB/UScjBMjXedagMyo4KvaGLR
	 bZEVqikT/p/Ng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247899>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 06:34:06PM -0500, Felipe Contreras wrote:
> Nobody ever complained about somebody doing a fast-forward by mistake.

Unless they fast-forward merged a feature branch into master, but the
project prefers explicitly-merged feature branches with a cover-letter
explaination in the merge commit [1].  On the one hand, folks
integrating feature branches are likely more experienced Git users.
On the other hand, I know several project maintainers who integrate
feature branches that are pull-happy.

I agree that accidental ff-merges are likely to be less troublesome
than accidental non-ff merge/rebases, but I don't think changing the
default to ff-only is a perfect fix.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/247807

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYt/iAAoJEKKfehoaNkbtG0UQAI4MeTauBpUwTvHlqT0Q0hcm
Qyx+Y42QnDtv2NmdPhIxE+dmR7KK+QDdQYNlR0e6Xrx94nOJh1j7uf7sh4FxtG1I
/RkrlNKFKyFw8rPamTuZPsZXoV7IGEoPrAXThfk36yNwrXhKtTvKgwiUnLQvs8X+
riWCovM2baqMDr415OUnfv+FU+8+a87Bm3+MKJwSc/7ZOkKdkdS2azmdF84Utk+/
SLlVVi9xeDgm0suLsDEwBqG0mVFlVaZ8+l3rQgJDaz+Gk99iaNE3BHwBiHDMqZ8T
wZ42Xpyw4T/l4cn4B99RAqGFT/HkXPu5K55itzbFIHCVr7xGE7SiwHnK776b0sym
PDkXVQcvepU48a2LFcBUTLdXAa+9OAGbNRvT/5gXaS1tnpkoP/2NoJ4UuYhCKp9g
dFsUAsvd1fvlPNDHtjwltk6RC0NYxLwzSrBY7YCpMm6ogsjyWmc4yjg5OkY7SZNm
9UbQb3ATNLqp0Yd0hV8LyIh0TWf39MZGQHGImNiuHCfcCPohr9hFi6GwsuT631ue
v3qWeAEG4mDjcEk61h1Wphu17tqLJnHMzQn/Eh2XYB3vNlGSYoT084NUruZMr0Sf
KDzUrfQPMJCflmqEbQNhSFVh1v56alZK7w1bHunglONWgCBGDeVUwhJNBBpnnoGS
GXMT4/HcjOqhfKF8xFdy
=1aQA
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
