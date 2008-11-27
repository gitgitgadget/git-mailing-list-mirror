From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git cat-file blob does not convert crlf
Date: Thu, 27 Nov 2008 02:41:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811270241060.30769@pacific.mpi-cbg.de>
References: <20081127013456.6117@qkholland.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Quim K. Holland" <qkholland@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 02:35:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Vn3-0005mc-60
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 02:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYK0Bda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 20:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbYK0Bda
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 20:33:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:41105 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750797AbYK0Bd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 20:33:29 -0500
Received: (qmail invoked by alias); 27 Nov 2008 01:33:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 27 Nov 2008 02:33:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZgD5BMscZML+ME4kS40XKtTlVp3xam27CwYY5sX
	tROeSGrtkRpnkY
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081127013456.6117@qkholland.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101784>

Hi,

On Thu, 27 Nov 2008, Quim K. Holland wrote:

> I think git is buggy.

You probably missed the difference between porcelain and plumbing.  Git is 
not buggy.

Ciao,
Dscho
