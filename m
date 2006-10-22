From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH qgit 1/2] Directly draw lanes in ListView::paintCell()
Date: Mon, 23 Oct 2006 00:35:25 +0200
Message-ID: <e5bfff550610221535r60009371t46dfd5f7197ca0ad@mail.gmail.com>
References: <200610222242.45313.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 01:14:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbmWL-000330-Iv
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 01:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWJVXOS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 19:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWJVXOS
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 19:14:18 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:36773 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750759AbWJVXOR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 19:14:17 -0400
Received: by py-out-1112.google.com with SMTP id z74so4902pyg
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 16:13:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EfwACnEZmBw0Y4Btdwzf/6XDaL9uYXmTzXB4PKw5D2AdSEKXjY8LL8k1otZkF9FapmRE9O+DyFlUofDirv6LxL+G+eRDrEw5AB7xywNqjKg9SbLw2qKwHOLfCOe+Q5e3WWSyZejOQvwZUn1QhCnVmE1WiTb6e1VG/rWzPHTVBFI=
Received: by 10.35.83.6 with SMTP id k6mr5427739pyl;
        Sun, 22 Oct 2006 15:35:25 -0700 (PDT)
Received: by 10.35.42.4 with HTTP; Sun, 22 Oct 2006 15:35:25 -0700 (PDT)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200610222242.45313.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29803>

>
> Hi Marco,
>
> the change looks bigger than it really is because of the
> pure rearrangement of the drawing code.
> I hope I used your indentation style.
>
> Josef
>

Hi Josef,

Thanks for the patches. Applied locally both, unfortunately I cannot push due to
a problem with hard disk: all my data is lost, so I don't have anymore
the ssh keys necessary to login at kernel.org

I've already asked admin for help, but I think we have to wait few
days before to push patches again.

Anyhow patches are very good, really, a breath of fresh air!

Marco
