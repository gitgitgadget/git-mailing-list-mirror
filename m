From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] add support for per branch merge policy
Date: Thu, 20 Sep 2007 14:24:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709201424270.28395@racer.site>
References: <1190292789-16203-1-git-send-email-hjemli@gmail.com>
 <8c5c35580709200607s428e898ay32fd4cdad30f096e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 15:25:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYM2L-0005zn-0b
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 15:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbXITNZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 09:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753914AbXITNZd
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 09:25:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:59782 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754767AbXITNZc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 09:25:32 -0400
Received: (qmail invoked by alias); 20 Sep 2007 13:25:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 20 Sep 2007 15:25:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XjN0wsRLX5Am7oQTEXBZmVQsu2NzaeD32kCnAEQ
	FO7Y+GdI2FrR5U
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580709200607s428e898ay32fd4cdad30f096e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58778>

Hi,

On Thu, 20 Sep 2007, Lars Hjemli wrote:

> On 9/20/07, Lars Hjemli <hjemli@gmail.com> wrote:
> > branch.<name>.integrationonly
> 
> Btw: we might want to call this 'branch.<name>.mergepolicy' with the
> possible values 'synchronize' and 'integrate'.

IMHO this is way too limiting.

Ciao,
Dscho
