From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Change from using email.com to example.com as example
	domain, as per RFC 2606.
Date: Fri, 7 Dec 2007 08:01:35 +0100
Organization: glandium.org
Message-ID: <20071207070135.GA29333@glandium.org>
References: <11969842052283-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 08:02:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0XDq-000443-17
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 08:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbXLGHBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 02:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbXLGHBl
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 02:01:41 -0500
Received: from smtp19.orange.fr ([80.12.242.17]:20556 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbXLGHBk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 02:01:40 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1914.orange.fr (SMTP Server) with ESMTP id A5F321C00094
	for <git@vger.kernel.org>; Fri,  7 Dec 2007 08:01:38 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf1914.orange.fr (SMTP Server) with ESMTP id 834EB1C0008E;
	Fri,  7 Dec 2007 08:01:38 +0100 (CET)
X-ME-UUID: 20071207070138537.834EB1C0008E@mwinf1914.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J0XDL-0007am-KL; Fri, 07 Dec 2007 08:01:36 +0100
Content-Disposition: inline
In-Reply-To: <11969842052283-git-send-email-dsymonds@gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67387>

On Fri, Dec 07, 2007 at 10:36:45AM +1100, David Symonds wrote:
> -	  "Signed-off-by: Your Name <your@email.com>" line to the
> +	  "Signed-off-by: Your Name <your@example.com>" line to the

you@example.com would be better IMHO.

Mike
