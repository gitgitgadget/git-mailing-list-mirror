From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 0/5] submodule config lookup API
Date: Sat, 14 Jun 2014 00:41:57 +0200
Message-ID: <20140613224156.GA4345@sandbox-ub>
References: <20140605060425.GA23874@sandbox-ub>
 <xmqqy4x14wn8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 00:42:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvaAm-0001iT-9b
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 00:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbaFMWmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 18:42:07 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:46386 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbaFMWmG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 18:42:06 -0400
Received: from [77.21.74.130] (helo=sandbox-ub)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WvaAb-0008Jt-UX; Sat, 14 Jun 2014 00:42:02 +0200
Content-Disposition: inline
In-Reply-To: <xmqqy4x14wn8.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251649>

On Thu, Jun 12, 2014 at 02:59:23PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> >  t/t7410-submodule-config.sh                      | 141 ++++++++
> 
> We already use 7410 for something else in 'pu'; please avoid dups
> waiting to happen.

Sorry about that. Should I use 7411 even though that other series is
still work in progress?
