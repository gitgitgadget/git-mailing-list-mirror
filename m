From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git User's Survey 2007 partial summary
Date: Mon, 27 Aug 2007 12:42:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708271240050.28586@racer.site>
References: <200708190128.43515.jnareb@gmail.com> <200708270251.05762.jnareb@gmail.com>
 <20070827014034.GD18160@spearce.org> <200708271315.07919.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 13:40:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPcxA-000216-14
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 13:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575AbXH0LkP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 07:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755571AbXH0LkO
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 07:40:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:47486 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755575AbXH0LkM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 07:40:12 -0400
Received: (qmail invoked by alias); 27 Aug 2007 11:40:11 -0000
Received: from ppp-82-135-74-69.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.74.69]
  by mail.gmx.net (mp018) with SMTP; 27 Aug 2007 13:40:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jfig79iZj3sIOX2wjS/I11FfwH+XgRI6e9yZD/8
	jwGWcoA1Wtvgto
X-X-Sender: gene099@racer.site
In-Reply-To: <200708271315.07919.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56820>

Hi,

On Mon, 27 Aug 2007, Jakub Narebski wrote:

> I wonder if PyGTK is as portable as Tcl/Tk...

It is not.  I ended my attempts with contempt after two weeks to compile 
_Python_ on MinGW.  I came to the conclusion that the developers of Python 
do not care about being able to compile Python on Windows with Open Source 
tools only.

Of course, that means that you cannot compile Python modules with MinGW 
(at least as far as I know).

Ciao,
Dscho
