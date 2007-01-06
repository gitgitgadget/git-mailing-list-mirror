From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Sat, 6 Jan 2007 20:48:15 +0000
Message-ID: <200701062048.15163.alan@chandlerfamily.org.uk>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <87mz51gd7e.wl%cworth@cworth.org> <20070106185836.GH4655@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 06 21:48:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3ISi-0003ne-7Q
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 21:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbXAFUsR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 15:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbXAFUsR
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 15:48:17 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:36819
	"EHLO home.chandlerfamily.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932160AbXAFUsQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jan 2007 15:48:16 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1H3ISd-0007kv-Ga
	for git@vger.kernel.org; Sat, 06 Jan 2007 20:48:15 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <20070106185836.GH4655@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36100>

On Saturday 06 January 2007 18:58, J. Bruce Fields wrote:
> If we use the word "branches" for things that you can check out and
> commit to, then "remote-tracking branches" are not actually branches.
> Argh!
>
> What would be better terminology here?

Why can't we use the terms 'local branch' and 'remote branch'.  We can 
only commit to local branches - you need to push to remote ones.
-- 
Alan Chandler
http://www.chandlerfamily.org.uk
