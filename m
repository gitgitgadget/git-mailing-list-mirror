From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Repository specific git commands
Date: Mon, 7 Jan 2008 13:55:54 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801071352470.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <8e04b5820801070415j5166c2eco53760cffe1ab1efb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ciprian Dorin Craciun <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 13:56:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBrWj-0001FH-Lz
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 13:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916AbYAGMz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 07:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756955AbYAGMz5
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 07:55:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:56374 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754887AbYAGMz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 07:55:56 -0500
Received: (qmail invoked by alias); 07 Jan 2008 12:55:54 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp039) with SMTP; 07 Jan 2008 13:55:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191/9xigdR1D97dnhSGWXz36/kZx/xevdKr2eE3dP
	Vk3uXCbx6mrCVK
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <8e04b5820801070415j5166c2eco53760cffe1ab1efb@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69788>

Hi,

On Mon, 7 Jan 2008, Ciprian Dorin Craciun wrote:

>     -- either define an alias -- but usually it is very restrictive in
> terms of what the alias can do;

You probably missed the possibility of executing a shell command (or 
commands) viathe  "!" prefix.

See also

	http://git.or.cz/gitwiki/Aliases/

Hth,
Dscho
