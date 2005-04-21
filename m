From: Christian Meder <chris@absolutegiganten.org>
Subject: wit 0.0.4 uploaded
Date: Thu, 21 Apr 2005 05:05:29 +0200
Message-ID: <1114052729.4108.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 21 05:02:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DORxF-0001CJ-Kz
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 05:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVDUDGB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 23:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVDUDGB
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 23:06:01 -0400
Received: from shadow.prohost.de ([216.71.84.228]:43667 "EHLO
	shadow.prohost.de") by vger.kernel.org with ESMTP id S261198AbVDUDFm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 23:05:42 -0400
Received: from blue (p54A24C29.dip.t-dialin.net [84.162.76.41])
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j3L35XN29785
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 05:05:33 +0200
To: git@vger.kernel.org
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I uploaded a new snapshot to http://www.absolutegiganten.org/wit

The changes are

0.0.4:
* c2html usage is configurable now
* add flexible /changelog/<number of entries>, <number of days> and all
* improve display of dates
* implement all the nice ideas from Kay Sievers gitweb.pl
* try to validate most of the dynamic URIs
* sanitize logging and move host and port configuration to config.py
* add copyright headers to source files
* add a simple start script
* change default web serving mode of wit to multithreading

If I weren't so tired I'd write something cool and nifty for sure

The demo site is at

http://grmso.net:8090

Greetings,


			Christian

-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

