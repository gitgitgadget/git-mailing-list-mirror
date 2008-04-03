From: =?iso-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre_rosa@lge.com>
Subject: [REGRESSION] git-gui
Date: Thu, 3 Apr 2008 10:43:08 -0300
Message-ID: <007901c89590$a827f7c0$93a7c10a@LGE.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 03 15:44:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhPjR-0005sO-OA
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 15:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013AbYDCNnN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2008 09:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754349AbYDCNnN
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 09:43:13 -0400
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:60274 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbYDCNnN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2008 09:43:13 -0400
X-AuditID: 9c930197-a9ffebb000006d2d-26-47f4deee0a85
Received: from SPSSO10NA0679 (unknown [156.147.140.121])
	by LGEMRELSE7Q.lge.com (Symantec Mail Security) with ESMTP id EB9F942000F
	for <git@vger.kernel.org>; Thu,  3 Apr 2008 22:43:09 +0900 (KST)
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AciVi7W69La8LEGHQN6AFAkBbO1/kgABKUQA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78750>

Hi, all!
=20
    After updating to git version 1.5.5.rc3 I always get the error belo=
w
when starting "git gui".
    Linux distributions used are opensuse 10 and opensuse Factory.
=20
# git gui
Error in startup script: bad event type or keysym "["
    while executing
"bind $ui_comm <$M1B-Key-\[> {show_less_context;break}"
    file "/usr/bin/git-gui" linux 2718)

    I think it's related to git-gui 0.10 recently added into the tree.
=20
Thanks a lot,
Andr=E9
