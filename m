From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Auto-repo-repair
Date: Sat, 17 Nov 2012 10:21:49 +0100 (CET)
Message-ID: <075f74ff-cafb-4021-ba4d-2474b6fb1853@zcs>
References: <20121116190004.GA2310@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 17 10:22:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZebG-0001eD-VT
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 10:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026Ab2KQJVw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 04:21:52 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:20400 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753882Ab2KQJVu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 04:21:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id AF44162288C;
	Sat, 17 Nov 2012 10:21:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gStrwFQXyzPV; Sat, 17 Nov 2012 10:21:49 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 3E2DC622007;
	Sat, 17 Nov 2012 10:21:49 +0100 (CET)
In-Reply-To: <20121116190004.GA2310@sigill.intra.peff.net>
X-Originating-IP: [91.43.201.51]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209935>

Hi,

> You can't reliably just grab the broken objects, because most
> transports
> don't support grabbing arbitrary objects (you can do it if you have
> shell access to a known-good repository, but it's not automated).

can we introduce a new or extend existing transports to support that ?


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
