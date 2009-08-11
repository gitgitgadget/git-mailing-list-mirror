From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: Re: rename/copy detection not working for git-log?
Date: Tue, 11 Aug 2009 09:57:36 -0400
Message-ID: <20090811135736.GL6327@morganstanley.com>
References: <20090811132144.GJ6327@morganstanley.com> <807hxasbz4.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 16:07:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mas0g-0001so-Hw
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 16:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbZHKOHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 10:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbZHKOHU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 10:07:20 -0400
Received: from pimtaint01.ms.com ([199.89.103.68]:44723 "EHLO
	pimtaint01.ms.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbZHKOHU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 10:07:20 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2009 10:07:19 EDT
Received: from pimtaint01 (localhost.ms.com [127.0.0.1])
	by pimtaint01.ms.com (output Postfix) with ESMTP id 0CC862943CD;
	Tue, 11 Aug 2009 09:57:37 -0400 (EDT)
Received: from ny0031as02 (unknown [170.74.93.53])
	by pimtaint01.ms.com (internal Postfix) with ESMTP id E0F305B0033;
	Tue, 11 Aug 2009 09:57:36 -0400 (EDT)
Received: from np315c1n4 (localhost [127.0.0.1])
	by ny0031as02 (msa-out Postfix) with ESMTP id DDECAE983F5;
	Tue, 11 Aug 2009 09:57:36 -0400 (EDT)
Received: from menevado.ms.com (unknown [144.203.222.190])
	(Authenticated sender: smtp/menevado)
	by ny0031as02 (msa-in Postfix) with ESMTPA id B9CA0E24038;
	Tue, 11 Aug 2009 09:57:36 -0400 (EDT)
Received: by menevado.ms.com (Postfix, from userid 49008)
	id 7CFD4530210; Tue, 11 Aug 2009 09:57:36 -0400 (EDT)
Mail-Followup-To: Bruce Stephens <bruce.stephens@isode.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <807hxasbz4.fsf@tiny.isode.net>
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.35/RELEASE, bases: 11082009 #2366921, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125561>

On 08/11/09 09:42:55, Bruce Stephens wrote:
> Kevin Green <Kevin.T.Green@morganstanley.com> writes:
> 
> [...]
> 
> > What am I missing?
> 
> I'd guess --follow

Ah, yep...  didn't see that earlier.  Exactly what I need, thanks.


--Kevin
