From: lalebarde <l.alebarde@free.fr>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Mon, 18 Jun 2012 13:03:36 -0700 (PDT)
Message-ID: <1340049816370-7561687.post@n2.nabble.com>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com> <1335029110871-7487506.post@n2.nabble.com> <1339918412381-7561644.post@n2.nabble.com> <CAL1Gx-Ufs8TNVeeefAXBnX-eCnEk_DC1w6oJVRPcMcStdL_+-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 18 22:03:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgiAo-0003QF-J2
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 22:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab2FRUDh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jun 2012 16:03:37 -0400
Received: from sam.nabble.com ([216.139.236.26]:54035 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838Ab2FRUDh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jun 2012 16:03:37 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <l.alebarde@free.fr>)
	id 1SgiAi-0007jt-CI
	for git@vger.kernel.org; Mon, 18 Jun 2012 13:03:36 -0700
In-Reply-To: <CAL1Gx-Ufs8TNVeeefAXBnX-eCnEk_DC1w6oJVRPcMcStdL_+-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200162>

Thanks for your clarifications ! stars 2 & 3 are still not clear for me=
=2E
Probably because I am new to git.

Do you think that if a solution is found, in the hypothesis it respects=
 both
git & strong cryptography, it would have success ? My analyse is that s=
mall
enterprises that do not have many servers nor premises may need git hos=
ting.
Even big companies with their own networks if they want more security.=20

TrueCrypt or encrypted file system on the host is not feasible off the
shelves. One have to settle its own dedicated server at the host.

On my side, I am afraid to push my projects in clear into a host. But
possibly I am too much parano=C3=AFde. Do you have an idea of the risk =
?

--
View this message in context: http://git.661346.n2.nabble.com/Transpare=
ntly-encrypt-repository-contents-with-GPG-tp2470145p7561687.html
Sent from the git mailing list archive at Nabble.com.
