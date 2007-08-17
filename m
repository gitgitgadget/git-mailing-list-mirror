From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Can't figure out some sense from the git-commit-tree man page
Date: Fri, 17 Aug 2007 13:36:22 -0400
Message-ID: <20070817173622.GI28529@fieldses.org>
References: <20070817163034.GA11151@glandium.org> <Pine.LNX.4.64.0708171751360.20400@racer.site> <20070817170411.GF28529@fieldses.org> <20070817172323.GA14145@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 19:36:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM5kL-0004Fz-Rv
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 19:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901AbXHQRg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 13:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbXHQRg0
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 13:36:26 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54986 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073AbXHQRg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 13:36:26 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IM5kE-0002AY-TF; Fri, 17 Aug 2007 13:36:22 -0400
Content-Disposition: inline
In-Reply-To: <20070817172323.GA14145@glandium.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56075>

On Fri, Aug 17, 2007 at 07:23:23PM +0200, Mike Hommey wrote:
> I think it would be better to put the fact that "If not provided..."
> *after* telling that you can provide author, committer, etc. by setting
> environment or editing the conf.

Yup, probably.  Patch?

--b.
