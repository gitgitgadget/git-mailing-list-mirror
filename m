From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 0/3] Improved object validation
Date: Fri, 31 Oct 2008 01:01:12 +0100
Message-ID: <200810310101.12241.robin.rosenberg@dewire.com>
References: <1225388785-26818-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 01:17:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvhiA-0003YU-6k
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 01:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbYJaAQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 20:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753873AbYJaAQk
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 20:16:40 -0400
Received: from mail.dewire.com ([83.140.172.130]:18087 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753325AbYJaAQj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 20:16:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D9F9D147CF6E;
	Fri, 31 Oct 2008 01:16:37 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GBiVqfY3j+rx; Fri, 31 Oct 2008 01:16:37 +0100 (CET)
Received: from [10.9.0.8] (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 0A173147CF70;
	Fri, 31 Oct 2008 01:16:37 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1225388785-26818-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99538>

torsdagen den 30 oktober 2008 18.46.22 skrev Shawn O. Pearce:
> This is mostly a resend as I haven't heard anything on the series.
> One new patch at the end, to handle '.' and '..' cases.
Ack, pushed now.  I never got to the push action, because I wanted
to do some testing on the bundlewriter (which you did not resubmit) and
the I went to a warmer place for a few days.

These patches and the bundlewrite + a small unit test for it now pushed.

-- robin
