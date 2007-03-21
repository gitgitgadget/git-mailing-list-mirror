From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Wed, 21 Mar 2007 01:35:22 +0100
Organization: At home
Message-ID: <etpuen$2uo$2@sea.gmane.org>
References: <20070320114525.GP96806@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 01:32:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTokp-0004IT-F2
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 01:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbXCUAca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 20:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933592AbXCUAca
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 20:32:30 -0400
Received: from main.gmane.org ([80.91.229.2]:40123 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932067AbXCUAca (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 20:32:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HToke-0000rA-4g
	for git@vger.kernel.org; Wed, 21 Mar 2007 01:32:28 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 01:32:28 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 01:32:28 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42771>

Eygene Ryabinkin wrote:

> NO_GUI disables the building and installation of the git GUI part.

By the way, it would be nice for ./configure script (generated from
configure.ac) to detect if Tcl/Tk is available and disable
git-gui and gitk installation if it is not found.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
