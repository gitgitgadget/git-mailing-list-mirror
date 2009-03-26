From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Do not read ~/.gitconfig during JUnit tests
Date: Thu, 26 Mar 2009 10:27:46 -0700
Message-ID: <20090326172746.GG23521@spearce.org>
References: <49C8E1E8.5020706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 18:29:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmtOL-00032r-Eb
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 18:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbZCZR1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 13:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753508AbZCZR1s
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 13:27:48 -0400
Received: from george.spearce.org ([209.20.77.23]:37858 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbZCZR1s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 13:27:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8646038211; Thu, 26 Mar 2009 17:27:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49C8E1E8.5020706@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114806>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> Extend the SystemReader interface to add the responsability
> to get the user's global configuration.
> This extension is used in the JUnit tests to provide a
> custom global configuration instance independant
> from ~/.gitconfig.
> 
> Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
> ---
> This should close the issue #42.

Thanks.
 
-- 
Shawn.
