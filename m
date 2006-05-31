From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t9001 fails because Net::SMTP is missing
Date: Wed, 31 May 2006 10:32:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605311031090.14859@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0605302125310.11586@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xojyqu3.fsf@assigned-by-dhcp.cox.net> <7v4pz7yqpd.fsf@assigned-by-dhcp.cox.net>
 <20060531060530.GA9333@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 10:33:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlM8V-0005PU-Uv
	for gcvg-git@gmane.org; Wed, 31 May 2006 10:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWEaIcr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 04:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWEaIcr
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 04:32:47 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40099 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964865AbWEaIcq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 04:32:46 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id AB2DCE01;
	Wed, 31 May 2006 10:32:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9A68FE20;
	Wed, 31 May 2006 10:32:45 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 6B6B7DE7;
	Wed, 31 May 2006 10:32:45 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060531060530.GA9333@hand.yhbt.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21060>

Hi,

On Tue, 30 May 2006, Eric Wong wrote:

> Odd that Net::SMTP isn't installed on Johannes' machine, though, as it's
> part of the standard Perl 5.8 (maybe even before) installation.

In terms of corporate setups, 5.8 really is pretty new, you know?

As for "s/use/require/", I can not access on that machine today, but I 
will test it.

Ciao,
Dscho
