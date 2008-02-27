From: Tim Stoakes <tim@stoakes.net>
Subject: Re: git-svn messing with timezones
Date: Thu, 28 Feb 2008 09:39:16 +1030
Message-ID: <20080227230916.GF18074@mail.stoakes.net>
References: <20080226124748.GH31792@mail.stoakes.net> <20080227073244.GB24316@soma> <20080227102631.GJ30300@mail.stoakes.net> <alpine.LSU.1.00.0802271039220.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 28 00:10:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUVPc-0001qP-9U
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 00:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762019AbYB0XJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 18:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756250AbYB0XJb
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 18:09:31 -0500
Received: from hosted02.westnet.com.au ([203.10.1.213]:47914 "EHLO
	hosted02.westnet.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761991AbYB0XJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 18:09:29 -0500
Received: from hosted02.westnet.com.au (hosted02.westnet.com.au [127.0.0.1])
	by hosted02.westnet.com.au (Postfix) with SMTP id 4D73749EDD;
	Thu, 28 Feb 2008 08:09:20 +0900 (WST)
Received: from mail.stoakes.net (dsl-202-173-137-105.sa.westnet.com.au [202.173.137.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hosted02.westnet.com.au (Postfix) with ESMTP id 0FE9F4A40D;
	Thu, 28 Feb 2008 08:09:09 +0900 (WST)
Received: from noodle.stoakes.net (unknown [192.168.20.209])
	by mail.stoakes.net (Postfix) with ESMTP id 7774628C1EE;
	Thu, 28 Feb 2008 09:39:08 +1030 (CST)
Received: by noodle.stoakes.net (Postfix, from userid 1000)
	id CAB4F7F025; Thu, 28 Feb 2008 09:39:16 +1030 (CST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802271039220.22527@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-PMX-Branch: TNG-Outgoing
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75320>

Johannes Schindelin(Johannes.Schindelin@gmx.de)@270208-10:40:
> Note: if all you want is such a strange behaviour as svn's (I mean, why 
> does it insist to show the dates as if they were done in _your_ 
> timezone?):
> 
> 	git log --date=local

Ah excellent, that's what I want I think. I'm stuck with SVN for work,
and reviewing commits that appeared to happen at 4am does not do much
for my sanity!

Thanks all.

Tim

-- 
Tim Stoakes
