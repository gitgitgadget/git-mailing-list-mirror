From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of
 some adhocery
Date: Tue, 27 Jun 2006 00:57:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606270056440.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com>
 <7vr71bh6sv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 27 00:59:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv02O-0008IA-OV
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 00:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933315AbWFZW5q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 18:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933303AbWFZW5p
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 18:57:45 -0400
Received: from mail.gmx.net ([213.165.64.21]:52696 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933297AbWFZW5W (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 18:57:22 -0400
Received: (qmail invoked by alias); 26 Jun 2006 22:57:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 27 Jun 2006 00:57:21 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr71bh6sv.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22688>

Hi,

On Mon, 26 Jun 2006, Junio C Hamano wrote:

> I'll be pushing out a new test for format-patch shortly in
> "next".

Thanks. I had a little test, but it was not nearly as complete as I liked 
it...

Ciao,
Dscho
