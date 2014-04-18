From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC/PATCH 2/4] Submodules: Add the lib-submodule-update.sh
 test library
Date: Fri, 18 Apr 2014 14:39:18 +0200
Message-ID: <20140418123918.GA4388@sandbox-ub>
References: <5331B6F6.60501@web.de>
 <5331B741.6000606@web.de>
 <20140417164138.GP21805@odin.tremily.us>
 <xmqq38hbep5v.fsf@gitster.dls.corp.google.com>
 <535047DC.2000809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	Johan Herland <johan@herland.net>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Ronald Weiss <weiss.ronald@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 18 14:39:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wb84x-0008PX-3V
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 14:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbaDRMj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 08:39:28 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:44030 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbaDRMj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 08:39:27 -0400
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Wb84h-0001h9-3y; Fri, 18 Apr 2014 14:39:23 +0200
Content-Disposition: inline
In-Reply-To: <535047DC.2000809@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246469>

On Thu, Apr 17, 2014 at 11:30:04PM +0200, Jens Lehmann wrote:
> - Heiko's "config cache for submodules" patch
> 
>   Needed for my recursive checkout series to populate new submodules.

Which will be followed by my recursive fetch series, which is also the
last part of what started with this:

http://thread.gmane.org/gmane.comp.version-control.git/217018

and is described here:

https://github.com/hvoigt/git/wiki/submodule-fetch-config

Cheers Heiko
