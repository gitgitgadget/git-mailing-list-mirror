From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH-maint] test-lib.sh: Help test_create_repo() find the
 templates dir
Date: Tue, 21 Apr 2009 11:26:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904211126180.10279@pacific.mpi-cbg.de>
References: <7vocuqbmgu.fsf@gitster.siamese.dyndns.org> <1240305543-27163-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 11:29:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwCFX-0005Uo-OZ
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 11:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbZDUJZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 05:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754541AbZDUJZG
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 05:25:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:58295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752339AbZDUJZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 05:25:05 -0400
Received: (qmail invoked by alias); 21 Apr 2009 09:25:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 21 Apr 2009 11:25:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18e65JC2iQep9q4HDIKTbVvToYk1xk7EUrybSiggG
	IKEptzWVZPhOT8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1240305543-27163-1-git-send-email-git@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117116>

Hi,

On Tue, 21 Apr 2009, Michael J Gruber wrote:

> This is a patch against maint as discussed in 
> http://article.gmane.org/gmane.comp.version-control.git/11699 although 
> maint does not (yet) contain a6d63b7 which actually exposes the problem.

So it is a fix in need of a problem?

Ciao,
Dscho
