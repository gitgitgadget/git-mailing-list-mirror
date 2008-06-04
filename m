From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Wed, 4 Jun 2008 09:52:28 +0600
Message-ID: <7bfdc29a0806032052w39010711q27e5257ef559908a@mail.gmail.com>
References: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com>
	 <200806031856.11060.robin.rosenberg.lists@dewire.com>
	 <20080603225418.GP12896@spearce.org>
	 <200806040130.41654.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 05:53:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3k4N-00023D-1l
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 05:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbYFDDwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 23:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbYFDDwa
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 23:52:30 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:5621 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbYFDDw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 23:52:29 -0400
Received: by yx-out-2324.google.com with SMTP id 31so200834yxl.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 20:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6Q0JwwPvEwm/+TQfE06MuBetS3iJpCIsL9Z2yvuk9cM=;
        b=noeTIXlcHXWPkAc6tsiiwRGU7HcTzsE44FiI1QM2zEgaDsH+pCE4h1X8gNdQv3abbYND3D5b1+8HDaVvIpBylxgaJz2h/snQTv3raC//tYB7zZo9VUcfTi2nElTqbTZ0EIoqnNKqTKrgWdyfYGn1N5a0t7IBPfC1Dal874QZDSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OJ3BB7Z4cHDf0ZCI3Hml34sidEDf1/UluYRMHTq5klBzmB2YCM6dTSGq/s0IwC3I6X6iSv00jiyExVZ7WjE0cQ8KtUbrLq8XM1e/Y55pOwlsK0oT+uDt4VnfOAYKcItitCcYasRAoi2ZfZQ4ZtBFZLkWu+IBjX2gWZJsIPPcviM=
Received: by 10.151.42.9 with SMTP id u9mr645771ybj.128.1212551548171;
        Tue, 03 Jun 2008 20:52:28 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Tue, 3 Jun 2008 20:52:28 -0700 (PDT)
In-Reply-To: <200806040130.41654.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83742>

The first version I mavenized JGit I moved the source code, but I
thought that would come in for more criticism :), thus I chose the
symlink option. Please let me know if a move based mavenizing would be
welcomed or not.

Best regards,

Imran

On Wed, Jun 4, 2008 at 5:30 AM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> onsdagen den 4 juni 2008 00.54.18 skrev Shawn O. Pearce:
>> I don't think there is a Cygwin based version of the JVM.  That would
>> be a very interesting beast.
> Looks like it could be possible to build it under Cygwin.
> http://download.java.net/jdk7/docs/build/README-builds.html#cygwin
>
> -- robin
>
>
>
>
>
>
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
