From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Add Long Usage instead of simple usage
Date: Sat, 3 May 2008 15:12:34 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805031511171.30431@racer>
References: <1209822813-12237-1-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Sat May 03 16:13:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsIUP-0002yf-MP
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 16:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbYECOMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 10:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752723AbYECOMi
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 10:12:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:57701 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752595AbYECOMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 10:12:37 -0400
Received: (qmail invoked by alias); 03 May 2008 14:12:35 -0000
Received: from dslb-088-067-214-063.pools.arcor-ip.net (EHLO dslb-088-067-214-063.pools.arcor-ip.net) [88.67.214.63]
  by mail.gmx.net (mp009) with SMTP; 03 May 2008 16:12:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX197gLAUDkt7GEW4S0g2LP/Cenrd5gTd7TprhOBhHj
	7GT6StYRJZA18n
X-X-Sender: gene099@racer
In-Reply-To: <1209822813-12237-1-git-send-email-imyousuf@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81091>

Hi,

On Sat, 3 May 2008, imyousuf@gmail.com wrote:

> From: Imran M Yousuf <imyousuf@smartitengineering.com>
> 
> With the already available commands the synopsis is quite hard to
> read; thus converted it to Long usage instead. In process also
> updated the file comment.
> 
> Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
> ---
>  git-submodule.sh |   13 +++++++++----

Please keep in mind that the diffstat will not be part of the default log.  
Would you be able to understand from your commit message in, say, 6 months 
from now that the commit is actually about git-submodule?  Me neither.

Ciao,
Dscho
