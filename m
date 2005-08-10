From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Sanity check of git-commit patch, was Re: [PATCH] Making CFLAGS
 compilant with GNU Coding Standards
Date: Wed, 10 Aug 2005 14:52:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508101451200.19746@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <200508100220.j7A2KNWb005040@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Pavel Roskin <proski@gnu.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 14:53:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2q4P-0005oL-Md
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 14:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbVHJMwb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 08:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbVHJMwb
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 08:52:31 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:64896 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965081AbVHJMwa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 08:52:30 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BA550E3356; Wed, 10 Aug 2005 14:52:27 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 29F9C99561; Wed, 10 Aug 2005 14:52:26 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C8A829948A; Wed, 10 Aug 2005 14:52:25 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 04AB1E3356; Wed, 10 Aug 2005 14:52:25 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200508100220.j7A2KNWb005040@laptop11.inf.utfsm.cl>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 9 Aug 2005, Horst von Brand wrote:

> Isn't it easier to just use getopt(1)?

Only if GNU getopt is available. On Mac OS X, only the BSD version is 
installed by default, which does not handle long options at all.

> Please stop! I'm dizzy already!

:-)

Ciao,
Dscho
