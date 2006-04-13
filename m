From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] diff-options: add --stat
Date: Thu, 13 Apr 2006 19:47:07 +0200
Message-ID: <e5bfff550604131047mbcc2f8j9a12b69a024673d9@mail.gmail.com>
References: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vy7ya13e3.fsf@assigned-by-dhcp.cox.net>
	 <7vek02ynif.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 19:47:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU5uZ-0007uN-OQ
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 19:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWDMRrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 13:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWDMRrJ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 13:47:09 -0400
Received: from wproxy.gmail.com ([64.233.184.231]:24430 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751089AbWDMRrI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 13:47:08 -0400
Received: by wproxy.gmail.com with SMTP id i6so150111wra
        for <git@vger.kernel.org>; Thu, 13 Apr 2006 10:47:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lrwbqsBa9RoqhJzViwMN6mhJ1eyoqKr8XyeZEmjroMujJ8/gfxidzxbKDSk8ls5HrEZ38W1e2GEsLgXw8JU58LL1E5z67KjaGi6CQuceoDlMQeNZaR2NIgitE5CwPJUkMRGAr4NALJ9quT5jWaE8C+8lrT2gGNp2+k6AnOZizkc=
Received: by 10.64.178.16 with SMTP id a16mr530903qbf;
        Thu, 13 Apr 2006 10:47:07 -0700 (PDT)
Received: by 10.64.131.14 with HTTP; Thu, 13 Apr 2006 10:47:07 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vek02ynif.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18663>

On 4/13/06, Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
>
> It is very
> likely that diff-stat followed by diff-patch would be a popular
> format (that is what git-format-patch does),

Yes, it is very likely the new output format (stat+patch) will be the
default in qgit diff window viewer ;-)

Marco
