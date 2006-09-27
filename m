From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] perl bindings fix compilation errors
Date: Wed, 27 Sep 2006 11:42:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609271141210.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060925100319.GA1655@shadowen.org>
 <Pine.LNX.4.63.0609251223590.25371@wbgn013.biozentrum.uni-wuerzburg.de>
 <4517BEBC.4000002@shadowen.org> <7vfyeftehf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0609261031430.25371@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwt7qjal5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 11:42:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSVvg-0004YY-Hv
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 11:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965481AbWI0JmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 05:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965482AbWI0JmJ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 05:42:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:29345 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965481AbWI0JmG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 05:42:06 -0400
Received: (qmail invoked by alias); 27 Sep 2006 09:42:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp008) with SMTP; 27 Sep 2006 11:42:05 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt7qjal5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27894>

Hi,

On Tue, 26 Sep 2006, Junio C Hamano wrote:

> The worst part is that the version bisect suggests that does not
> have Git.xs may be a version in the past -- which we obviously
> cannot apply your patch to.

Okay, just forget about my patch.

Ciao,
Dscho
