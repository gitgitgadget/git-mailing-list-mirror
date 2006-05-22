From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 17:04:34 +1200
Message-ID: <46a038f90605212204m7735d637j50aeb9807eae336a@mail.gmail.com>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
	 <20060520203911.GI6535@nowhere.earth> <446F95A2.6040909@gentoo.org>
	 <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org>
	 <446FA262.7080900@gentoo.org>
	 <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
	 <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>
	 <44713BE4.9040505@gentoo.org>
	 <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Donnie Berkholz" <spyderous@gentoo.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Martin Langhoff" <martin@catalyst.net.nz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 22 07:04:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi2aw-0003O1-VQ
	for gcvg-git@gmane.org; Mon, 22 May 2006 07:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWEVFEg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 01:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWEVFEg
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 01:04:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:52242 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751181AbWEVFEf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 01:04:35 -0400
Received: by wr-out-0506.google.com with SMTP id 68so184697wri
        for <git@vger.kernel.org>; Sun, 21 May 2006 22:04:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OATTuSHmRQ5T7PjAK57a+JI1MklcAQaqFN7wDc1CK8OrJ5d+HA3B8qUCUJTZ0l4sZTpDgnt7ucOLYbwBOwkl3gUOI4ukn2mvix+ap4QggUQraqE0FwWs+07XYWfOr9t+sFZATu3biszveMIyR/Xr1pbXJ1V9cybXLNIuZL0LNBQ=
Received: by 10.54.99.4 with SMTP id w4mr1545291wrb;
        Sun, 21 May 2006 22:04:34 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Sun, 21 May 2006 22:04:34 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20482>

On 5/22/06, Linus Torvalds <torvalds@osdl.org> wrote:
> I wouldn't be in the least surprised if that ends up triggering a slow
> leak in CVS itself, and then CVS runs out of memory.

I'm dying to try this out myself after work. I don't discard that
cvsimport might be stuffing data in an array that grows forever. In
any case you'll hear from me soon.



martin
