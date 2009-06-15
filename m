From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 2/2] Add a ref log reader class
Date: Tue, 16 Jun 2009 00:21:19 +0200
Message-ID: <200906160021.19939.robin.rosenberg.lists@dewire.com>
References: <20090612195251.GQ16497@spearce.org> <1245101136-31874-1-git-send-email-robin.rosenberg@dewire.com> <1245101136-31874-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Jun 16 00:21:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGKYg-0003Uo-BT
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 00:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761017AbZFOWVa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 18:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754301AbZFOWV3
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 18:21:29 -0400
Received: from mail.dewire.com ([83.140.172.130]:27178 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132AbZFOWV3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 18:21:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0910A147D721;
	Tue, 16 Jun 2009 00:21:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b2GgiWtJFXOi; Tue, 16 Jun 2009 00:21:22 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id B7C4D147D5BB;
	Tue, 16 Jun 2009 00:21:21 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1245101136-31874-2-git-send-email-robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121636>

m=C3=A5ndag 15 juni 2009 23:25:36 skrev Robin Rosenberg <robin.rosenber=
g@dewire.com>:
> This reader allows the caller to the reflog entries for a given ref.

Oops a typo.

This reader allows the caller to read the reflog entries for a given re=
f.. I also noted=20
two missing comments in UIText.java. If you want to I can resend the wh=
ole
series(es).

-- robin
