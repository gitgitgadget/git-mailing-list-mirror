From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: git-rev-list  in local commit order
Date: Mon, 16 May 2005 00:13:55 +0200
Organization: linutronix
Message-ID: <1116195235.11872.213.camel@tglx>
References: <4127.10.10.10.24.1116107046.squirrel@linux1>
	 <1116186533.11872.152.camel@tglx>
	 <4971.10.10.10.24.1116187076.squirrel@linux1>
	 <1116189873.11872.171.camel@tglx>
	 <1102.10.10.10.24.1116189916.squirrel@linux1>
	 <1116191636.11872.195.camel@tglx>
	 <1273.10.10.10.24.1116192097.squirrel@linux1>
	 <1116192629.11872.201.camel@tglx>
	 <1392.10.10.10.24.1116193437.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 00:13:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXRLi-0006SK-MY
	for gcvg-git@gmane.org; Mon, 16 May 2005 00:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVEOWMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 18:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVEOWMx
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 18:12:53 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:8099
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261266AbVEOWMv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 18:12:51 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id B928465C003;
	Mon, 16 May 2005 00:12:32 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 465BB282BF;
	Mon, 16 May 2005 00:12:46 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <1392.10.10.10.24.1116193437.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-05-15 at 17:43 -0400, Sean wrote:

> Well I honestly don't know what you want.   If I wanted to include a
> "fortune" line in every commit and couldn't explain what value it
> provided, i'd expect you or others to object.

Last try.

A repository Id makes it possible to identify workflows in and across
repositories. 

This information is valuable for me and others due to already discussed
reasons. 

I accept that is irrelevant for you.

tglx


