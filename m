From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: git rebase : knowing where I am...
Date: Wed, 10 Apr 2013 10:40:33 +0200 (CEST)
Message-ID: <1124759476.1420642.1365583233806.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 10 10:40:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPqaD-0007LU-52
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 10:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685Ab3DJIkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 04:40:39 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:43402 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab3DJIkh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Apr 2013 04:40:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 60A6728065
	for <git@vger.kernel.org>; Wed, 10 Apr 2013 10:40:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g-cQosUSb4hS for <git@vger.kernel.org>;
	Wed, 10 Apr 2013 10:40:34 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id F412B28047
	for <git@vger.kernel.org>; Wed, 10 Apr 2013 10:40:33 +0200 (CEST)
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC26 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220673>

Hello

is there some way to know how far you are within a rebase when the reba=
se is interupted by a conflict other than the message given by git reba=
se when it was interrupted ?

I would have expected a git rebase --status or something similar...

    Regards

    J=C3=A9r=C3=A9my Rosen

fight key loggers : write some perl using vim
