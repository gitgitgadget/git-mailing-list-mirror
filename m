From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] Add ALL_LDFLAGS to the git target.
Date: Tue, 28 Mar 2006 22:48:29 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne2jf9t.s3g.mdw@metalzone.distorted.org.uk>
References: <15693.1143575188@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Wed Mar 29 00:48:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOMzL-0007ZK-1j
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 00:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWC1Wsc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 17:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWC1Wsc
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 17:48:32 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:15714 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S932486AbWC1Wsb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 17:48:31 -0500
Received: (qmail 15151 invoked by uid 110); 28 Mar 2006 22:48:30 -0000
To: git@vger.kernel.org
Received: (qmail 15138 invoked by uid 9); 28 Mar 2006 22:48:29 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1143586109 14663 172.29.199.2 (28 Mar 2006 22:48:29 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Tue, 28 Mar 2006 22:48:29 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18135>

Jason Riedy <ejr@EECS.Berkeley.EDU> wrote:

> P.S. For the whole finding-a-function-name business, some of 
> us are using git on fixed-format Fortran.  Every non-comment
> line begins with whitespace...  ;)  And in free format, many
> people don't add that first indentation within subroutines.

Urgh.  So, which regex library do people want to use? ;-)  (My vote's
for pcre.)

-- [mdw]
