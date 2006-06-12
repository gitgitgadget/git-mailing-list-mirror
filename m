From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitweb: Adding a `blame' interface.
Date: Mon, 12 Jun 2006 11:08:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606121107520.21813@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11500407193506-git-send-email-octo@verplant.org>
 <46a038f90606111502g607be3cfnf83ce81764a5f909@mail.gmail.com>
 <20060612082448.GA11857@verplant.org> <46a038f90606120134n21c269bbj3e8c7e31d4d93a23@mail.gmail.com>
 <20060612084056.GA29220@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Florian Forster <octo@verplant.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 11:09:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpiPn-0000fL-05
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 11:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWFLJIv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 05:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWFLJIs
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 05:08:48 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:37270 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750935AbWFLJIr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 05:08:47 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 9BA9E2AB7;
	Mon, 12 Jun 2006 11:08:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 8F1202368;
	Mon, 12 Jun 2006 11:08:46 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 6AFA61D84;
	Mon, 12 Jun 2006 11:08:46 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060612084056.GA29220@spearce.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21698>

Hi,

On Mon, 12 Jun 2006, Shawn Pearce wrote:

>   [gitweb]
>     description=<div class=\"description\">\n\
> This is a chunk of text which describes this repository.  Some\n\
> of this text might be rather long, and might need many lines to\n\
> really be able to describe the repository in a nice editor such as\n\
> vi running in an 80 character wide xterm.\n\
> </div>

AFAIK the trailing "\" will not work.

Ciao,
Dscho
