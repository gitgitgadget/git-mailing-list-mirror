From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add tests for diff.color-words configuration option.
Date: Tue, 20 Jan 2009 10:58:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201057080.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <adf1fd3d0901191447n7fc39dect9cf5afd88a02015b@mail.gmail.com> <alpine.DEB.1.00.0901200031350.3586@pacific.mpi-cbg.de> <200901192017.54163.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 11:00:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPDPK-0000vt-FP
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 11:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759564AbZATJ6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 04:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754919AbZATJ6f
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 04:58:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:36989 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754985AbZATJ6e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 04:58:34 -0500
Received: (qmail invoked by alias); 20 Jan 2009 09:58:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 20 Jan 2009 10:58:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18LWLRZx1oLPCK+6Jk3wsfZpXJ/urkl/rGUNu60rf
	3X6ivFyKXKEwhg
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901192017.54163.bss@iguanasuicide.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106460>

Hi,

On Mon, 19 Jan 2009, Boyd Stephen Smith Jr. wrote:

> I'm not sure why the diff is crazy long.

Because you changed things that need no changing, such as "cat > expect" 
-> "cat > expect.blabla", and because you inserted your test instead of 
adding it at the end.

Ciao,
Dscho
