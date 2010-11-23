From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Tue, 23 Nov 2010 23:23:46 +0000
Message-ID: <AANLkTi=UPSaG=sF=zH7eyxWqyPOFSbx0b+-yeZqMdP+1@mail.gmail.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
	<4CEC36F3.5020908@hupie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git ML <git@vger.kernel.org>
To: Ferry Huberts <mailings@hupie.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 00:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL2DJ-0006rN-HS
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 00:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab0KWXXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 18:23:48 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53273 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab0KWXXs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 18:23:48 -0500
Received: by qyk11 with SMTP id 11so2919805qyk.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 15:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=NqtIk+UXtIZXpvbLlTHlQh2aupR0ww6fociLRmEy2lQ=;
        b=czVOhqG7BK3G9TxdvTKL1mcOxXgb8snj0rDlO191w8lfRZ4T+TsGILYgYk2wndvo4y
         sNHbswawsgZF3v3KBWHQOUXfME05YJ9HW7aIVe6df4zwqaj0YcIptGCtQB1N0S474IwI
         h/Ktq5qUqyULgJqfu4UJkgqRuqwQNxvSfTRI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NT8U8O+MowMT3RuIkrbWgvj+Tz6I8CwpkSo8fWFPAPdr33DUSGhDJJZivgBuIBX4vo
         MxcXWoQAgOiKqQEL2v5zBN/C42BepiIog4o1zIiSP8uVY4lw7bgTMbYReQxTPEC6UW2H
         cHN6GvUeW+t/0IbcPrNycMDg0b++sS+x/GNgI=
Received: by 10.229.184.204 with SMTP id cl12mr5702265qcb.228.1290554626839;
 Tue, 23 Nov 2010 15:23:46 -0800 (PST)
Received: by 10.220.186.198 with HTTP; Tue, 23 Nov 2010 15:23:46 -0800 (PST)
In-Reply-To: <4CEC36F3.5020908@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162033>

On Tue, Nov 23, 2010 at 9:49 PM, Ferry Huberts <mailings@hupie.com> wrote:
> Are your users using the 'show my status in the prompt' feature?
> If so, then disable all but showing the current branch, it makes a whole
> lot of difference :-)

Thanks, we're not :-) .D
