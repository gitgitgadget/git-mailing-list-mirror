From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git doesn't like big files when pushing
Date: Thu, 2 Mar 2006 13:45:34 +1300
Message-ID: <46a038f90603011645v7d039b1bif3da9ebb3fa3e1c1@mail.gmail.com>
References: <20060301220802.GA18250@kroah.com>
	 <20060301220840.GB18250@kroah.com>
	 <7v8xrtepje.fsf@assigned-by-dhcp.cox.net>
	 <20060301232719.GA22068@kroah.com> <20060301233506.GA25209@kroah.com>
	 <20060302003418.GA11119@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Mar 02 01:45:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEbwo-0002pH-Lf
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 01:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWCBApg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 19:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWCBApf
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 19:45:35 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:23927 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751152AbWCBApf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 19:45:35 -0500
Received: by wproxy.gmail.com with SMTP id i20so282280wra
        for <git@vger.kernel.org>; Wed, 01 Mar 2006 16:45:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I+zaBNVDEGj/EH6rfkcRyPyJndYe1K6g3BAAcDS6v60NHLdBOE92ekmDewT9PRCH7DQymrInrzNxWZ7sfZJQFSAj74S5F27vgRcsbs1XGlv7jVOPZM2DjRW0KJ2ytxE++6wKOuRuK4y6T5t3FnWLUVPSF81Lm4JxT6V5ET1lgdA=
Received: by 10.54.153.18 with SMTP id a18mr417133wre;
        Wed, 01 Mar 2006 16:45:34 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Wed, 1 Mar 2006 16:45:34 -0800 (PST)
To: "Greg KH" <greg@kroah.com>
In-Reply-To: <20060302003418.GA11119@kroah.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17035>

On 3/2/06, Greg KH <greg@kroah.com> wrote:
> Ok, no problem there either.
>
> thanks for the pointer to that option.

Now that it has been tested twice, it's about time it becomes the default ;-)

cheers,


martin
