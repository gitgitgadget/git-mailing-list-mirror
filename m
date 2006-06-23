From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] git-merge --squash
Date: Fri, 23 Jun 2006 14:42:59 +0200
Message-ID: <20060623124259.GF15631@cip.informatik.uni-erlangen.de>
References: <7virmscl2u.fsf@assigned-by-dhcp.cox.net> <7vd5d09pe2.fsf@assigned-by-dhcp.cox.net> <20060623122501.GD15631@cip.informatik.uni-erlangen.de> <Pine.LNX.4.63.0606231433370.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 14:43:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftl0D-0001sm-PU
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 14:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWFWMnD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 08:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWFWMnD
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 08:43:03 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:40951 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S964782AbWFWMnA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 08:43:00 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 79EFF305E3; Fri, 23 Jun 2006 14:42:59 +0200 (CEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606231433370.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11-2006-06-13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22417>

Hello,

> Isn't this the same as 'git-cherry-pick -n'? I often do a poor man's StGIT 
> by cherry picking my way through a messy branch, often combining patches 
> by '-n'.

yes it is. I didn't know about the cherry-pick -n option. Thanks.

        Thomas
