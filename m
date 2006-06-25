From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] correct documentation for git grep
Date: Mon, 26 Jun 2006 01:10:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx> <20060625184757.f8273820.tihirvon@gmail.com>
 <E1FuX8l-0001H5-2z@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 01:10:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FudkW-0000Zg-6u
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 01:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWFYXKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 19:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWFYXKf
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 19:10:35 -0400
Received: from mail.gmx.net ([213.165.64.21]:38844 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932414AbWFYXKf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 19:10:35 -0400
Received: (qmail invoked by alias); 25 Jun 2006 23:10:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp006) with SMTP; 26 Jun 2006 01:10:33 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FuX8l-0001H5-2z@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22646>

Hi,

On Sun, 25 Jun 2006, Matthias Lederhofer wrote:

> +-e::
> +	The next parameter is the pattern. This option has to be
> +	used for patterns starting with - and should be used in
> +	scripts passing user input to grep.

... and by the far the most common use is to pass more than one pattern. 
Also, the usage is "[-e] <pattern> [-e <pattern>...]".

Ciao,
Dscho
