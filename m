From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: splitted directory objects
Date: Thu, 06 Sep 2012 16:02:22 +0200 (CEST)
Message-ID: <954301be-9c48-4f88-829b-1f735acb1ee6@zcs>
References: <7vzk534swa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 16:02:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9cfA-0005Qx-IJ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 16:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475Ab2IFOCZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Sep 2012 10:02:25 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:3563 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020Ab2IFOCY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 10:02:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 0BE1C62225B;
	Thu,  6 Sep 2012 16:02:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cdKtPyMAYsvU; Thu,  6 Sep 2012 16:02:22 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id B621A62203A;
	Thu,  6 Sep 2012 16:02:22 +0200 (CEST)
In-Reply-To: <7vzk534swa.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [92.206.119.117]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC18 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204883>


Hi,

> > IIRC some people were working on splitted directory objects
> > (eg. for putting subdirs into their own objects), some time ago.
>=20
> Each directory maps to its own tree object, so a subdirectory is
> stored in its own object.  It happened on April 7th, 2005, if not
> earlier.

Ah, great :)

Maybe I've mixed that up with the discussion about splitting large
files into several objects. What's the status on this ?


cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
