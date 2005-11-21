From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Rss produced by git is not valid xml?
Date: Mon, 21 Nov 2005 09:38:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511210937500.3931@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200511181833.40048.ismail@uludag.org.tr> <200511181926.10357.ismail@uludag.org.tr>
 <200511182127.06958.ismail@uludag.org.tr> <20051118200217.GA2831@vrfy.org>
 <Pine.LNX.4.63.0511190101590.28126@wbgn013.biozentrum.uni-wuerzburg.de>
 <4380C03B.9090603@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Ismail Donmez <ismail@uludag.org.tr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 09:40:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee7CG-00008V-2e
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 09:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVKUIil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 03:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVKUIil
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 03:38:41 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:28627 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932225AbVKUIik (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 03:38:40 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5761E1403D1; Mon, 21 Nov 2005 09:38:39 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 383D59F3A5; Mon, 21 Nov 2005 09:38:39 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 259BC9C78A; Mon, 21 Nov 2005 09:38:39 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ACE701403D1; Mon, 21 Nov 2005 09:38:38 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4380C03B.9090603@zytor.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12430>

Hi,

On Sun, 20 Nov 2005, H. Peter Anvin wrote:

> Johannes Schindelin wrote:
> > 
> > BTW, utf-8 was designed on purpose to be easily distinguishable from 
> > other encodings so that you don't have to rely on every document 
> > obeying a certain encoding.
> > 
> 
> No, it wasn't.  It was designated on purpose to be ASCII-compatible,
> substring-safe, and minimally stateful.

For the record, my information stems from

http://en.wikipedia.org/wiki/Utf-8#Rationale_behind_UTF-8.27s_mechanics

Hth,
Dscho
