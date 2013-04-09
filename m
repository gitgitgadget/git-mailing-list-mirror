From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Teaching rerere about existing merges
Date: Tue, 9 Apr 2013 16:18:26 +0200 (CEST)
Message-ID: <504282025.1400346.1365517106800.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 09 16:18:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPZNZ-0000sr-VL
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 16:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761886Ab3DIOS3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 10:18:29 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:32880 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760703Ab3DIOS2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Apr 2013 10:18:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 3C2E4280B0
	for <git@vger.kernel.org>; Tue,  9 Apr 2013 16:18:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5NZiqfxgQixp for <git@vger.kernel.org>;
	Tue,  9 Apr 2013 16:18:26 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id DB6E528047
	for <git@vger.kernel.org>; Tue,  9 Apr 2013 16:18:26 +0200 (CEST)
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC26 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220572>

Hello everybody

I have just discovered rerere which seems to be an awesome feature....

unfortunately I have been merging and resolving conflicts on my reposit=
ory
for quite some time and I will soon do a rebase that would greatly
gain from using rerere...

is there a way to "teach" rerere about existing merge commits, or do I=20
have to re-solve all the existing merge manually once ?

    Regards

    J=C3=A9r=C3=A9my Rosen

fight key loggers : write some perl using vim
