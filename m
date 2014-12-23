From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: Question on for-each-ref and --contains
Date: Tue, 23 Dec 2014 08:19:04 +0000 (UTC)
Message-ID: <loom.20141223T091605-427@post.gmane.org>
References: <CA++b5FaiKC2+U-Q_q7tBBjX2s+rLY6725H2ScUW26eOf-nmRjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 09:19:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Kge-0001pH-Gj
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 09:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbaLWITU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2014 03:19:20 -0500
Received: from plane.gmane.org ([80.91.229.3]:55211 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbaLWITT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 03:19:19 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Y3KgX-0001mg-Gl
	for git@vger.kernel.org; Tue, 23 Dec 2014 09:19:17 +0100
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 09:19:17 +0100
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 09:19:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:34.0) Gecko/20100101 Firefox/34.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261716>

St. Blind <st.s.blind <at> gmail.com> writes:

>=20
> The > git-branch --contains and --merged are not very handy too,
> because the> output is not really flexible, and the --merged works
> on HEAD only.
>=20
=20
`git branch --merged foo` will list branches that are merged in the his=
tory
of 'foo'. And the equivalent is true for `--contains`. Not sure if that=
 will
solve everything, though.

=C3=98sse
