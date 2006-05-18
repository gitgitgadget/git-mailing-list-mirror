From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [Patch] git-cvsimport: tiny fix
Date: Thu, 18 May 2006 16:53:56 +1200
Message-ID: <46a038f90605172153mac96f40id9a50d2f29c75915@mail.gmail.com>
References: <20060510173703.GA10335@memak.tu-darmstadt.de>
	 <7vd5eccvns.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Elrond <elrond+kernel.org@samba-tng.org>
X-From: git-owner@vger.kernel.org Thu May 18 06:54:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgaWO-0003rS-G5
	for gcvg-git@gmane.org; Thu, 18 May 2006 06:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWEREx5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 00:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWEREx5
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 00:53:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:5652 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751047AbWEREx5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 00:53:57 -0400
Received: by wr-out-0506.google.com with SMTP id 50so333708wri
        for <git@vger.kernel.org>; Wed, 17 May 2006 21:53:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IZQaCT9fh6kAYt9SRp48kPb6qkdgijD3KsGfnmzLrtAVojfZ3KXBHv4X8NqOviRaHHXl+yYWnnIIu2pdc2f5cseRzkZeKVACCmRIFr4wdLjEHLn0ccroFBfz8rPHbQrxqWUv2W/sIasoSnCGMtu9gg5ViUaDRfa/zYfSxL0Ez9g=
Received: by 10.54.111.9 with SMTP id j9mr109961wrc;
        Wed, 17 May 2006 21:51:48 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Wed, 17 May 2006 21:53:56 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vd5eccvns.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20260>

On 5/18/06, Junio C Hamano <junkio@cox.net> wrote:
> Could somebody who actually works with CVS import Ack this?
> Pretty please?

Sounds sane. It would be interesting to hear about what repo (and
server) this was seen against. Elrond, can you tell us more about
this?

cheers,


martin
