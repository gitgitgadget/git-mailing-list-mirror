From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: master has some toys
Date: Fri, 18 Nov 2005 00:36:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511180036200.18775@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
 <b0943d9e0511160311k725526d8v@mail.gmail.com> <7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
 <7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
 <81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
 <Pine.LNX.4.63.0511171207580.20898@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vsltvwmlr.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511171249550.737@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vveyrt6ms.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 00:39:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EctJN-0001U9-1Z
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 00:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVKQXgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 18:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVKQXgy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 18:36:54 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:37593 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932297AbVKQXgy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 18:36:54 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2958013FD8C; Fri, 18 Nov 2005 00:36:53 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0715CB5236; Fri, 18 Nov 2005 00:36:53 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BB2B6B5233; Fri, 18 Nov 2005 00:36:52 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A070913FD8C; Fri, 18 Nov 2005 00:36:52 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vveyrt6ms.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12177>

Hi,

On Thu, 17 Nov 2005, Junio C Hamano wrote:

> +	# There are conflicting reports about this.
> +	# On some boxes NO_MMAP is needed, and not so elsewhere.
> +	# Try uncommenting this if you see things break -- YMMV.
> +	# NO_MMAP = YesPlease

Sounds sensible. Maybe you want to output that to stderr or stdout?

Ciao,
Dscho
