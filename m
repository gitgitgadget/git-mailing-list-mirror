From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Trivia: When did git self-host?
Date: Wed, 28 Feb 2007 19:48:47 +1300
Message-ID: <46a038f90702272248m4b4af750y4069d726e6e7f6e@mail.gmail.com>
References: <3c6c07c20702261551u55ec2ea7mde4075b1c929cf87@mail.gmail.com>
	 <Pine.LNX.4.63.0702270100360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <3c6c07c20702272157l5ee9a8b7y218e86ecb079a9fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Mike Coleman" <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 07:48:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMIcT-0005jT-Kc
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 07:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXB1Gst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 01:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbXB1Gst
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 01:48:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:21124 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbXB1Gss (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 01:48:48 -0500
Received: by nf-out-0910.google.com with SMTP id o25so459880nfa
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 22:48:47 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qBhKbjeSGgKUMEMU5OPFsQMV+Jdhv/BMclyH3YOQq9ramqryUyGyD5aA7tmbfi/2Ng1fTOMLfzlS5+ADegSyazmmHkzQvkzyxeZ6Gtbjz1jk/d6Btj8rxS3kRVbeoUlMlSb5dlb1CJ6d8rZCoLmQhrFHApRWQJ1z5WYICc+5bRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cErmyTFYVfYM1YYW6yfjASlvhPz0Z5hZKRgjWGv8UVScgqGgewu8+9GaI11keSfyANNAGBWASZi58h5pSvJ3iu+0Myhwu+y2FRBE4+1G32P4xgjGQUA9hd0Pe2AqQH8H8DumUFzLCroFLCgWYtCgjFwYhfRCh2PkDwUawOoTF4o=
Received: by 10.48.254.1 with SMTP id b1mr2982775nfi.1172645327182;
        Tue, 27 Feb 2007 22:48:47 -0800 (PST)
Received: by 10.48.215.2 with HTTP; Tue, 27 Feb 2007 22:48:47 -0800 (PST)
In-Reply-To: <3c6c07c20702272157l5ee9a8b7y218e86ecb079a9fc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40901>

On 2/28/07, Mike Coleman <tutufan@gmail.com> wrote:
> On another topic, it might amuse you to know that there's yet another
> 'git' floating around.  It's part of a bioinformatics package called
> SEALS.  Though it hasn't been maintained in several years, we have it
> installed at work.

There is also GNU Interactive Tools, and some fun flamewars about name
clashes, package conflicts and more... See

  http://lkml.org/lkml/2005/4/13/110
  http://www.gelato.unsw.edu.au/archives/git/0508/7477.html

for the tip of the iceberg.

cheers,


martin
