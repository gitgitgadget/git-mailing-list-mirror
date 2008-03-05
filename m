From: Robert Haines <rhaines@manchester.ac.uk>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on maxsize reached
Date: Wed, 5 Mar 2008 10:35:25 +0000
Message-ID: <F5DC9F11-FD88-4713-AD1A-6566C345852A@manchester.ac.uk>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <47CD78C9.80003@viscovery.net> <200803050937.40345.michal.rokos@nextsoft.cz>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Wed Mar 05 11:35:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWqyY-0007F7-C2
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 11:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760524AbYCEKfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 05:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758371AbYCEKfQ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 05:35:16 -0500
Received: from tranquility.mcc.ac.uk ([130.88.200.145]:65295 "EHLO
	tranquility.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757411AbYCEKfO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 05:35:14 -0500
Received: from gerhayn.mcc.ac.uk ([10.2.18.1])
	by tranquility.mcc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1JWqxs-000E3Q-RM; Wed, 05 Mar 2008 10:35:12 +0000
Received: from leela.rcs.manchester.ac.uk ([130.88.1.66]:55951)
	by gerhayn.mcc.ac.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1JWqxs-000Hmq-PD; Wed, 05 Mar 2008 10:35:12 +0000
In-Reply-To: <200803050937.40345.michal.rokos@nextsoft.cz>
X-Mailer: Apple Mail (2.753)
X-Authenticated-Sender: Robert Haines from leela.rcs.manchester.ac.uk [130.88.1.66]:55951
X-Authenticated-From: Robert.Haines@manchester.ac.uk
X-UoM: Scanned by the University Mail System. See http://www.itservices.manchester.ac.uk/email/filtering/information/ for details.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76209>


> Could somebody else try to run testcase above on some other OSes?


Mac OS X Darwin 8.11.1 i386 (Tiger)

case1: 5
case2: 5
case3: 5
case4: 5

Cheers,
Rob

