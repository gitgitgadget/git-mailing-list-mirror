From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: On Tabs and Spaces
Date: Thu, 18 Oct 2007 13:36:40 +0300
Organization: Private
Message-ID: <4pgolnev.fsf@blue.sea.net>
References: <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu>
	<3awb7zw6.fsf@blue.sea.net>
	<alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
	<1192565900.6430.16.camel@athena>
	<alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
	<20071017015109.303760cc@localhost.localdomain>
	<alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
	<3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
	<E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu>
	<k5pll7rb.fsf@blue.sea.net> <20071018054246.GA9423@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 12:37:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiSkZ-0001GH-IC
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 12:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084AbXJRKg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 06:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756228AbXJRKg7
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 06:36:59 -0400
Received: from main.gmane.org ([80.91.229.2]:39940 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755071AbXJRKg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 06:36:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IiSkJ-0006DQ-R6
	for git@vger.kernel.org; Thu, 18 Oct 2007 10:36:55 +0000
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 10:36:55 +0000
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 10:36:55 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:/eoAXKumReJoyAKMsiw8oSQc3Rk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61513>

* Thu 2007-10-18 Mike Hommey <mh@glandium.org> gmane.comp.version-control.git
* Message-Id: 20071018054246.GA9423@glandium.org
>> Any cross platform development or electronic exchange is guaranteed to
>> be interpreted correctly when policy enforces "only spaces"
>
> There is such problem with spaces. A lot of editors will just insert
> tabs to indent a new line when the previous you were typing begins with
> enough spaces, in which case you end up with spaces and tabs mixed all
> the way. It ends up being worse than all tabs.

There is "all-spaces", but there is no "all-tabs" choice.

The latter will always be mixture of "spaces and tabs". We have no
control how the tabs mix with spaces or vice versa: there could even be
"eight spaces" + proper tabs.

Speaking generalities (not the git project):

    People can't be controlled, or their settings. Therefore there is a
    policy and QA tools to monitor the issues and make things canonical;
    whatever that is for the project.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
