From: Drew Northup <drew.northup@maine.edu>
Subject: Re: A basic question
Date: Wed, 10 Oct 2012 15:36:34 -0400
Message-ID: <1349897794.32696.15.camel@drew-northup.unet.maine.edu>
References: <001501cda711$8ab6f0a0$a024d1e0$@com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "'Skot Davis'" <skotd122@gmail.com>
To: Jim Vahl <jv@wmdb.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 21:37:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM26F-0005Ue-Dn
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 21:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684Ab2JJThg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 15:37:36 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:47231 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977Ab2JJThg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 15:37:36 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id q9AJabJS025986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 10 Oct 2012 15:36:37 -0400
In-Reply-To: <001501cda711$8ab6f0a0$a024d1e0$@com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=3 Fuz1=3
	Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: q9AJabJS025986
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1350502619.85258@/lH7FkCyrRuxRVOlwUFW2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207430>

On Wed, 2012-10-10 at 11:03 -0700, Jim Vahl wrote:
> All,
> 
> Our company is researching version control software, something which we have
> not used previously.  I have a very basic question about git which I have
> not been able to answer from reading.  As I understand it, a git repository
> can be a mixture of files which are under development, staged or committed.
> If we make a new build of our product we will obviously only want to include
> the committed (tested) files.  
> 
> The question is this: what is the usual procedure to retrieve a set of
> committed  files only from the repository to place into a distribution or
> "ready to build" folder.  The same question goes for tagging a release: how
> does the user get the tag to reference the committed files only and not the
> most recent files which may be under development or undergoing testing.
> 
> Thanks,
> 
> Jim Vahl

Jim,
Have you looked at http://git-scm.com/book yet? It sounds to me like you
have some misconceptions about how Git works. (If so, did it leave you
more or less confused?)

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
