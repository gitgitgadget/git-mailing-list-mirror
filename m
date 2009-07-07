From: "Andre Mostert" <Andre.Mostert@intecbilling.com>
Subject: git svn fetch fails with Temp file with moniker 'svn_delta' already in use
Date: Tue, 7 Jul 2009 18:14:07 +0200
Message-ID: <B4BD8C6031F4EC4DAD8EABAB3ABA6CFE024DD4C5@IBCPTEX01.intecbilling.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 18:30:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MODYa-0006ol-HQ
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 18:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497AbZGGQ3s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2009 12:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757080AbZGGQ3s
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 12:29:48 -0400
Received: from gateway.cpt.intecbilling.com ([196.30.79.194]:26471 "HELO
	gateway.cpt.intecbilling.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756960AbZGGQ3s convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Jul 2009 12:29:48 -0400
X-Greylist: delayed 916 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jul 2009 12:29:47 EDT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git svn fetch fails with Temp file with moniker 'svn_delta' already in use
Thread-Index: Acn/HfQ1htnv02iyQvKKElkeWMF+mg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122853>

Hi=20

I'm getting this error when trying to "git svn fetch":

Temp file with moniker 'svn_delta' already in use at /usr/lib/perl5/sit=
e_perl/5.10.0/Git.pm

I've found some mention of this in the archives, but no conclusive fixe=
s or workarounds.

This is with git 1.6.3.3, perl 5.10.0 and svn 1.5.1

Thanks
Andr=E9 Mostert
