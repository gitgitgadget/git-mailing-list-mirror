From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rev-list: fix --header
Date: Tue, 18 Apr 2006 16:50:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604181649510.2140@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604171443300.18017@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwtdom1t9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0604172222390.19593@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhd4rlw0m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 16:50:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVrXE-0002Ld-EA
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 16:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWDROu3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 10:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWDROu3
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 10:50:29 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:62860 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932229AbWDROu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 10:50:28 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id DA01A1F41;
	Tue, 18 Apr 2006 16:50:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id CE7F01F39;
	Tue, 18 Apr 2006 16:50:22 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id B36541C77;
	Tue, 18 Apr 2006 16:50:22 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd4rlw0m.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18856>

Hi,

On Mon, 17 Apr 2006, Junio C Hamano wrote:

> Still undecided.  As you say it is an easy change, so I'd rather
> leave the behaviour as before for now.

Okay, I'd say go with the shorter (your) solution.

Ciao,
Dscho
