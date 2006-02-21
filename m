From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add new git-rm command with documentation
Date: Tue, 21 Feb 2006 23:15:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602212314090.12634@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87u0ass7tj.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 23:15:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBfmv-0004Sa-BZ
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 23:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWBUWPN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 17:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbWBUWPN
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 17:15:13 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:28387 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932562AbWBUWPL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 17:15:11 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D4315146A8A; Tue, 21 Feb 2006 23:15:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id C5B48A4B;
	Tue, 21 Feb 2006 23:15:08 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7C2C0146A8A; Tue, 21 Feb 2006 23:15:08 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87u0ass7tj.wl%cworth@cworth.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16560>

Hi,

On Tue, 21 Feb 2006, Carl Worth wrote:

>  PS. I didn't change the Linus and Junio attribution since all of the
>  code and documentation here is just minor changes from git-add.

If that is so, why not reuse the same binary (a la git-whatchanged and 
git-show)?

Ciao,
Dscho
