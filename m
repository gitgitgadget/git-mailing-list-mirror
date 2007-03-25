From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git.git: topics and things like that
Date: Mon, 26 Mar 2007 11:04:48 +1200
Message-ID: <46a038f90703251604o21b2f805gfb280b76560de1e8@mail.gmail.com>
References: <200703252037.l2PKbhx6032045@localhost.localdomain>
	 <7vslbt2g0p.fsf@assigned-by-dhcp.cox.net>
	 <200703252117.l2PLHFkl000601@localhost.localdomain>
	 <7vhcs92cuu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Xavier Maillard" <zedek@gnu.org>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 01:04:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVble-0002xO-JO
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 01:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810AbXCYXEu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 19:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932889AbXCYXEu
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 19:04:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:57187 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932810AbXCYXEt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 19:04:49 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1936547wxd
        for <git@vger.kernel.org>; Sun, 25 Mar 2007 16:04:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OKBt7FFQc8kZe+lj9qbLRoSqqU1bM6UK/e82KMswyN/c1i6SGWrruymYL1PO2Kz2I3/SHLB1+DyWqnX6yi+Czc7WBhVVAcNBDDSjhMOnBkWqUQLV8P5TrvZaT5meMXSQO93f/DUIZ5UtF8kfTwYKEpChJ0XZpbjCf/KsjjfvNxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HNPJs6/bKMGjpnSfydD5nkQgkQp5eRjquUzqIsmzcRilvL9NOKfskXrKwReJeB8mmQ4ZPQJ7h3j5VGfX2vNWKDlc/DGlWTYZm0EOThYs1FUBE23Z5UWg4/oE/B3QVnXaqHvdBlaJWa5gXinzQMue3OHTayu7/t+X/qYSu8ZiIUk=
Received: by 10.90.118.12 with SMTP id q12mr6242657agc.1174863888426;
        Sun, 25 Mar 2007 16:04:48 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Sun, 25 Mar 2007 16:04:48 -0700 (PDT)
In-Reply-To: <7vhcs92cuu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43088>

On 3/26/07, Junio C Hamano <junkio@cox.net> wrote:
> Heh, how new are you to the list?
>
> Is every three months not often enough?  Meaning, is expecting
> new users to look back that much backlog in the list archive too
> much to ask?

I'd say he probably didn't know. Maybe an extra paragraph at the end
of the  README  ? along the lines of ...

The project maintainer sends out regular emails to the list titled "A
note from the maintainer", "What's cooking in git.git" and "Unresolved
issues". These messages and the discussion following them are a good
reference for project status, development direction and bugfixing
tasks.


cheers,


martin
