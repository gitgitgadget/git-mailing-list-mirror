From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: Feature Request: Capability to save and load the workspace
Date: Fri, 31 Jul 2009 12:14:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907311213300.4503@intel-tinevez-2-302>
References: <4A72AF1C.1020500@ubicom.com> <40aa078e0907310209p458cf912r1eb4329a409cefa7@mail.gmail.com> <CB2DD11991B27C4F99935E6229450D3204837B8F@STORK.scenix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org
To: Yakup Akbay <yakbay@ubicom.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 12:14:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWp7x-0006N3-VR
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 12:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbZGaKOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 06:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbZGaKOI
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 06:14:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:35787 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752025AbZGaKOI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 06:14:08 -0400
Received: (qmail invoked by alias); 31 Jul 2009 10:14:06 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp002) with SMTP; 31 Jul 2009 12:14:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BnU0qJXdBPSL0zjmEWLLM2pv9VXla9eupd56Mhc
	m6jRIZI98EFF4G
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <CB2DD11991B27C4F99935E6229450D3204837B8F@STORK.scenix.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124537>

Hi,

On Fri, 31 Jul 2009, Yakup Akbay wrote:

> AFAIK, git-stash does not save untracked and ignored files. What I need 
> is to save them, too.

So...  "git add . && git stash"  You can even make an alias.

Ciao,
Dscho
