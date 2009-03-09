From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or configured
Date: Mon, 9 Mar 2009 21:39:34 +0100
Message-ID: <200903092139.35788.markus.heidelberg@web.de>
References: <20090305221529.GA25871@pvv.org> <alpine.DEB.1.00.0903061126550.10279@pacific.mpi-cbg.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 09 21:41:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgmHX-0002AP-OD
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 21:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbZCIUjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 16:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbZCIUjP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 16:39:15 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:40015 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbZCIUjO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 16:39:14 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 37890F901B75;
	Mon,  9 Mar 2009 21:39:12 +0100 (CET)
Received: from [89.59.65.53] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LgmFM-0008BZ-00; Mon, 09 Mar 2009 21:38:48 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0903061126550.10279@pacific.mpi-cbg.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19fPSE/gI99A9Tffp93JEJGUbwdw0R6um2uMSjb
	xZTQ6B5h/2B/QJictHN7CTdZ0UztTtBwzpveSDJWOAPyScz+L4
	qL+j27s9IGZjtjy+anxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112738>

Johannes Schindelin, 06.03.2009:
> > -already exists on the remote side.  This is the default operation mode
> > +already exists on the remote side. Nothing will be pushed
> 
> The two spaces after the full stop were not actually a typo.

What's its purpose? Just recently I added "set nojoinspaces" to my
.vimrc to not insert two spaces when joining sentences.

Markus
