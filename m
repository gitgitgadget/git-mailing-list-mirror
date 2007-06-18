From: Carlo Wood <carlo@alinoe.com>
Subject: Re: GIT Packages for Debian Etch
Date: Mon, 18 Jun 2007 23:48:52 +0200
Message-ID: <20070618214852.GA13538@alinoe.com>
References: <20070618212524.GC16393@cip.informatik.uni-erlangen.de> <20070618212741.GA5938@artemis.internal.dc7.debconf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Thomas Glanzmann <thomas@glanzmann.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 18 23:49:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0P5r-0003Bk-Cg
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 23:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbXFRVs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 17:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763358AbXFRVs5
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 17:48:57 -0400
Received: from viefep18-int.chello.at ([213.46.255.22]:26079 "EHLO
	viefep33-int.chello.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932642AbXFRVsz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 17:48:55 -0400
Received: from mail9.alinoe.com ([62.163.36.229]) by viefep33-int.chello.at
          (InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
          id <20070618214852.EMEK7884.viefep33-int.chello.at@mail9.alinoe.com>;
          Mon, 18 Jun 2007 23:48:52 +0200
Received: from carlo by mail9.alinoe.com with local (Exim 4.67)
	(envelope-from <carlo@alinoe.com>)
	id 1I0P5g-0004oq-VV; Mon, 18 Jun 2007 23:48:53 +0200
Mail-Followup-To: Carlo Wood <carlo@alinoe.com>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070618212741.GA5938@artemis.internal.dc7.debconf.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50418>

On Mon, Jun 18, 2007 at 10:27:41PM +0100, Pierre Habouzit wrote:
>   FWIW there is even simpler: I maintain a backport on
> www.backports.org. Which is a semi-official service driven by Debian
> Developers.

It seems that this is only for etch (and sarge).
I run a mixed Lenny/sid machine here. It doesn't necessarily
work when I start to install things for etch. Certainly not
once testing upgrades its libc. Or?

-- 
Carlo Wood <carlo@alinoe.com>
