From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: working out where git-rebase is up to?
Date: Mon, 22 Feb 2010 21:51:36 +1100
Message-ID: <2cfc40321002220251g7d7230a3g84753678f5d79d44@mail.gmail.com>
References: <2cfc40321002220209pe1942ecucb3716f60bf05d32@mail.gmail.com>
	 <201002221126.47372.trast@student.ethz.ch>
	 <201002221149.32504.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 22 12:45:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjVt9-0003ft-Rf
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 11:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139Ab0BVKvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 05:51:38 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62564 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab0BVKvh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 05:51:37 -0500
Received: by pwj8 with SMTP id 8so2562593pwj.19
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 02:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=zO0lLG1PzKMjIcUxoNN/NnkjeS/9f+MfcamgGwvawPs=;
        b=wi6AheDUPfw909QllSbTFV1LwjGXNDlZZzh9Cwxhed+KvGtOLfR1btDv+6PL0RSOu2
         vW4bVdhPmlhfPFL3uob4DX6IhKLvoQMWeAqk39BdkVqbyJENpOQvn9EW0rGP9VJQAqH6
         WYgvbRKabFNrOmVW93rVtXJfqni+FYTszfzkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XcAVPDObybQdf7/I5lBESGFjokl8tnyDSFdDWD7ZS5ih21Z65EXAEL+B+wrUUpP4EC
         Op4h+Uo4VlM3WmRf82ByO3SQvByAoc8JKtJeZgq2cSx9q1ddNxYxJxoxdr+YxBkYq6gz
         Zdu2qgBC9ActAUPnbkWVzgoFBJo77KJd93qL8=
Received: by 10.114.21.9 with SMTP id 9mr2525604wau.105.1266835896961; Mon, 22 
	Feb 2010 02:51:36 -0800 (PST)
In-Reply-To: <201002221149.32504.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140664>

> Here's a lightly tested draft patch.  I should stop stealing work time
> for this, but you're welcome to fill in docs and tests and submit it.
>

Thanks! I'll give it a whirl.

jon.
