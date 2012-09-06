From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: splitted directory objects
Date: Thu, 06 Sep 2012 04:25:00 +0200 (CEST)
Message-ID: <3b47cf67-0c93-494a-8607-9cdc24a88f54@zcs>
References: <9580e7f9-666a-44db-91cb-45b3465f5f9a@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 04:25:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9RmK-0002gE-P0
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 04:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743Ab2IFCZD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Sep 2012 22:25:03 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:9309 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700Ab2IFCZC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2012 22:25:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id DAEBD62225B
	for <git@vger.kernel.org>; Thu,  6 Sep 2012 04:25:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TO8hX8-EG1hx for <git@vger.kernel.org>;
	Thu,  6 Sep 2012 04:25:00 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 8548062203A
	for <git@vger.kernel.org>; Thu,  6 Sep 2012 04:25:00 +0200 (CEST)
In-Reply-To: <9580e7f9-666a-44db-91cb-45b3465f5f9a@zcs>
X-Originating-IP: [91.43.204.13]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC18 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204853>

Hi folks,


IIRC some people were working on splitted directory objects
(eg. for putting subdirs into their own objects), some time ago.

What's the current status of this ?


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
