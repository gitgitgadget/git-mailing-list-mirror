From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git locate
Date: Wed, 20 Jan 2010 02:24:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001200224270.4985@pacific.mpi-cbg.de>
References: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 02:19:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXPED-00021n-2e
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 02:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab0ATBTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 20:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755790Ab0ATBTH
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 20:19:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:41338 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755055Ab0ATBTB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 20:19:01 -0500
Received: (qmail invoked by alias); 20 Jan 2010 01:18:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 20 Jan 2010 02:18:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+iSDFI/v+iyIkU5SipSTJ5S6TkuAgvTp+sJQrw2c
	ZC6My4JvNGlW+J
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137514>

Hi,

On Wed, 20 Jan 2010, John Tapsell wrote:

>   Could we add a:  git locate <filename>       or git find <filename>

How about "git ls-files \*<filename>"?

Ciao,
Dscho
