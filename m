From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (Aug 2009, #05; Wed, 26)
Date: Wed, 26 Aug 2009 16:49:03 -0700
Message-ID: <20090826234903.GR1033@spearce.org>
References: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sverre@rabbelier.nl
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 01:49:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgSEs-00041l-85
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 01:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbZHZXtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 19:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbZHZXtC
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 19:49:02 -0400
Received: from george.spearce.org ([209.20.77.23]:47930 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbZHZXtC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 19:49:02 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D931C381FE; Wed, 26 Aug 2009 23:49:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127122>

Junio C Hamano <gitster@pobox.com> wrote:
> * sr/gfi-options (2009-08-24) 4 commits
>  - fast-import: test the new option command
>  - fast-import: add option command
>  - fast-import: put marks reading in it's own function
>  - fast-import: put option parsing code in seperate functions
> 
> Will merge to 'next' shortly.

Please don't.

There is an off-git ML thread running between the various DVCS
tool developers who work on the fast-import/fast-export tools for
the respective DVCSes.  In that thread we have decided to slightly
change this grammar and this series needs to be respun.

If you are itching to do something, eject it from pu and wait for
the respin.
 
-- 
Shawn.
