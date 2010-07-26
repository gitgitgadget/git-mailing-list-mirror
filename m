From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: Potential bug in gitweb 1.7.2
Date: Mon, 26 Jul 2010 14:50:59 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1007261346060.14251@dr-wily.mit.edu>
References: <4C4D152A.7050505@gmail.com> <20100726050849.GA16858@burratino> <alpine.DEB.2.00.1007260508290.14251@dr-wily.mit.edu> <20100726152356.GA6564@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: julio.lajara@alum.rpi.edu, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 20:56:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSqS-0000A3-UM
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751Ab0GZS4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 14:56:07 -0400
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:63705 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752019Ab0GZS4G (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 14:56:06 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2010 14:56:05 EDT
X-AuditID: 12074423-b7cb4ae000000a9b-d4-4c4dd917417a
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Brightmail Gateway) with SMTP id BC.DE.02715.719DD4C4; Mon, 26 Jul 2010 14:51:03 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o6QIp1i7005361;
	Mon, 26 Jul 2010 14:51:01 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6QIoxej016322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 26 Jul 2010 14:51:00 -0400 (EDT)
In-Reply-To: <20100726152356.GA6564@burratino>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151882>

On Mon, 26 Jul 2010, Jonathan Nieder wrote:
> Good to know.  Is there a public git repository for the PPA?  (I am 
> asking selfishly, because it would be convenient to be able to tell what 
> commit each version corresponds to and to steal changes back.)

There is now:
  git://andersk.mit.edu/git.git
  http://andersk.mit.edu/gitweb/git.git
(The most recent version is on the ppa branch, but there are tags going 
back through 1.7.0.1-1~ppa1.)

Anders
