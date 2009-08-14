From: =?iso-8859-1?Q?PICCA_Fr=E9d=E9ric-Emmanuel?= 
	<frederic-emmanuel.picca@synchrotron-soleil.fr>
Subject: =?iso-8859-1?Q?RE=A0=3A_RE_=3A_RE_=3A_trailling_whitespace_with_git_am_=3F?=
Date: Fri, 14 Aug 2009 22:50:11 +0200
Message-ID: <606CC410B038E34CB97646A32D0EC0BF0181FAC1@venusbis.synchrotron-soleil.fr>
References: <81b0412b0908141348icee65d6kf4188cbd68405c0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:52:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc3l8-0000gN-67
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 22:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbZHNUwO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 16:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754193AbZHNUwO
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 16:52:14 -0400
Received: from dns.synchrotron-soleil.fr ([195.221.0.3]:34830 "EHLO
	sucette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753851AbZHNUwN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 16:52:13 -0400
Received: from localhost (unknown [127.0.0.1])
	by sucette.synchrotron-soleil.fr (Postfix) with ESMTP id 4F03A3D6DC;
	Fri, 14 Aug 2009 20:52:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from sucette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (sucette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DJK71W4clCz1; Fri, 14 Aug 2009 22:52:08 +0200 (CEST)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by sucette.synchrotron-soleil.fr (Postfix) with ESMTP id 5D6873D750;
	Fri, 14 Aug 2009 22:52:08 +0200 (CEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE : RE : trailling whitespace with git am ?
Thread-Index: AcodIJ9oJRpH4KlRSj+79sc20dVnEwAADFGc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125954>

>=A0> git am --whitespace=3Dfix was sufficient to apply the patch

> Depending on your situation it can be an overkill: it'll remove _all_=
 trailing
> white space. Not just \r (CR).

so /s /t and /r are the same things for git ?
