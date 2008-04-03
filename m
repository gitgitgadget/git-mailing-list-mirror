From: =?iso-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre_rosa@lge.com>
Subject: RES: [REGRESSION] git-gui
Date: Thu, 3 Apr 2008 11:34:05 -0300
Message-ID: <007d01c89597$c6d7f060$93a7c10a@LGE.NET>
References: <007901c89590$a827f7c0$93a7c10a@LGE.NET> <57518fd10804030700r6de977f5p6f0418e6eaea2583@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "'Jonathan del Strother'" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 16:35:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhQWn-000140-7R
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 16:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757418AbYDCOeO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2008 10:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757377AbYDCOeO
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 10:34:14 -0400
Received: from LGEMRELSE3Q.lge.com ([156.147.1.113]:35625 "EHLO
	LGEMRELSE3Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757191AbYDCOeN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2008 10:34:13 -0400
X-AuditID: 9c930171-a7ea1bb000000780-8c-47f4eae0bd20
Received: from SPSSO10NA0679 (unknown [156.147.140.121])
	by LGEMRELSE3Q.lge.com (Symantec Mail Security) with ESMTP id 8A70242000D;
	Thu,  3 Apr 2008 23:34:06 +0900 (KST)
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AciVjFyBCv4GxjBvT5Cz/lfk1qpBjwAC0tdg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
In-Reply-To: <57518fd10804030700r6de977f5p6f0418e6eaea2583@mail.gmail.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78758>

Hi,

>     I think it's related to git-gui 0.10 recently added into the tree=
=2E
> Doh, I broke git :(
> The problem is in c91ee2bd61 (Add shortcut keys for Show More/Less
Context).
> Works fine on my OS X 10.5 installation with tcl 8.4.7 - can anyone
suggest an alternative way of binding the left/right brackets?  I'm not
familiar with Tcl, and >=20
> didn't manage to find a list of key names.

Yes, reverting this commit fix the issue.

Thank you,
Andr=E9
