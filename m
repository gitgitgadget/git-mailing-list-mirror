From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Remove some junk characters from COPYING
Date: Sat, 16 Jan 2010 02:09:22 +0100
Message-ID: <201001160209.22589.robin.rosenberg@dewire.com>
References: <f3271551001150022p342dccd3r5e93b5f5354d208c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 02:09:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVxAj-00018a-EN
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 02:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758580Ab0APBJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 20:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758566Ab0APBJo
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 20:09:44 -0500
Received: from mail.dewire.com ([83.140.172.130]:25922 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758429Ab0APBJn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 20:09:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 31CE2147E0B4;
	Sat, 16 Jan 2010 02:09:42 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b7txTSF7Bxcu; Sat, 16 Jan 2010 02:09:23 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 91CAE147E0AD;
	Sat, 16 Jan 2010 02:09:23 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.4; i686; ; )
In-Reply-To: <f3271551001150022p342dccd3r5e93b5f5354d208c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137185>

fredagen den 15 januari 2010 09.22.30 skrev  Ramkumar Ramachandra:
> I removed a few ^L characters from COPYING. Kindly find patch
> attached. Again, I'm sorry I couldn't include it inline- I'm behind a
> restrictive firewall, and Gmail mangles up patches.

It is a form-feed (force new page when printing) so it should probably be 
called by that name, if it were to be removed.

-- robin
