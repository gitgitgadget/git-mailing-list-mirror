From: Russ Dill <russ.dill@gmail.com>
Subject: Re: How do gmail users try out patches from this list?
Date: Tue, 11 Aug 2009 13:47:19 -0700
Message-ID: <f9d2a5e10908111347j4fbd94ecx3d973119e6860658@mail.gmail.com>
References: <2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 11 22:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MayFk-0004P7-JF
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 22:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbZHKUrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 16:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753680AbZHKUrT
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 16:47:19 -0400
Received: from mail-yw0-f193.google.com ([209.85.211.193]:56996 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbZHKUrS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 16:47:18 -0400
Received: by ywh31 with SMTP id 31so5173409ywh.4
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 13:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SMkpGoAm1sCHiP8AUDl9IZsXn2F5r5Fn6YW0Q+9ELj8=;
        b=i0CTJZcEfpqAkJGOqGxA9GjKiO6fsYVLZO/C/LYcvmNKtsf/5C+i3kjgCpuGrkomEI
         DBPuK4eVQYpkIYJB497UILj9uhUqwQoFZxVFXt7WRlw5rc7bUDOLRHA9zrkpJSdw7gk+
         FrvP2Xqcp51Pq5yMosaj1VGx3t4SRZKt0b+S4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gpCUimARskhOpFXg9ckG37VAl4VhzKojLYxWqo9N7ED/7u7L6TUTqjXDDpb9N06q77
         JVDWRTwIrO/gebtIQcBDf+szszyiqyO0AfcVaf4xyIMYUWMmzwQKYxT+AY6eivlTrvEP
         ydNU3cqVIS937XNTBYSHmPYokSsijJLMyYhSI=
Received: by 10.100.240.17 with SMTP id n17mr6018251anh.41.1250023639261; Tue, 
	11 Aug 2009 13:47:19 -0700 (PDT)
In-Reply-To: <2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125592>

> Sorry if this is dumb question, but I didn't see any good info in my searches.
>
> How do gmail users normally apply patches that come through the list?
> Do you just manually copy and paste the email to patch files and use
> git apply? Do you use a tool to export to mbox files and use git am?
>
> I've been just doing it manually via copy and paste, but it's kinda tedious.

Use the POP or IMAP to access your gmail account.
