From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 12:55:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602271255340.21502@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060225174047.0e9a6d29.akpm@osdl.org>  <7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
  <20060225210712.29b30f59.akpm@osdl.org>  <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
  <20060226103604.2d97696c.akpm@osdl.org>  <Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
  <20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer> 
 <Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
 <94fc236b0602270326s3079d737l102d5728d59f0c98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 12:56:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDgz8-0001Fe-9L
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 12:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWB0L4B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 06:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWB0L4B
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 06:56:01 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:2239 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751027AbWB0L4B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 06:56:01 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 050201C6F;
	Mon, 27 Feb 2006 12:56:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id EC8625EC4;
	Mon, 27 Feb 2006 12:55:59 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id CF6A199F;
	Mon, 27 Feb 2006 12:55:59 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Adrien Beau <adrienbeau@gmail.com>
In-Reply-To: <94fc236b0602270326s3079d737l102d5728d59f0c98@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16836>



On Mon, 27 Feb 2006, Adrien Beau wrote:

> A logical line that contains only spaces and tabs is ignored by
> Python. (All the "dirty" lines in git-merge-recursive.py are such
> lines.)
> 
> Hope this helps,

It does.

Thanks,
Dscho
