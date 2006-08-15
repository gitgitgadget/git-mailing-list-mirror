From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] use appropriate typedefs
Date: Tue, 15 Aug 2006 12:05:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608151204540.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608142305290.23445@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 12:06:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCvoM-0002oi-5S
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 12:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965354AbWHOKF7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 06:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965358AbWHOKF7
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 06:05:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:60836 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965356AbWHOKF6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 06:05:58 -0400
Received: (qmail invoked by alias); 15 Aug 2006 10:05:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp006) with SMTP; 15 Aug 2006 12:05:56 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: David Rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608142305290.23445@chino.corp.google.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25453>

Hi,

On Mon, 14 Aug 2006, David Rientjes wrote:

> Replaces int types with the appropriate definition in atomic and PID instances.

I was looking forward to the performance boosts you hinted at. But this 
patch, and the proposed static variables patch do nothing for it.

Ciao,
Dscho
