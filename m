From: =?iso-8859-1?b?Sm9z6Q==?= Fonseca <j_r_fonseca@yahoo.co.uk>
Subject: [EGIT] UTF-8 in author names in history views read as ISO-8859-1
Date: Wed, 26 Sep 2007 22:04:03 +0000 (UTC)
Message-ID: <fdel0j$na4$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 00:10:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iaf5s-0007UJ-8o
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 00:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbXIZWKt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Sep 2007 18:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbXIZWKt
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 18:10:49 -0400
Received: from main.gmane.org ([80.91.229.2]:57302 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326AbXIZWKt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 18:10:49 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Iaf51-0005mi-JS
	for git@vger.kernel.org; Wed, 26 Sep 2007 22:10:03 +0000
Received: from 87-196-76-94.net.novis.pt ([87.196.76.94])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Sep 2007 22:10:03 +0000
Received: from j_r_fonseca by 87-196-76-94.net.novis.pt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Sep 2007 22:10:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 87-196-76-94.net.novis.pt
User-Agent: Pan/0.129 (Benson & Hedges Moscow Gold)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59253>

Hi,

=46irst, thanks for the work on egit -- it is progressively becoming mo=
re=20
and more useful.

I found that spite UTF-8 being the default encoding, egit is interpreti=
ng=20
(or displaying) names as ISO-8859-1 in the history view.

BTW, something I really miss from egit is "Team > Compare With > HEAD=20
revision" or something like that.

Keep up the good work!

Cheers,

Jos=C3=A9 Fonseca
