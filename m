From: Michael Andreen <harv@ruin.nu>
Subject: Re: [PATCH] Make XDF_NEED_MINIMAL default in blame.
Date: Sun, 16 Mar 2014 13:32:16 +0100
Message-ID: <1688337.Jf0jlzSU63@river>
References: <154997837.FlSR2gFiUN@river> <8738iixrzi.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Thomas Rast <tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 13:32:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPAEo-0005uC-5b
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 13:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbaCPMcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 08:32:18 -0400
Received: from n.ruin.nu ([213.180.83.247]:42385 "EHLO n.ruin.nu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbaCPMcS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 08:32:18 -0400
Received: from river.localnet (h-40-196.a336.priv.bahnhof.se [79.136.40.196])
	by n.ruin.nu (Postfix) with ESMTPSA id 044BE1DC0078;
	Sun, 16 Mar 2014 13:32:15 +0100 (CET)
User-Agent: KMail/4.11.5 (Linux/3.12.13-gentoo; KDE/4.11.5; x86_64; ; )
In-Reply-To: <8738iixrzi.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244192>

On Sunday, March 16, 2014 01:12:01 PM Thomas Rast wrote:
> Michael Andreen <harv@ruin.nu> writes:
> 
> > The --minimal flag is still there, but didn't want to break scripts
> > depending on it.
> 
> If I specify --no-minimal, does that turn it off again?
> 

Yes, that works.

/Michael
