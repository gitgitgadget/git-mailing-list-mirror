From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: describe fails on tagless branch
Date: Wed, 07 Feb 2007 02:19:20 +0100
Message-ID: <45C92918.8010801@xs4all.nl>
References: <eqb660$ft7$1@sea.gmane.org> <eqb73j$hri$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 02:19:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEbTB-0002LF-7D
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 02:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030531AbXBGBTa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 20:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030530AbXBGBTa
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 20:19:30 -0500
Received: from main.gmane.org ([80.91.229.2]:58647 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030531AbXBGBT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 20:19:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HEbT3-0000pl-UF
	for git@vger.kernel.org; Wed, 07 Feb 2007 02:19:25 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 02:19:25 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 02:19:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
In-Reply-To: <eqb73j$hri$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38883>

Jakub Narebski escreveu:
> 
> _Which_ INIT? In git there can be more than one root commit. In git.git

I don't really care, but I would like git-describe to produce something 
useful in the absence of tags.  The -g<SHA-1> already makes the commit
uniquely identifiable.




-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
