From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH] gitk: l10n: Update Catalan translation
Date: Fri, 30 Oct 2015 20:58:51 +1100
Message-ID: <20151030095851.GB25993@fergus.ozlabs.ibm.com>
References: <1444105572-20580-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 11:11:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zs6e9-0004F4-2P
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 11:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030730AbbJ3KKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 06:10:46 -0400
Received: from ozlabs.org ([103.22.144.67]:49348 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030724AbbJ3KKq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 06:10:46 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id D97551412DF; Fri, 30 Oct 2015 21:10:44 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <1444105572-20580-1-git-send-email-alexhenrie24@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280483>

On Mon, Oct 05, 2015 at 10:26:12PM -0600, Alex Henrie wrote:
> The gitk included in git 2.6.0 crashes if run from a Catalan locale.
> I'm hoping that a translation update will fix this.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>

Should actually be fixed by a patch from Beat Bolli that I just applied,
but I applied your patch also.

Paul.
