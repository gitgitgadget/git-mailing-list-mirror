From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Patches for some OS's.
Date: Thu, 5 Jun 2008 19:37:17 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051935540.21190@racer>
References: <Pine.LNX.4.64.0806051114260.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 20:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4KNE-00077w-2r
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 20:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755762AbYFESir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 14:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbYFESir
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 14:38:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:38200 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755436AbYFESiq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 14:38:46 -0400
Received: (qmail invoked by alias); 05 Jun 2008 18:38:43 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 05 Jun 2008 20:38:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+y+Cx6bnSyCN+eAdCbxxrQE5yIgxCmil9fe4edQi
	RbPUTj63a08HMW
X-X-Sender: gene099@racer
In-Reply-To: <Pine.LNX.4.64.0806051114260.18454@xenau.zenez.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83952>

Hi,

On Thu, 5 Jun 2008, Boyd Lynn Gerber wrote:

> I have attached the patches necessary to use GIT on some Non Linux OS's.

One might think that you could now use Git to generate the patches, and 
follow the conventions to submit them...

For example, reviewing attached patches makes it unduly hard on the 
reviewers.

For example, you do not have any explanation AKA commit message.

For example, you use context diffs.

See Documentation/SubmittingPatches for more hints how to get your patches 
integrated.

Hth,
Dscho
