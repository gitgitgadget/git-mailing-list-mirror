From: Marcin Owsiany <marcin@owsiany.pl>
Subject: Re: git-svn stubbornly re-creating branch "master"
Date: Fri, 3 Apr 2009 13:26:31 +0100
Message-ID: <20090403122631.GA23635@beczulka>
References: <20090329171347.GA26866@beczulka> <20090329222827.GA32199@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 14:28:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpiVL-0006Sf-Vl
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 14:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762185AbZDCM0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 08:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759127AbZDCM0l
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 08:26:41 -0400
Received: from mail0.vicoop.com ([85.17.210.107]:59598 "EHLO mail.vicoop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757918AbZDCM0k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 08:26:40 -0400
Received: from localhost (213-155-151-233.customer.teliacarrier.com [213.155.151.233])
	(Authenticated sender: porridge@sl.owsiany.pl)
	by mail.vicoop.com (Postfix) with ESMTP id 761621E8EE;
	Fri,  3 Apr 2009 14:26:34 +0200 (CEST)
Received: from mowsiany by localhost with local (Exim 4.67)
	(envelope-from <marcin@owsiany.pl>)
	id 1LpiTg-0006AE-08; Fri, 03 Apr 2009 13:26:32 +0100
Content-Disposition: inline
In-Reply-To: <20090329222827.GA32199@dcvr.yhbt.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115527>

On Sun, Mar 29, 2009 at 03:28:27PM -0700, Eric Wong wrote:
> Why not just use "master" as one of your branches?  It won't bite you.

It's because I have two main branches in my repository, and none of them
is really more important ATM. I prefer to use different names.

-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 1024D/60F41216  FE67 DA2D 0ACA FC5E 3F75  D6F6 3A0D 8AA0 60F4 1216
 
"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
