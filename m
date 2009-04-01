From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] Add configuration variable for sign-off to format-patch
Date: Wed, 1 Apr 2009 19:53:55 +0200
Message-ID: <20090401175355.GB90421@macbook.lan>
References: <20090331185018.GD72569@macbook.lan> <49D27359.1040703@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Apr 01 19:55:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp4fF-0001ZO-43
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 19:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765862AbZDARyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 13:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764933AbZDARx7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 13:53:59 -0400
Received: from darksea.de ([83.133.111.250]:59810 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755612AbZDARx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 13:53:58 -0400
Received: (qmail 16627 invoked from network); 1 Apr 2009 19:53:44 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 1 Apr 2009 19:53:44 +0200
Content-Disposition: inline
In-Reply-To: <49D27359.1040703@op5.se>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115405>

On Tue, Mar 31, 2009 at 09:47:37PM +0200, Andreas Ericsson wrote:
> Can we please make it "formatpatch.signoff" or some such instead? Just
> plain "format" is a bit too generic for my taste.

But all options for format-patch are already beginning with format. So
probably leave it like this for consistency reasons.

cheers Heiko
