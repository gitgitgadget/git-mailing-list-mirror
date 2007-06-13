From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [PATCH] Add a guilt-export(1) command to export a guilt series to quilt.
Date: Wed, 13 Jun 2007 11:51:04 -0400
Message-ID: <20070613155104.GB18989@filer.fsl.cs.sunysb.edu>
References: <1181743313509-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 17:51:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyV7w-0002hp-Bk
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 17:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758268AbXFMPvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 11:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758256AbXFMPvM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 11:51:12 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:47844 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758066AbXFMPvL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 11:51:11 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l5DFp4uQ019444;
	Wed, 13 Jun 2007 11:51:04 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l5DFp4aB019441;
	Wed, 13 Jun 2007 11:51:04 -0400
Content-Disposition: inline
In-Reply-To: <1181743313509-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50080>

On Wed, Jun 13, 2007 at 04:01:53PM +0200, Pierre Habouzit wrote:
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  Documentation/guilt-export.txt |   30 ++++++++++++++++++++++++++++++
>  guilt-export                   |   26 ++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/guilt-export.txt
>  create mode 100755 guilt-export

Applied.

Thanks.

Josef "Jeff" Sipek.

-- 
Computer Science is no more about computers than astronomy is about
telescopes.
		- Edsger Dijkstra
