From: Steffen Prohaska <prohaska@zib.de>
Subject: msysgit: does git gui work?
Date: Thu, 9 Aug 2007 09:24:47 +0200
Message-ID: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 09:24:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ2NX-0003of-HH
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 09:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765693AbXHIHYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 03:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765561AbXHIHYI
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 03:24:08 -0400
Received: from mailer.zib.de ([130.73.108.11]:59038 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760963AbXHIHYG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 03:24:06 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l797O0oC011436;
	Thu, 9 Aug 2007 09:24:01 +0200 (CEST)
Received: from [192.168.178.32] ([77.177.247.82])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l797Nxve002350
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 9 Aug 2007 09:24:00 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55420>

Does 'git gui' work for you in msysgit?

I get

Invalid command name "git-version"
   while executing
"git-version >= 1.5.3"
    (in namespace eval "::blame" script line 36)
[...]

with msysgit (v1.5.3-rc2-690-g8ca1f6a).

	Steffen
