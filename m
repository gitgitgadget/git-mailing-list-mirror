From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT] [PATCH] Make sure that the commit message has Unix format line
Date: Wed, 11 Feb 2009 18:53:54 +0100
Message-ID: <200902111853.54136.robin.rosenberg.lists@dewire.com>
References: <34467.77.61.241.211.1234338327.squirrel@hupie.xs4all.nl> <20090211161346.GD30949@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 18:56:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJIz-0003JS-LZ
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 18:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756280AbZBKRyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 12:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755199AbZBKRx6
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 12:53:58 -0500
Received: from mail.dewire.com ([83.140.172.130]:21394 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181AbZBKRx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 12:53:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 75C88147E8D8;
	Wed, 11 Feb 2009 18:53:55 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9drmSKmPQ4s8; Wed, 11 Feb 2009 18:53:54 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id B41AC147E8D5;
	Wed, 11 Feb 2009 18:53:54 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <20090211161346.GD30949@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109457>

onsdag 11 februari 2009 17:13:46 skrev Shawn O. Pearce:
> "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl> wrote:
> > From 2ad66e099fb35ad9a0d97e553843434b68ec82c9 Mon Sep 17 00:00:00 2001 From: Ferry Huberts <ferry.huberts@pelagic.nl>
> > Date: Wed, 11 Feb 2009 08:29:36 +0100
> > Subject: [PATCH] Make sure that the commit message has Unix format line delimiters
> > 
> > Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
> 
> Doesn't this change that I committed yesterday also fix this?

It does, so this patch is redundant. I also thing Yann's patch was the
correct place for the handling the problem.

-- robin
