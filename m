From: Thomas Koch <thomas@koch.ro>
Subject: Searching explanation of different diff algorithms
Date: Wed, 25 Sep 2013 09:24:15 +0200
Message-ID: <201309250924.15741.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 25 09:30:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOjYe-0008Qf-VH
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 09:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165Ab3IYHao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 03:30:44 -0400
Received: from emita2.mittwald.de ([188.94.250.252]:38484 "EHLO
	emita2.mittwald.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab3IYHao (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 03:30:44 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Sep 2013 03:30:43 EDT
Received: from mx51.mymxserver.com (mail5111.internal [172.16.51.11])
	by emita2.mittwald.de (Postfix) with ESMTP id 2E03D38DFAD
	for <git@vger.kernel.org>; Wed, 25 Sep 2013 09:24:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by localhost.mx51.mymxserver.com (Postfix) with ESMTP id 201341986AC
	for <git@vger.kernel.org>; Wed, 25 Sep 2013 09:24:22 +0200 (CEST)
X-Virus-Scanned: by Mittwald Mailscanner
Received: from mx51.mymxserver.com ([127.0.0.1])
	by localhost (mx51.mymxserver.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XV9EkZk+LlNk for <git@vger.kernel.org>;
	Wed, 25 Sep 2013 09:24:22 +0200 (CEST)
Received: from koch.localnet (gw.ptr-80-238-177-71.customer.ch.netstream.com [80.238.177.71])
	(Authenticated sender: koch@comsolit.ch)
	by mx51.mymxserver.com (Postfix) with ESMTP id 02EF719869C
	for <git@vger.kernel.org>; Wed, 25 Sep 2013 09:24:21 +0200 (CEST)
User-Agent: KMail/1.13.7 (Linux/3.10-0.bpo.2-amd64; KDE/4.8.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235334>

Is there any explanation available of the different merrits and drawbacks of 
the diff algorithms that Git supports?

I'm not satisfied with the default diff but have enough processing power for a 
slower algorithm that might produce diffs that better show the intention of the 
edit.

Thank you, Thomas Koch
