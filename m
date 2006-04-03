From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Tue, 4 Apr 2006 10:38:12 +1200
Message-ID: <46a038f90604031538x3c94d86ap9f1400427513a3a7@mail.gmail.com>
References: <1143956188.2303.39.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 04 00:38:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQXgk-0006Q4-Kv
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 00:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWDCWiO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 18:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWDCWiO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 18:38:14 -0400
Received: from wproxy.gmail.com ([64.233.184.233]:24162 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964868AbWDCWiN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 18:38:13 -0400
Received: by wproxy.gmail.com with SMTP id i22so1375790wra
        for <git@vger.kernel.org>; Mon, 03 Apr 2006 15:38:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dtrKu0uPT5lGFpevo2LC4S6H5BRaTJ203vdsXYRlVaPW1FoqfvdcagB+Xxrz21Ssn0Wup7bgTFHtUljmFje+FLb1Vb76FW/xJjvHPwIcYDkhKeQR7lsGxPjUw8BN4QJy3AO6OCE9M7pK7tVcw5nVIZJVj6qXOHdQ65t300xGEy8=
Received: by 10.54.70.12 with SMTP id s12mr646392wra;
        Mon, 03 Apr 2006 15:38:12 -0700 (PDT)
Received: by 10.54.72.7 with HTTP; Mon, 3 Apr 2006 15:38:12 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1143956188.2303.39.camel@neko.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18358>

Keith,

Looks nifty. Though I thought you'd go for writing a smarter cvsps, so
that git-cvsimport could take advantage of it.

Looks like I'll have to brush up on my C to get to play... :-(



m
