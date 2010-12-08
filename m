From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: Tonight's pushout
Date: Wed, 8 Dec 2010 15:35:11 -0600
Message-ID: <idotn7$9o7$1@dough.gmane.org>
References: <7v8w01m27t.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 22:35:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQRg1-0005W6-2g
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 22:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520Ab0LHVfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 16:35:48 -0500
Received: from lo.gmane.org ([80.91.229.12]:45408 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432Ab0LHVfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 16:35:47 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PQRfv-0005UQ-02
	for git@vger.kernel.org; Wed, 08 Dec 2010 22:35:47 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 22:35:46 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 22:35:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163223>

"prerelease freeze" is not in the git-workflows manpage.  I'm interested in 
how you-all do this because I use the git-workflows mangpage to help me 
figure out my workflows.  Can someone explain?

v/r,
Neal

"Junio C Hamano" <gitster@pobox.com> wrote in message 
news:7v8w01m27t.fsf@alter.siamese.dyndns.org...
> All four main integration branches in tonight's pushout will pass tests if
> you drop three-tip commits from 'pu'.  That might be just showing that
> there are some caps in the tests, but I am somewhat happier than usual.
>
> Tomorrow, I hopefully will start moving stuff out of 'next' to 'master',
> and 'pu' to 'next', in preparation for 1.7.4 prerelease freeze. 
