From: "Aaron Gray" <angray@beeb.net>
Subject: Does Git run on Windows ?
Date: Thu, 6 Jul 2006 03:55:25 +0100
Message-ID: <01c001c6a0a7$a2783f90$0200a8c0@AMD2500>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 06 03:55:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyJ5b-0006CF-7s
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 03:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWGFBzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 21:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbWGFBzb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 21:55:31 -0400
Received: from lon1-mail-2.visp.demon.net ([193.195.70.5]:63850 "EHLO
	lon1-mail-2.visp.demon.net") by vger.kernel.org with ESMTP
	id S965065AbWGFBzb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 21:55:31 -0400
Received: from AMD2500 (mwgray.force9.co.uk [212.159.110.144])
	by lon1-mail-2.visp.demon.net (MOS 3.5.8-GR)
	with ESMTP id EEG38828 (AUTH angray);
	Thu, 6 Jul 2006 02:55:28 +0100 (BST)
To: "Git Mailing List" <git@vger.kernel.org>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23366>

This maybe a stupid question but does Git run on Windows ?

Are there better options ?

If not how much work would it be to port it ?

Its got lots of C code, and Bash scripts, with a couple of Perl scripts.

So should run on Cygwin okay, maybe even MinGW. Anyone tried either ?

This maybe the crunch and reason to use CVS for now :(?)

Aaron
