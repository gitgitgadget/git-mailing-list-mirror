From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/4] Teach git fetch to verify signed tags
 automatically
Date: Mon, 24 Nov 2008 11:41:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811241140280.30769@pacific.mpi-cbg.de>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Mon Nov 24 11:34:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4Ym7-0007LL-1S
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 11:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbYKXKdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 05:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbYKXKdX
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 05:33:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:48277 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752704AbYKXKdW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 05:33:22 -0500
Received: (qmail invoked by alias); 24 Nov 2008 10:33:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 24 Nov 2008 11:33:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qwfMJj/tqifYbGRzhJjfDmYBLK73QVxJrhqcNmd
	y8cbFqD5UmORVy
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1227497000-8684-1-git-send-email-deskinm@umich.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101596>

Hi,

On Sun, 23 Nov 2008, Deskin Miller wrote:

> -What to do if a tag is found to have a bad signature?

Or even worse: if the public key was not found?  In dubio pro reo, they 
say, but OTOH you asked to verify the signatures...

Ciao,
Dscho
