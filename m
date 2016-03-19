From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH] gitk: Follow themed bgcolor in help dialogs
Date: Sat, 19 Mar 2016 17:57:15 +1100
Message-ID: <20160319065715.GF27126@fergus.ozlabs.ibm.com>
References: <20160204023219.GA27647@fortress.battleship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Guillermo S. Romero" <gsromero@infernal-iceberg.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:00:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahAsa-00048z-Ki
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 08:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbcCSHAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 03:00:48 -0400
Received: from ozlabs.org ([103.22.144.67]:52327 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbcCSHAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 03:00:41 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3qRtK15CD2z9sC4; Sat, 19 Mar 2016 18:00:37 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <20160204023219.GA27647@fortress.battleship>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289292>

On Thu, Feb 04, 2016 at 03:32:19AM +0100, Guillermo S. Romero wrote:
> Make Help > About & Key bindings dialogs readable if theme
> has changed font color to something incompatible with white.
> 
> Signed-off-by: Guillermo S. Romero <gsromero@infernal-iceberg.com>

Thanks, applied.
Paul.
