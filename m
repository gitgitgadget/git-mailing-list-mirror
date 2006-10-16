From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: git-pull question
Date: Mon, 16 Oct 2006 03:00:36 +0200
Message-ID: <012c01c6f0be$7d329fc0$1267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 16 03:02:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZGsb-0006kt-5X
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 03:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWJPBCy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 21:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWJPBCy
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 21:02:54 -0400
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:13718
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1751038AbWJPBCx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 21:02:53 -0400
Received: from Jocke ([84.217.9.178]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 16 Oct 2006 03:02:41 +0200
To: <git@vger.kernel.org>
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: Acbwvn0Kl1hn81+aRKmtdzDXUXz9hw==
X-OriginalArrivalTime: 16 Oct 2006 01:02:41.0841 (UTC) FILETIME=[C81CA210:01C6F0BE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28941>

Why isn't
  git checkout -b myb otherb
  git pull . thirdb

the same as
  git checkout -b myb otherb
  git pull . thirdb:myb

 Jocke
