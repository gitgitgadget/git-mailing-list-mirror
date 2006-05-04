From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Alphabetize the glossary.
Date: Thu, 4 May 2006 12:41:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605041238240.26488@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1FbVFi-0004Tt-Aw@jdl.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 12:41:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbbGz-00084G-DY
	for gcvg-git@gmane.org; Thu, 04 May 2006 12:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWEDKlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 06:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWEDKlX
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 06:41:23 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:54972 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751487AbWEDKlW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 06:41:22 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id B48D4D75;
	Thu,  4 May 2006 12:41:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id A88C4D53;
	Thu,  4 May 2006 12:41:21 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 7EEE2CC3;
	Thu,  4 May 2006 12:41:19 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1FbVFi-0004Tt-Aw@jdl.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19564>

Hi,

On Wed, 3 May 2006, Jon Loeliger wrote:

> Yeah, there is a script that also alphabetize the glossary.
> But let's just be explicit and complete here.

The idea of having it not alphabetized, but doing it by a script, was to 
let people actually _read_ it. There is nothing more annoying than having 
to jump forward and backward and eventually be lost.

glossary, as I started it, was topologically ordered: no Git term was used 
before it was described (at least that was the plan).

Ciao,
Dscho
