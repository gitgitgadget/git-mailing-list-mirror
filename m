From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [msysGit] Windows & executable bit
Date: Tue, 18 Aug 2009 12:23:47 +0200
Message-ID: <200908181223.48291.trast@student.ethz.ch>
References: <45321.77.61.241.211.1250588523.squirrel@hupie.xs4all.nl> <alpine.DEB.1.00.0908181213590.4680@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>,
	<msysgit@googlegroups.com>, <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 12:24:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdLrW-0001A7-8e
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 12:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757263AbZHRKYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 06:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753746AbZHRKYJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 06:24:09 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:16126 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbZHRKYI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 06:24:08 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 18 Aug
 2009 12:24:09 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 18 Aug
 2009 12:24:07 +0200
User-Agent: KMail/1.12.1 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0908181213590.4680@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126370>

Johannes Schindelin wrote:
> 
> git config trust.fileMode false

Isn't that core.filemode ?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
