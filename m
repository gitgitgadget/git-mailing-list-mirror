From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH2/2] fixed-toString-for-CommitTimeRevFilter-wrote-JUnit-tests
Date: Wed, 17 Jun 2009 00:19:08 +0200
Message-ID: <200906170019.11627.robin.rosenberg.lists@dewire.com>
References: <168892.81103.qm@web27804.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Wed Jun 17 00:19:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGh06-0003u9-PT
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 00:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288AbZFPWTV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2009 18:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756593AbZFPWTU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 18:19:20 -0400
Received: from mail.dewire.com ([83.140.172.130]:18659 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756528AbZFPWTT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2009 18:19:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C3534146D00E;
	Wed, 17 Jun 2009 00:19:16 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rr6DuQ5WrAv8; Wed, 17 Jun 2009 00:19:13 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 2939A1023455;
	Wed, 17 Jun 2009 00:19:13 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <168892.81103.qm@web27804.mail.ukl.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121716>

m=C3=A5ndag 15 juni 2009 23:36:35 skrev Mark Struberg <struberg@yahoo.d=
e>:
>=20
> From 72dd9d071ce140f267b8b4effd34d122627135e6 Mon Sep 17 00:00:00 200=
1
> From: Mark Struberg <struberg@yahoo.de>
> Date: Mon, 15 Jun 2009 08:07:53 +0200
> Subject: [PATCH] fixed toString for CommitTimeRevFilter + wrote JUnit=
 tests for after, before and between walks

What is the connection between the toString and the rest of the patch? =
Should be
separate patches.

You should sign off the patches.

Start the subject with a capital letter.

Technically it seemed ok, but I shouldn't have pushed them, as I did, b=
y mistake when pusing
Shawn's latest patch. The formal errors should have been fixed firsts.

-- robin
