From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] git add: do not add files from a submodule
Date: Wed, 23 Jul 2008 20:10:09 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807232009310.8986@racer>
References: <1216534144-23826-1-git-send-email-gitster@pobox.com> <alpine.DEB.1.00.0807201529150.3305@eeepc-johanness> <alpine.DEB.1.00.0807210256510.3305@eeepc-johanness> <alpine.DEB.1.00.0807222230490.8986@racer> <7vhcahgl2j.fsf@gitster.siamese.dyndns.org>
 <20080723081333.GA15243@artemis.madism.org> <7v8wvse9l7.fsf@gitster.siamese.dyndns.org> <20080723190227.GF20614@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:11:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjjy-0001BI-1b
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbYGWTKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbYGWTKK
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:10:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:57036 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750799AbYGWTKI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:10:08 -0400
Received: (qmail invoked by alias); 23 Jul 2008 19:10:06 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp037) with SMTP; 23 Jul 2008 21:10:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rI2ICxWMr8/VfqnBIonNdkp/rl/YLc1KLqtW9SG
	UIsN9qjG2u5D9j
X-X-Sender: gene099@racer
In-Reply-To: <20080723190227.GF20614@artemis.madism.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89746>

Hi,

On Wed, 23 Jul 2008, Pierre Habouzit wrote:

> Though it'd be great to say e.g. that we won't do a 1.7.0 release[0] 
> until we have an UI for submodules we are prood of.

Or until we have everything ported over to parse_options?

Ciao,
Dscho
