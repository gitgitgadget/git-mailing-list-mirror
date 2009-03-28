From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the 
	SVN
Date: Sat, 28 Mar 2009 22:55:37 +0100
Message-ID: <fabb9a1e0903281455x3ea64688tef08524fe0c43347@mail.gmail.com>
References: <22756729.post@talk.nabble.com> <8c9a060903280922r6514de83mea4dea84c4116225@mail.gmail.com> 
	<1238258794470-2549665.post@n2.nabble.com> <8c9a060903281102r3eae26edta34899485feb884b@mail.gmail.com> 
	<1238263580197-2549943.post@n2.nabble.com> <8c9a060903281327j33056807j78a2cd03b8151979@mail.gmail.com> 
	<1238276809892-2550565.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jamespetts <jamespetts@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 22:57:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LngWt-0007bl-GY
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 22:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbZC1Vz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 17:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbZC1Vz4
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 17:55:56 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:33551 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbZC1Vzz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 17:55:55 -0400
Received: by bwz17 with SMTP id 17so1437369bwz.37
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=R65s3Abnyto7W/0Mcm5W3cyxoE3aVulXkvALmKBJY1I=;
        b=EoDXVA0C6RI7467/rzKSeZxethhGMkvdotcT7CKdN8j49soamgLfUgXZ2GcHxg2r/0
         tGUdmzA2aQV0Nq7MZxkl9NuboYPc/t+WEp0h1KgUagI89zXmVN9VOcsJ5BMqnF+OzfZN
         kPE33h7PFNHFvuP+wP+b8vflcnBBTMcGMcxLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RJNTELnem3igB8o+OX6zC0X3ryp/3FXS066ebZK1HAVymZ+l4mvytcQV1FDRYZZ0nW
         evGDN6jXrQyYkfZCOa8z7JNL4rVBvkIo/HzAtZU1KDWsdPWDojBoJuKbos5NQTf8rzgP
         ysE6FinHfnnky5oWPPMwyWI4uFTbTwBLevwUQ=
In-Reply-To: <1238276809892-2550565.post@n2.nabble.com>
Received: by 10.103.226.10 with SMTP id d10mr985045mur.84.1238277352231; Sat, 
	28 Mar 2009 14:55:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114979>

Heya,

On Sat, Mar 28, 2009 at 22:46, jamespetts <jamespetts@yahoo.com> wrote:
> Thank you for your reply. Unfortunately, I cannot for the life of me get
> git-svn to work. It refuses to recognise "git svn" as a valid command,

What version are you using? Are you on Windows perhaps?

-- 
Cheers,

Sverre Rabbelier
