From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: use binmode(STDOUT) in git-status
Date: Tue, 29 Nov 2005 12:44:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511291243090.2028@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0511272334w393434e7lad3e3b102e6c3e9e@mail.gmail.com>
 <7vd5kkvd3q.fsf@assigned-by-dhcp.cox.net> <20051129100550.GA2124@ELSAMSW37164>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 13:44:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh3vJ-00033K-8O
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 12:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVK2Loh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 06:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVK2Loh
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 06:44:37 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47234 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751316AbVK2Log (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 06:44:36 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CB4FD13F964; Tue, 29 Nov 2005 12:44:35 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A8997B5370; Tue, 29 Nov 2005 12:44:35 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8AAC2B5365; Tue, 29 Nov 2005 12:44:35 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 04A0E13F95F; Tue, 29 Nov 2005 12:44:35 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Tim O'Callaghan <timo@dspsrv.com>
In-Reply-To: <20051129100550.GA2124@ELSAMSW37164>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12936>

Hi,

On Tue, 29 Nov 2005, Tim O'Callaghan wrote:

> [...] native windows support is going to be a bit tricky without Cygwin 
> as you also need (ba)sh, sed, grep, etc.

... most notably, not to forget fork().

Hth,
Dscho
