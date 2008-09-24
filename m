From: Andrew Vit <andrew@avit.ca>
Subject: Re: Files that want to delete themselves
Date: Wed, 24 Sep 2008 11:18:30 -0700 (PDT)
Message-ID: <1222280310309-1116082.post@n2.nabble.com>
References: <19654453.post@talk.nabble.com> <20080924180436.GJ10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 20:19:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiYxx-0005UR-Bv
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 20:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbYIXSSc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2008 14:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbYIXSSb
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 14:18:31 -0400
Received: from kuber.nabble.com ([216.139.236.158]:37037 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbYIXSSb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Sep 2008 14:18:31 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1KiYwY-000490-AE
	for git@vger.kernel.org; Wed, 24 Sep 2008 11:18:30 -0700
In-Reply-To: <20080924180436.GJ10544@machine.or.cz>
X-Nabble-From: andrew@avit.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96677>



Petr Baudis wrote:
>=20
>   so how does that look like in git diff? My guess is you have a .git=
/
> subdirectory there and thus Git assumes that it is a submodule?
>=20

Yes, that did it! I was sure I deleted that .git directory in the plugi=
n,
I'm guessing it came back when I downloaded an updated one a while ago.=
=2E.

D=C3=ADky za dobrou radu!

--Andrew Vit

--=20
View this message in context: http://n2.nabble.com/Files-that-want-to-d=
elete-themselves-tp1116033p1116082.html
Sent from the git mailing list archive at Nabble.com.
