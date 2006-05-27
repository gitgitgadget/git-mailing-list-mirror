From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
Date: Sun, 28 May 2006 03:28:57 +1200
Message-ID: <46a038f90605270828u7842ea48hda07331388694db2@mail.gmail.com>
References: <4477B905.9090806@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Linux Kernel" <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 27 17:29:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk0ix-0000C3-Ja
	for gcvg-git@gmane.org; Sat, 27 May 2006 17:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWE0P3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 11:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWE0P3A
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 11:29:00 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:58035 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750900AbWE0P26 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 11:28:58 -0400
Received: by wr-out-0506.google.com with SMTP id i7so598964wra
        for <git@vger.kernel.org>; Sat, 27 May 2006 08:28:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ELGgKwqKC+wzlI2dydpY8j7mF+D3pKjRslWkNHVWRoJ5nSfhhmwvKuXFMZixXxGo+BAFzJ+/XoNK6mhg4tSkx6Ziix7lexp+SVtfi3WzvajZx8h8KElYENQDKiwx0p38WsqGUj4LGrTAxKd1u0RLNnuCjrMXogGiavFm0GdhXpo=
Received: by 10.54.121.18 with SMTP id t18mr414432wrc;
        Sat, 27 May 2006 08:28:57 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Sat, 27 May 2006 08:28:57 -0700 (PDT)
To: "Jeff Garzik" <jeff@garzik.org>
In-Reply-To: <4477B905.9090806@garzik.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20856>

I love perl golf for this kind of stuff... but git-stripspace is part
of git already. Even then, I tend to do it with perl -pi -e ''
constructs ;-)

cheers,


m
