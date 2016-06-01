From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Wed, 1 Jun 2016 12:19:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606011217230.5761@virtualbox>
References: <20160531220818.GB46739@zoidberg> <xmqqtwhd3lht.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606010919360.5761@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 12:19:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b83FZ-0001jS-0A
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 12:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbcFAKTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 06:19:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:61554 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbcFAKTf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 06:19:35 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M6ioC-1bSrLH2HyO-00wVCe; Wed, 01 Jun 2016 12:19:11
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <alpine.DEB.2.20.1606010919360.5761@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:SDKns2D/UsDbUxtPry1HatouvGS8Uz4EnR3WJ68wL6cVXAKktXE
 6DZJjMLZJMewamF0mffDDGn+1s+59a5Ed0XyYRD2t4B/Ff8RjJWin6w2ROveKbN2rJx4cQY
 c5+iBEfHrE6aC+jyStHAXmaGGXxALM3BLxGYtExEQty6FuqsneaR2WsjOeGkKqwAY9u/95g
 r1Ofa6a+50OYCw4eXp6xg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YN1drfF/6As=:OLtuwCnSFenhMcZUkZqlme
 lCDtCcolvuRwzkIdTolJjUshSjRWqb/LKJgfdMVcrRznFnRokQIvdO9k0atl9Tt+/Eq+vEa7u
 YqZH3/uhyhoS5KG6PmlL3wfWAfuIJuh9qxV1YK/uyOOqdcOib0G7+ImFp+NAgC0uW2t4sRpE9
 1y8atfna3FtDCjOYVX9Z8U4P0dNLNFWkSFuBhdd5yf/i1KfkvQ074McytYJHo6n0fnkJWLS8Y
 vRxWbUPQ+tuKoHDjuazpAsm5P69XJtE4k7itX5XxTKMXJt480B+l61yFUv5J6G4nlbYVtDU9m
 0YPwF34bcIkgBJH4nnSUXmIufi4tNeThsrnJ2FANa7gO/5atzQ8VNP1QMl+4RRNV2rmkOeKwb
 B0xgIW2siPoOEfgJP5MgFHNZ6DhROD7Pddey/i4QbQpU5cAtlFVvelYptryC6DSi9SsY8K7iA
 6/1FUBZVPgU4D53fsmNNVR+ZY42DtnejlCaCf2BFm4d9PpINHXMZ6fD11AO3jOKAOymOPxzWF
 tcDGKhJCz04zWm3mUTAr6B0eivb4G5rZawYcsDNDLJAICA/9BOHQ5zcB1WLae27X8Vtd6PWPt
 V9xkZNJMRxmku3YWGmLMyY78cI2jYo9dkw7BaB9HO8UH2loB/ZOw2LAsQrxZc2hU03w4hK3ED
 tXMEAqoEJruQ2+SmZ0Yr8Ye/tKt/Fr1jpwrZFSjbhsDwvydOWscVSykM1o8naqhmNSA/r33w7
 rgPxMNozmmFn+6Smsn7SxEarxMD14PWQWalu0C0COKVfWFpKFmv318r38byUMTTnLpcskNo4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296074>

On Wed, 1 Jun 2016, Johannes Schindelin wrote:

> And here is an add-on patch (Ed, feel free to squash) that avoids those
> two bits, and even saves one line overall:
> 
> [...]

And here is a link for developers who prefer to work with Git directly
(as opposed to working with Git through a mailbox):

	https://github.com/git/git/compare/dscho:force-chmod
