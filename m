From: "Mike Coleman" <tutufan@gmail.com>
Subject: Re: Trivia: When did git self-host?
Date: Tue, 27 Feb 2007 23:57:45 -0600
Message-ID: <3c6c07c20702272157l5ee9a8b7y218e86ecb079a9fc@mail.gmail.com>
References: <3c6c07c20702261551u55ec2ea7mde4075b1c929cf87@mail.gmail.com>
	 <Pine.LNX.4.63.0702270100360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 06:57:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMHoz-0002E6-UM
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 06:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbXB1F5r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 00:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbXB1F5r
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 00:57:47 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:31138 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbXB1F5r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 00:57:47 -0500
Received: by nf-out-0910.google.com with SMTP id o25so448718nfa
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 21:57:45 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tjUN9DaP9z7thVAPFykYL+QSvUnKk14nJeIWqiVdoZb/m/+jXE4kVA30ChF0n9psl1pxbHV/3O4HSlHGJyuTSRIC2zQoc077mNi3QzQDXlRkdBST8C7aIfegnL2hS2qnW7RsHlQQyAU3O+HUsHQ3+9dPwcmRAbenw7M8tYwp0ng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m5OaHyx2nXubCmd59DfsBMYySDKMDwVCns8wzwmGJXsj1vldNyD7RLqQSNEHvfBgWtNRzYmJE4eudUCuu4jAmiE7ORpLbxD4bE8/+JxPzR4GWXM/R54Zr866cwNZV9/on6qvWDLvvhSBQIftkK+YkduoWeMxtgd98zIG7KR5Mr8=
Received: by 10.49.93.19 with SMTP id v19mr2828575nfl.1172642265696;
        Tue, 27 Feb 2007 21:57:45 -0800 (PST)
Received: by 10.49.92.17 with HTTP; Tue, 27 Feb 2007 21:57:45 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702270100360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40899>

On 2/26/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hey, how about adding a trivia page there, with the information you get
> here?

I will add it, to GitTrivia or GitHistory.  Thanks to everyone for the info.

I'm giving a talk about revision control tomorrow, which is what
inspired the question.  I'll be saying that git is very cool.  :-)

Looking back at previous systems, I was surprised at how capable (if
ugly) SCCS appears to have been.  (I got my start on RCS.)  Did you
know it had an "annotate" option (a la 'cvs annotate')?  I didn't.

On another topic, it might amuse you to know that there's yet another
'git' floating around.  It's part of a bioinformatics package called
SEALS.  Though it hasn't been maintained in several years, we have it
installed at work.

Mike
