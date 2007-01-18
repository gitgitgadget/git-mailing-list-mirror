From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 10:21:05 +0100
Message-ID: <81b0412b0701180121i69661d36yba046222e654832b@mail.gmail.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	 <87ps9d7j6t.fsf@morpheus.local>
	 <7vejptsglj.fsf@assigned-by-dhcp.cox.net>
	 <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
	 <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>
	 <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
	 <20070118080613.GE23124@spearce.org>
	 <81b0412b0701180018i208e4158k2dd3e9ecdfa79b13@mail.gmail.com>
	 <7vps9cn1ip.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Josh Boyer" <jwboyer@gmail.com>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 10:21:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7TSJ-0006Zc-Bc
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 10:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbXARJVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 04:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbXARJVJ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 04:21:09 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:59200 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbXARJVH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 04:21:07 -0500
Received: by wr-out-0506.google.com with SMTP id 68so104009wra
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 01:21:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LYENABAno+47Sq3cjFhWRJthRPBgbjBoVRO4wrNHr/q1uIZXMYzZfKk91pcM08eoPHxBYaHTnON+T3bFcW4/RnRasRs5sQ0Gedl6HJpnekMQ/YpqQX5YWfHpSLjYf9OeLTze/2EhfA6TuOMBpbPoXy+o5+sc51sbQnY0arrT8Qo=
Received: by 10.78.200.3 with SMTP id x3mr592587huf.1169112065747;
        Thu, 18 Jan 2007 01:21:05 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 18 Jan 2007 01:21:05 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vps9cn1ip.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37071>

On 1/18/07, Junio C Hamano <junkio@cox.net> wrote:
> >> Thus the file extension has no impact on how the mail client should
> >> treat it.
> >
> > He will attach it. It's typical for outlook users.
>
> If that is the case, I highly suspect that it is one more reason
> not to mark the file with .txt; Outlook may say "Hey, it's TEXT,
> so let's linewrap it, quote-balance it and add all sorts of nice
> frills to make it easier to read for human consumption".

No, it wont (and doesn't). It would be "too clever to be useful".
Outlook is too _stupid_ to be useful.
