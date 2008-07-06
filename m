From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [HACK] t/test-lib.sh HACK: Add -s/--show-hack to test suite.
Date: Sun, 6 Jul 2008 22:41:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807062241040.7342@eeepc-johanness>
References: <1215375751-30853-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jul 06 22:42:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFb45-0008QR-9j
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 22:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757139AbYGFUlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 16:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757145AbYGFUlf
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 16:41:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:58094 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757111AbYGFUlf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 16:41:35 -0400
Received: (qmail invoked by alias); 06 Jul 2008 20:41:33 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp034) with SMTP; 06 Jul 2008 22:41:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YMRAuwHdY8dx2RaVUmQgyMSqe2calu68D1h+8VC
	pvh3Ig9PnOhEp/
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1215375751-30853-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87553>

Hi,

On Sun, 6 Jul 2008, Stephan Beyer wrote:

> This option realizes a stupid hack that tries to run the test
> cases line by line (separated by &&).

In what way is that better than "sh -x t????-*.sh"?

Ciao,
Dscho
