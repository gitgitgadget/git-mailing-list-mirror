From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Merge problems with git-mingw
Date: Tue, 09 Oct 2007 09:36:30 +0200
Message-ID: <470B2F7E.4080308@viscovery.net>
References: <Pine.LNX.4.64.0710081203020.29715@ds9.cixit.se>  <8c5c35580710080500n78259210v1b087e1ef506c0ee@mail.gmail.com>  <Pine.LNX.4.64.0710081333350.29715@ds9.cixit.se>  <8c5c35580710080610y739fb51aga82964e212c7917f@mail.gmail.com>  <Pine.LNX.4.64.0710081555480.29570@ds9.cixit.se> <8c5c35580710081259j6d7e8587r546d4c35d42a67a6@mail.gmail.com> <Pine.LNX.4.64.0710090800220.26773@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Oct 09 09:36:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If9e3-0003jM-DK
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 09:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbXJIHgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 03:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbXJIHgf
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 03:36:35 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18288 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbXJIHge (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 03:36:34 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1If9dg-0003e6-Tc; Tue, 09 Oct 2007 09:36:25 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E808B69F; Tue,  9 Oct 2007 09:36:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0710090800220.26773@ds9.cixit.se>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60368>

Peter Karlsson schrieb:
> I get the same error running mingw-git from a regular cmd.exe prompt,
> so it doesn't seem to be related to Cygwin at all.

What if you run 'git var -l' outside a repository? From CMD?
Have you tried 'git-var -l' (note the dash)? From CMD?
Are you sure you have only one version of git in the PATH?
What's in your .git/config?

-- Hannes
