From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT] [PATCH v3 0/1] Make sure to setup a clone the same as git-clone does
Date: Mon, 23 Feb 2009 20:51:28 +0100
Message-ID: <200902232051.28459.robin.rosenberg.lists@dewire.com>
References: <cover.1235415204.git.ferry.huberts@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Mon Feb 23 20:53:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbgrT-0004DJ-4I
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 20:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbZBWTvj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2009 14:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753109AbZBWTvi
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 14:51:38 -0500
Received: from mail.dewire.com ([83.140.172.130]:8388 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752783AbZBWTvi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2009 14:51:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D2B7F147E9CE;
	Mon, 23 Feb 2009 20:51:30 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lA+PLB6Bd4+l; Mon, 23 Feb 2009 20:51:30 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 44EB1147E9C7;
	Mon, 23 Feb 2009 20:51:30 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-12-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <cover.1235415204.git.ferry.huberts@pelagic.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111172>

m=E5ndag 23 februari 2009 19:55:22 skrev Ferry Huberts <ferry.huberts@p=
elagic.nl>:
> Currently the plugin does not setup the default remote branch, someth=
ing that
> git-clone does do.

If you have only one patch in a series, please send only one email. For=
 "extra" comment
that you don't want to go in to the commit message add them after the "=
---" that follows
the commit message.

-- robin
