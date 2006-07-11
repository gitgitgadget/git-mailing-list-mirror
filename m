From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Install built-ins as symlinks
Date: Tue, 11 Jul 2006 16:16:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607111614550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11526131782190-git-send-email-alp@atoker.com>
 <11526131781900-git-send-email-alp@atoker.com> <1152613179634-git-send-email-alp@atoker.com>
 <11526131791902-git-send-email-alp@atoker.com> <11526131792773-git-send-email-alp@atoker.com>
 <11526131792377-git-send-email-alp@atoker.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 16:18:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0J3v-00013j-LK
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 16:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWGKORo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 10:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWGKORD
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 10:17:03 -0400
Received: from mail.gmx.de ([213.165.64.21]:48359 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750844AbWGKOQ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 10:16:58 -0400
Received: (qmail invoked by alias); 11 Jul 2006 14:16:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 11 Jul 2006 16:16:57 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alp Toker <alp@atoker.com>
In-Reply-To: <11526131792377-git-send-email-alp@atoker.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23711>

Hi,

On Tue, 11 Jul 2006, Alp Toker wrote:

> Doing this now will save headache in the long run, avoiding mismatched
> versions of installed utilities and dangling copies of removed or
> renamed git commands that still appear to work. It also makes screwups
> when packaging git or making system backups less likely.

Could we please fix things, which are broken? Not things which work?

Ciao,
Dscho
