From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
 family
Date: Mon, 5 Oct 2009 22:39:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910052239350.4985@pacific.mpi-cbg.de>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de> <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de>
 <4AC9D6EB.8090002@web.de> <4ACA2DBB.5030908@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:41:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuuNB-0005z5-Co
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 22:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbZJEUiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 16:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753980AbZJEUiR
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 16:38:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:41211 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753614AbZJEUiR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 16:38:17 -0400
Received: (qmail invoked by alias); 05 Oct 2009 20:37:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp064) with SMTP; 05 Oct 2009 22:37:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ccuBTPLfcGr9RQvD+9yD0LUAobrMgR9ZdWtk6GG
	GexaEbIWh3G9g7
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4ACA2DBB.5030908@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129585>

Hi,

On Mon, 5 Oct 2009, Jens Lehmann wrote:

> A bug showed up in the tests, deleted submodules were labelled
> "(not checked out)" instead of "(submodule deleted)". This patch
> fixes that.

Good catch, thanks!

Ciao,
Dscho
