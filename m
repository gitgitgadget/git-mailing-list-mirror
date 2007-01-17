From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] git-reset: make the output as the fetch output
Date: Wed, 17 Jan 2007 13:41:21 +0000
Message-ID: <200701171341.22860.andyparkins@gmail.com>
References: <87odox23u9.fsf@gmail.com> <8aa486160701170527p69c59510i2daf99e7e805ec5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Santi =?iso-8859-1?q?B=E9jar?=" <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 17 14:41:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7B2k-00041H-PG
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 14:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbXAQNld convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Jan 2007 08:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbXAQNld
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 08:41:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:58035 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105AbXAQNlc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jan 2007 08:41:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1988405uga
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 05:41:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DYVEcAeMb9uKlLblqXta92wmjJwIsfqayhQStTykVQ8tUzN9/WdfDWxrSLUeOzsqTQIOsM2drkcuEdSIRsAIyBqnIPD33L0mA1FYVMwE9cvfUzqiFMNEzox9Jzi6LRZ6KQMLcE5F86J0ITWJYWFVXy9OzRblG/gVlgjQJtM4OfY=
Received: by 10.66.243.2 with SMTP id q2mr9493352ugh.1169041286796;
        Wed, 17 Jan 2007 05:41:26 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id k1sm10460408ugf.2007.01.17.05.41.25;
        Wed, 17 Jan 2007 05:41:26 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <8aa486160701170527p69c59510i2daf99e7e805ec5a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37000>

On Wednesday 2007 January 17 13:27, Santi B=E9jar wrote:

> > +    echo "* HEAD: reset to $commit"
>
> [...]
>
> perhaps?
> echo "* HEAD: resetted to $commit"

You were right the first time; "reset" is the correct past-tense form. =
 If=20
anything, I'd lose the colon...

 HEAD reset to $commit

is a perfectly acceptable sentence.



Andy
--=20
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
