From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] correct documentation for git grep
Date: Mon, 26 Jun 2006 08:59:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606260858050.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx> <20060625184757.f8273820.tihirvon@gmail.com>
 <E1FuX8l-0001H5-2z@moooo.ath.cx> <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <E1FueCE-0003W3-4Q@moooo.ath.cx> <E1Fuecp-0004iI-RG@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 08:59:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ful4a-0001hX-Ln
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 08:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWFZG7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 02:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWFZG7t
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 02:59:49 -0400
Received: from mail.gmx.de ([213.165.64.21]:59075 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751196AbWFZG7t (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 02:59:49 -0400
Received: (qmail invoked by alias); 26 Jun 2006 06:59:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp016) with SMTP; 26 Jun 2006 08:59:47 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1Fuecp-0004iI-RG@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22656>

Hi,

On Mon, 26 Jun 2006, Matthias Lederhofer wrote:

> -	   [-f <file>] [-e <pattern>]
> +	   [-f <file>] [-e] <pattern> [-e <pattern> [..]]
>  	   [<tree>...]
>  	   [--] [<path>...]

Minor nit: as you can see from the two latter lines, "<bla>..." is the 
standard notation, whereas "<bla> [..]" is not.

Ciao,
Dscho
