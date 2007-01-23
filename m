From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 15:06:31 +0000
Message-ID: <200701231506.32396.andyparkins@gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at> <200701231322.32987.andyparkins@gmail.com> <Pine.LNX.4.63.0701231518310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 23 16:06:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9NEX-0006sH-KH
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 16:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbXAWPGk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 10:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbXAWPGk
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 10:06:40 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:43053 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbXAWPGj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 10:06:39 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1061228wra
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 07:06:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=O6Sks9+k77ebn1b/fAOJt8vGKOtq947DvGmpuGZ8lJLhljGyx+FVnu66VfO6lbSf1etVl3Ap/pNE3zJGfaWMvPnYUAJzPyeQElAcas8XLaAgsB4yCanWnbj1I/nb+QfjEi0OObvWOSv6x85MifzRS693vEQLIgVOnq1P0iJ5aF8=
Received: by 10.49.20.5 with SMTP id x5mr1228283nfi.1169564795997;
        Tue, 23 Jan 2007 07:06:35 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id k23sm2844290nfc.2007.01.23.07.06.34;
        Tue, 23 Jan 2007 07:06:35 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0701231518310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37530>

On Tuesday 2007 January 23 14:21, Johannes Schindelin wrote:

> Uhm. You do understand that we use MinGW to port to, not _plain_ Windows?
> So we do have a "less".

Nope; I didn't.  Oh dear.  I've obviously misunderstood.  I thought MinGW was 
for compiling to native Windows?  Do you use MinGW to compile to cygwin as 
well?

> That was not Windows. That was DOS.

I'm sure pipes were still awful in Win98.  I accept though, that it is 
possible Windows has changed in the last 9 years :-)

> With less, on the other hand, you just exit the pager, or let it search
> through stdin. It is so much more convenient.

That sounds better than I remember.  You'll have talked me into migrating to 
Windows soon :-)

Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
