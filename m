From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] git-daemon wrapper to wait until daemon is ready
Date: Sat, 14 Apr 2012 14:43:41 -0400
Message-ID: <1334428952-sup-5241@pinkfloyd.chass.utoronto.ca>
References: <20120414182907.GA3915@ecki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git <git@vger.kernel.org>, gitster <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Apr 14 20:44:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ7x3-0005QQ-12
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 20:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872Ab2DNSnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 14:43:47 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:40618 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853Ab2DNSnp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 14:43:45 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:32981 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SJ7wj-0001tG-JN; Sat, 14 Apr 2012 14:43:41 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SJ7wj-0004Ca-ID; Sat, 14 Apr 2012 14:43:41 -0400
In-reply-to: <20120414182907.GA3915@ecki>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195503>

Excerpts from Clemens Buchacher's message of Sat Apr 14 14:29:07 -0400 2012:

Hi Clemens,

> The shell script which is currently used to parse git daemon output does
> not seem to work unreliably. In order to work around such issues,

Presumably you mean "work reliably" here?

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
