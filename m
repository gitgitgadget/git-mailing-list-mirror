From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fetching a tree from a remote server
Date: Thu, 4 May 2006 02:48:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605040247460.24675@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0605032026070.6713@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 02:48:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbS0o-0003gj-BM
	for gcvg-git@gmane.org; Thu, 04 May 2006 02:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWEDAsH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 20:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWEDAsH
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 20:48:07 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:52702 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750831AbWEDAsG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 20:48:06 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 153551BB8;
	Thu,  4 May 2006 02:48:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 09A911B2E;
	Thu,  4 May 2006 02:48:05 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id D4F3417F8;
	Thu,  4 May 2006 02:48:04 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0605032026070.6713@iabervon.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19541>

Hi,

On Wed, 3 May 2006, Daniel Barkalow wrote:

> Is there something to do the opposite of git clone -n? That is, I want to 
> fill a directory with a treeish ref, and I don't care about any history or 
> bookkeeping.

Is git-tar-tree your friend or what?

Ciao,
Dscho
