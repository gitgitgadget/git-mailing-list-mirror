From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Windows port, was Re: Projects using git now
Date: Thu, 27 Jul 2006 19:18:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271916000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <b8bf37780607270951h24d899b8yfa22a1fcb2bde5db@mail.gmail.com>
 <eaas2o$bj8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 27 19:18:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G69Vd-0003I3-7B
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbWG0RSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 13:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWG0RSu
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:18:50 -0400
Received: from mail.gmx.de ([213.165.64.21]:28123 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751759AbWG0RSt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 13:18:49 -0400
Received: (qmail invoked by alias); 27 Jul 2006 17:18:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 27 Jul 2006 19:18:48 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eaas2o$bj8$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24316>

Hi,

On Thu, 27 Jul 2006, Jakub Narebski wrote:

> I guess that the worst obstacles in wider adoption of git is lack of
> intrinsic subproject support (for modular projects, and perhas for
> distributions), and lack of native MS Windows port.

I started playing around with a MinGW32 port, and it already was able to 
show a git-log. All the network things, and all the exec things are 
non-working.

If anybody wants to play with it, I'll send a patch against 
tags/v1.4.1-rc1~37.

Ciao,
Dscho
