From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 20:06:17 +0300
Organization: Private
Message-ID: <3awb7zw6.fsf@blue.sea.net>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	<471476B7.5050105@users.sourceforge.net>
	<8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
	<47148F72.1090602@users.sourceforge.net>
	<1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
	<B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 20:29:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhrAi-0004cH-5O
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 20:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935239AbXJPS2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 14:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935068AbXJPS2q
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 14:28:46 -0400
Received: from main.gmane.org ([80.91.229.2]:39523 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935233AbXJPS2p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 14:28:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ihpzg-0002gL-7R
	for git@vger.kernel.org; Tue, 16 Oct 2007 17:14:12 +0000
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 17:14:12 +0000
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 17:14:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:/rt/5hLA43IPiMD5vTOCCScXbXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61236>

* Tue 2007-10-16 Michael Witten <mfwitten AT MIT.EDU>
* Message-Id: B2F6DB0C-4EFE-4C56-8E7A-31820320CA02 AT mit.edu
> On 16 Oct 2007, at 11:26:07 AM, Jeffrey C. Ollie wrote:
>
>> Instead of using "(setq indent-tabs-mode t)" use "(setq indent-tabs-
>> mode
>> nil)".  This will force emacs to always use spaces to indent.
>
> However, 8 spaces per tab is a lot of wasted
> information to be bandying about.

Spaces are guaranteed to interpreted correctly in all environments. TABs
are the source of too many problems.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
