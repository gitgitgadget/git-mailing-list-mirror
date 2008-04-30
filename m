From: "Richard Quirk" <richard.quirk@gmail.com>
Subject: Re: help with git usage
Date: Wed, 30 Apr 2008 13:50:45 +0200
Message-ID: <cac9e4380804300450k763fa22dr19260b2c75f11c96@mail.gmail.com>
References: <200804291738.m3THc2hC030601@rs40.luxsci.com>
	 <cac9e4380804300122v4f23251cqbc36640a07379c8@mail.gmail.com>
	 <m3hcdjocdc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 13:51:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrAqe-0008Sl-Ul
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 13:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbYD3Lu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 07:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755815AbYD3Lu4
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 07:50:56 -0400
Received: from hu-out-0506.google.com ([72.14.214.227]:55709 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbYD3Luz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 07:50:55 -0400
Received: by hu-out-0506.google.com with SMTP id 19so626807hue.21
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=JfAtiUYSneHmS3QdQatqYsYESxYmvTkTt9w/BRX3JLM=;
        b=qle8yFItCc0fU35X6wOTgOnK6xiRIdxpb9kZr+bSD7v6mJS7puLyZOHJ5jE0aa+Y5Johq5Q5+PPzwXDXe/I94843Tgy+tK0nZpEyWJ3LNP8hvAhQH4unoRv7MOobzD0KsBNB2THP4nAyiKWgp+J65ZVZ9BO1Xd/KUFKbt8KhMWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ICkx/ot8YroqatGE8Jvvvt1ZjwGNCphMKh16W6CdK67/PXUdKWo4oTcZYQzVa1tZ33YuAMmzeDB5W8RYCvKtHPu7HDpBdJQnT/FREa3cAlHFlu3Zs0w2IzSdkZUFQUV4Wo3eGxH8YuYiIRCVJR3m+oXxnCtytXI7VWf5BX9V8uA=
Received: by 10.70.118.4 with SMTP id q4mr923534wxc.9.1209556251769;
        Wed, 30 Apr 2008 04:50:51 -0700 (PDT)
Received: by 10.70.23.17 with HTTP; Wed, 30 Apr 2008 04:50:45 -0700 (PDT)
In-Reply-To: <m3hcdjocdc.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80828>

On Wed, Apr 30, 2008 at 12:39 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>
>  > If you use Vim, I'd recommend the vcscommand plugin - see
>  > http://code.google.com/p/vcscommand/
>
>  Could you add infomration about this to Git Wiki
>
>   http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
>  somewhere in "Editors and IDE integration" subsection?
>

Certainly. I've added a note about it to the end of that section.
