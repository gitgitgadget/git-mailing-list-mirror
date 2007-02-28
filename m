From: Bill Lear <rael@zopyra.com>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 13:23:48 -0600
Message-ID: <17893.54980.672279.633902@lisa.zopyra.com>
References: <17893.42063.186763.291346@lisa.zopyra.com>
	<20070228155412.GC5479@spearce.org>
	<17893.43522.511785.121778@lisa.zopyra.com>
	<17893.44181.129918.669187@lisa.zopyra.com>
	<20070228163256.GD5479@spearce.org>
	<118833cc0702280842g3e121fg601d7e102956ba93@mail.gmail.com>
	<20070228164922.GB5924@spearce.org>
	<17893.46083.869042.467318@lisa.zopyra.com>
	<20070228170641.GC5924@spearce.org>
	<17893.47007.136145.112498@lisa.zopyra.com>
	<20070228174339.GE5924@spearce.org>
	<17893.54640.150106.294218@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 20:23:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMUP4-00011H-6X
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 20:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbXB1TXu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 14:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbXB1TXu
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 14:23:50 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60910 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932386AbXB1TXt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 14:23:49 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1SJNmG08430;
	Wed, 28 Feb 2007 13:23:48 -0600
In-Reply-To: <17893.54640.150106.294218@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40992>

On Wednesday, February 28, 2007 at 13:18:08 (-0600) Bill Lear writes:
>
>% ls -l objects
>total 88088
>drwxr-xr-x  2 rael  software     4096 Feb 28 13:05 info/
>drwxr-xr-x  2 rael  software     4096 Feb 28 13:05 pack/
>-rw-------  1 rael  software 90099505 Feb 28 13:06 pack_eZwOnG

I should have added:

% ls -l ~/devel/fusion/.git/objects/pack/pack-fe532a54e5d549f1cfc70a4ab2c5f4eaac8897a5.pack
-r--r--r--  1 rael software 90099525 Feb 27 21:36 /home/rael/devel/project/.git/objects/pack/pack-fe532a54e5d549f1cfc70a4ab2c5f4eaac8897a5.pack

That's 20 bytes of difference.


Bill
