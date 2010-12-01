From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] git-add.txt: Order options alphabetically
Date: Wed, 01 Dec 2010 14:49:50 -0500
Message-ID: <1291232990.11917.40.camel@drew-northup.unet.maine.edu>
References: <1291218145-13016-1-git-send-email-jari.aalto@cante.net>
	 <1291229622.11917.14.camel@drew-northup.unet.maine.edu>
	 <87fwuhuwdu.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 20:50:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNsgw-0004OY-V9
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712Ab0LATuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:50:03 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:37791 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169Ab0LATuC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:50:02 -0500
Received: from [130.111.39.151] (drew-northup.unet.maine.edu [130.111.39.151])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id oB1Jntb4022573
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 1 Dec 2010 14:49:55 -0500
In-Reply-To: <87fwuhuwdu.fsf@picasso.cante.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oB1Jntb4022573
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1291837797.22631@8bxWfWRdufUB8Az96b6YNg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162588>


On Wed, 2010-12-01 at 21:27 +0200, Jari Aalto wrote:
> 2010-12-01 20:53 Drew Northup <drew.northup@maine.edu>:
> > On Wed, 2010-12-01 at 17:42 +0200, jari.aalto@cante.net wrote:
> > First off, this patch (and set I've seen thus far) has little no commit
> > message.
> 
> There is no point of making it any longer as it is basically the same
> for everything. I don't think we want to see long identical copies of
> explanations over and over in "git log".
> 
> > Did you plan on changing the the short help displayed by git add -h as
> > well?
> 
> Don't know. At this time, I happen to have some free time. But that's a
> good candidate for followup work.
> 
> Jari

First, before I reply to your post proper, I am going to echo others on
this list--unless you see a good specific reason to prune the CC/reply
list please leave it intact and use "reply all" and not "reply to list"
here once a conversation has been started. (Other lists may have
different conventions, and I am still absorbing some of the ones used
here myself...)

That said, like changes should be grouped together in closely related
patchsets. It makes life easier for everybody. Don't worry about using
virtually the same commit message over and over again if that's what is
actually appropriate. Junio may very well rebase/restructure patches
that need it (I haven't checked to see how often he bothers) and will
tell you if patch structure is completely out of line or unusable--but
that's not the same as others actually reviewing the changes themselves.

See 

Message-ID: <20101201165043.GF26120@burratino>

These changes should be a bundle, this bundle should have a "meta
message", and each element should have a commit message.


-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
