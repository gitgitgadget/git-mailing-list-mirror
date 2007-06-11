From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Does anyone have any benchmarks against CVS?
Date: Mon, 11 Jun 2007 20:09:54 +0100
Message-ID: <200706112009.55949.andyparkins@gmail.com>
References: <20070611090451.26209.qmail@science.horizon.com> <86odjmg7ty.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706111042110.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 21:10:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxpHI-0007ab-Gi
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 21:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbXFKTKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 15:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbXFKTKA
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 15:10:00 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:5918 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbXFKTJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 15:09:59 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1088500wra
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 12:09:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dg2FMsdcG9UmRjsrwKjaAeeh2/krAjrmbPluGst7Igs478Y3hTGEk2wXLWlrnnS5ULVye8gS3qFbetWDGmw8oJdB6I5zp1TMuam980fHf2K8jKdUM8zW6OI3WCAxoR0PYu5laGsr7GkzohAg+T3TXpC6Oil5wwiI+YrLea0Cx6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=i8gMO0YpPa3zVIviwZtlFDukRp/5eU6xnQUW8ebjoEPCDN4kNOaw8eMKqxAn6nt+uxNvw8FKTQA3paijMt3T9VmQxiUTU2+jJq81L/BMDTffsApgUunvetyU0iT03AnhKibwVjvFDts1RH1d6Ggb2b4aQh+1G55wueqIslyLXas=
Received: by 10.78.195.9 with SMTP id s9mr1919555huf.1181588997974;
        Mon, 11 Jun 2007 12:09:57 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id 31sm1046172nfu.2007.06.11.12.09.56
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Jun 2007 12:09:57 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0706111042110.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49870>

On Monday 2007, June 11, Johannes Schindelin wrote:

> I even presented Git to an svn user last week (not his fault, really,
> he was more than willing to try Git), and he was surprised that you
> could _continue_ working in the _same_ working directory as before,
> after git-init...

I always forget what a useful feature that is; I've become so used to 
running git-init everywhere I turn that the memory of the 
ridiculousness of SCMs that can't do that has already faded. :-)



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
