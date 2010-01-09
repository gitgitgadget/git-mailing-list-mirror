From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: For real now: bug tracking and secretary tasks in git
Date: Sat, 9 Jan 2010 18:22:21 -0200
Message-ID: <a4c8a6d01001091222t8e4586td2423504dfd43ea7@mail.gmail.com>
References: <20100109013850.16f82412@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sat Jan 09 21:24:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NThrY-0002kX-Er
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 21:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab0AIUWZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jan 2010 15:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476Ab0AIUWY
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 15:22:24 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:48424 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab0AIUWY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jan 2010 15:22:24 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1516714eye.19
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 12:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IrQDI2szjn2oU6iEm4FGifku64m6OBslzFzVm/fxO58=;
        b=VDJbyOYwY7ADtRhNUTOvcXqswmhmal1vGAHqAhhm5vYzzsih1mT7TwE6MNyuKPb7Jg
         mOyiQh6OBCINJaWI10+2s534DhYaovyFwT6zdUnZn28TygB67ltK8fB6Vr64B4PYlM+H
         8JveEFEovyoe9Qn9smhHCQNbeZcyV854Pi4J0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=In3JwvtRUEmR5h+SqPUDKYsDk+akhdhy8tRt/t4xCxRkgJ/BxwC8aBBKy0xLCnpgmQ
         q6SvVw7sA+my5dhx1TrubhTIKBopJ/tsKF6JTVHNW9jyJC1r4rlTr4HGupIGNJOltY6b
         9PEFr3ZqbW5XDPpRZ+mtm6Bp5hce1ZNyxxCNo=
Received: by 10.216.86.72 with SMTP id v50mr1502031wee.184.1263068541801; Sat, 
	09 Jan 2010 12:22:21 -0800 (PST)
In-Reply-To: <20100109013850.16f82412@perceptron>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136538>

On Fri, Jan 8, 2010 at 10:38 PM, Jan Kr=C3=BCger <jk@jk.gs> wrote:
> The proposal goes like this:
>
> * Set up bug tracker (done; it's at http://gitbugs.jk.gs/).
Thanks for doing that!!
