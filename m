From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFH] QGit: how to cram a patch in a crowded screen
Date: Sat, 2 Jun 2007 13:37:03 +0200
Message-ID: <e5bfff550706020437i3f54d459rdbe9070fe03a28c9@mail.gmail.com>
References: <e5bfff550705260146q51350f40q1c80cfe8079f47c6@mail.gmail.com>
	 <200705261034.53723.andyparkins@gmail.com>
	 <e5bfff550705261344l604543e7h64c20c1fc0979f20@mail.gmail.com>
	 <20070527153852.GA30365@efreet.light.src>
	 <e5bfff550705270856o195b9075u1c99a05e79d69742@mail.gmail.com>
	 <20070531195633.GA3252@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Pavel Roskin" <proski@gnu.org>
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Jun 02 13:37:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuRv7-0007YV-WE
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 13:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331AbXFBLhI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 07:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755308AbXFBLhH
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 07:37:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:33404 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331AbXFBLhE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 07:37:04 -0400
Received: by wa-out-1112.google.com with SMTP id j4so865803wah
        for <git@vger.kernel.org>; Sat, 02 Jun 2007 04:37:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qf4SYVu0I5zQI1f9iSBL7l9jZ8gndmPmJmtxNPopTDXkg6PVEg5ZRVwvVdoG7txRca4T7PrW7A9G2K3pwRsZeVz3bSN13+mTDlptkPirq6KJQTbhg62eAHi7ucQVEIBUGwQ3Lg2VzrLSiF/wkBfwn5IUHcdJEr2viP73G67jXd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Amj+AqmK23qxj9okWMXoAyFYX8cQRQjvdBY0BL8XdVBdz5LCF6up4gpCZ5cB7DL55UUBBqUefWJHFLCxH+1c0X1O0euTai42lQEMwSYAA11+00YRlla56BV/412M5cBIDTFOyKUimGwoqfhnsaTsYUNv7eSD5CAVnncuTZbPL34=
Received: by 10.114.177.1 with SMTP id z1mr2844120wae.1180784223892;
        Sat, 02 Jun 2007 04:37:03 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sat, 2 Jun 2007 04:37:03 -0700 (PDT)
In-Reply-To: <20070531195633.GA3252@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48926>

On 5/31/07, Jan Hudec <bulb@ucw.cz> wrote:
>
> I have to say that I like the gitk way better. There is the issue of
> over-scrolling. I often want to quickly scan through the diff, so I scroll
> pretty quickly and it switches over when I reach the end.
>

Ok. "Smart Browsing" ;-)  patch series pushed to qgit4.

Refer to patches logs for a little documentation.

Please give feedback if this patch series it's not smart enough for you.

Thanks
Marco
