From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: git-svn dcommit failure
Date: Sat, 09 Jun 2007 22:22:09 +0200
Message-ID: <87d504g9ou.fsf@mid.deneb.enyo.de>
References: <87veecat2k.fsf@mid.deneb.enyo.de>
	<87d50kas6p.fsf@mid.deneb.enyo.de>
	<20070529144742.GG1025@.intersec.eu>
	<87k5ur64hx.fsf@mid.deneb.enyo.de> <20070605101744.GA12948@muzzle>
	<87abvb508z.fsf@mid.deneb.enyo.de> <20070609200527.GC32225@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 22:22:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx7Rw-0005rS-Kt
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 22:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759091AbXFIUWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 16:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759059AbXFIUWN
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 16:22:13 -0400
Received: from mail.enyo.de ([212.9.189.167]:2955 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759020AbXFIUWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 16:22:13 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1Hx7Rq-0002L0-RB; Sat, 09 Jun 2007 22:22:11 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1Hx7Rp-0003ie-99; Sat, 09 Jun 2007 22:22:09 +0200
In-Reply-To: <20070609200527.GC32225@muzzle> (Eric Wong's message of "Sat, 9
	Jun 2007 13:05:27 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49612>

* Eric Wong:

>> If such bugs turn up, I'd try to debug them on
>> my own and submit a fix, or at least a reproduction recipe.  (The
>> repository itself may contain personally identifiable information in
>> test cases and hence, cannot be shared.)
>
> Was the commit modifying a file that was just one directory deep from
> the project you were working on?

Yes, it was.
