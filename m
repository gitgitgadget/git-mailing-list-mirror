From: "Bevan Watkiss" <bevan.watkiss@cloakware.com>
Subject: (unknown)
Date: Thu, 7 May 2009 13:01:53 -0400
Message-ID: <454B76988CBF42F5BCACA5061125D263@caottdt504>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 07 19:05:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2720-0007JY-5l
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 19:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbZEGREd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2009 13:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbZEGREd
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 13:04:33 -0400
Received: from mail.cloakware.com ([142.46.212.116]:41093 "EHLO
	mail.cloakware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbZEGREc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 13:04:32 -0400
Received: from caottdt504 (bwatkiss-desk.cloakware.com [172.20.201.170])
	(authenticated bits=0)
	by mail.cloakware.com (8.13.1/8.13.1) with ESMTP id n47H4Wfb027628
	for <git@vger.kernel.org>; Thu, 7 May 2009 13:04:32 -0400
Subject: 
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Thread-Index: AcnPNYUotWI59YttT3iQisPQnD0SMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118492>

I am trying to create a working tree for people to read from and have i=
t
update from a bare repository regularly.=A0 Right now I am using git-pu=
ll to
fetch the changes, but it=92s running slow due to the size of my repo a=
nd the
speed of the hardware as it seems to be checking the working tree for a=
ny
changes.=A0=20

Is there a way to make the pull ignore the local working tree and only =
look
at files that are changed in the change sets being pulled?

Bevan
