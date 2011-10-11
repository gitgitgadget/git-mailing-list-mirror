From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCHv5/RFC 3/6] gitweb: Add manpage for gitweb
	(APPLICATION!!!)
Date: Tue, 11 Oct 2011 10:01:54 -0400
Message-ID: <1318341714.22324.46.camel@drew-northup.unet.maine.edu>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
	 <20111010221811.GA21367@elie.hsd1.il.comcast.net>
	 <1318338135.22324.33.camel@drew-northup.unet.maine.edu>
	 <201110111551.09621.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 16:04:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDcwE-0000m6-C0
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 16:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab1JKOEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 10:04:04 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:49055 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab1JKOED (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 10:04:03 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p9BE1w8I018175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Oct 2011 10:01:58 -0400
In-Reply-To: <201110111551.09621.jnareb@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC--Metrics: beryl.its.maine.edu 1356; Body=4 Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p9BE1w8I018175
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1318946520.08425@+yNrZbsPoHSYzFY0jxzXzA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183296>

On Tue, 2011-10-11 at 15:51 +0200, Jakub Narebski wrote:
> On Tue, 11 Oct 2011, Drew Northup wrote:

> > This would be why I included a synopsis with my original submission. As
> > this was supposed to be a description of the configuration files of said
> > application it does not make much sense to put the executable in the
> > synopsis. Please forgive me for attempting to make sense!
> 
> But this manpage is about _gitweb itself_, not about gitweb config file(s).
> Gitweb itself is application, though it is not runnable directly (yet).
> 
> Web apps either don't use manpages as documentation, and those that do
> that I found (SVN::Web for example) include runnable server-starting script.

Hmm, Couldn't tell from the mail header _which_ we were talking about in
this subthread. I'll have to read the _whole_ patch apparently next
time.

Crawling back into my cave...

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
