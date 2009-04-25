From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [OT] git rewriting history haiku
Date: Sat, 25 Apr 2009 12:25:23 -0500
Message-ID: <b4087cc50904251025x25ad57e9o55c809a669465c92@mail.gmail.com>
References: <f5a022cd25b3838cec36b6a60e7844e8.squirrel@webmail.icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: wjl@icecavern.net
X-From: git-owner@vger.kernel.org Sat Apr 25 19:32:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxlja-0003YU-Oe
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 19:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbZDYRZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 13:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbZDYRZZ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 13:25:25 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:20873 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbZDYRZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 13:25:25 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1379411qwd.37
        for <git@vger.kernel.org>; Sat, 25 Apr 2009 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eYiOcdHVqt0bl8nLHiTFiQK/bQHdq0SMLsOgGs2WzC4=;
        b=YJGjorsQCK/AQ6naa3oHVHo0iRXKoFaaDuI3UVDB1Wvm6CVGZ/Yf7gAB3x0sD+6JE3
         gPh43xXBlpHA0hmk+8/DmSrTdivOSl2yj7NkryMmsOhASd/J7ITGxS3QCSf09edeVBKn
         JCXw2v9NDdvYhj0MVc8t07pQd5Btm1euv6/+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZPfH0X+XRZevhhmRLGzX+ipNRYlCojsx7mLHzlp2xrmNrXK/jCvFc7R9jy381vGRHO
         gDsnqM7PhEbcHAfK8mA6ikpWcub2eer0aypdohxVLUzKwKj50hGQ+PZkPXDpo+xkQFm7
         Ki1xHqX1ZdyESUmaWzRLolXLifbxh8KJaqwBQ=
Received: by 10.224.37.19 with SMTP id v19mr4199678qad.70.1240680323936; Sat, 
	25 Apr 2009 10:25:23 -0700 (PDT)
In-Reply-To: <f5a022cd25b3838cec36b6a60e7844e8.squirrel@webmail.icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117563>

On Sat, Apr 25, 2009 at 10:54,  <wjl@icecavern.net> wrote:
> I'm apparently WAY too happy about git's history rewriting capabilities
> this morning.
>
> rebase dash 'i' and
> git filter branch: before them
> I never felt bliss

Thanks for the smile :-D
