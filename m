From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Don't want to leave git for hg
Date: Wed, 18 Feb 2009 09:39:07 +0100
Message-ID: <38b2ab8a0902180039n5080e55t809c1f6ff13cef71@mail.gmail.com>
References: <m27i3ou7fy.fsf@gmail.com>
	 <alpine.DEB.1.00.0902180030500.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 09:40:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZhyw-0005we-9Z
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 09:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbZBRIjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 03:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbZBRIjL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 03:39:11 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:44039 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbZBRIjK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 03:39:10 -0500
Received: by bwz5 with SMTP id 5so5089715bwz.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 00:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2CWo3RVO92IQ+0s74UyLrFIBuQaOFYmxZvIt7ZY3Kjc=;
        b=AJceGTpxESV4kPaP7dAcHV2EoSp27DYJSNh8Z/T56P4cupkVB/ob3lOx1aBixND/DB
         L+pt4cc31Zq9cPbrOS2iWhBy90dpt65zJeypRohZNTkaSQkUPwIHIogQxqVVp2CgOr9j
         Z8a4ds3Gm+nMc1IXx0Zv/REePDodi0Du/9lM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GZp0X0kV1+TvEU+gfLtGQ4oozXNNtWWWidx5RjxBTQ6o2KHGKelDcfhdgJBldyJsvz
         cLzevfCk+rQuWAoNv44JBTJJKsvk16vDB4GpMLPi4nOqgwKl2nxD8es0KSVTDFFU5B1J
         I+lr0YiGLaJ0pr3VVxQVKe5DGU9vkne24z25M=
Received: by 10.181.48.4 with SMTP id a4mr871193bkk.59.1234946347962; Wed, 18 
	Feb 2009 00:39:07 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902180030500.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110514>

Hello,

On Wed, Feb 18, 2009 at 12:34 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 17 Feb 2009, Francis Moreau wrote:
>
>> I found hg2git which could have solve my issue but it seems pretty old
>> and no more maintained.
>
> You did not say from where you have it, so I would never know if you mean
> the same as I do.

I used the version hosted by github somehow:

git://github.com/vitaly/hg2git.git

> I use the hg2git from http://repo.or.cz/w/fast-export.git and it works
> pretty well, most of the time.

Ok I missed this one.

Since you may have the same needs as mine, I'm asking another
question: once you have finished your work in your git repo, how do
you reintegrate them into the hg repo ? do you use patches or
something else ?

thanks
-- 
Francis
