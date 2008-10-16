From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: Re: Feedback outside of the user survey
Date: Thu, 16 Oct 2008 15:18:32 +0200
Message-ID: <2d460de70810160618u1803375aj913145a5060e5308@mail.gmail.com>
References: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com>
	 <20081016115628.GA24836@garry-x300.arpnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Garry Dolley" <gdolley@arpnetworks.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 15:19:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqSlW-0004kR-QC
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 15:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbYJPNSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 09:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbYJPNSe
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 09:18:34 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:4981 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbYJPNSe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 09:18:34 -0400
Received: by yx-out-2324.google.com with SMTP id 8so715165yxm.1
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ZYjzif8W6GiHoteQOPR4Sm0ASrX+rXtT/OUWPJyfZiI=;
        b=N/gMT6jrSKAUdXU7qy1pKbq1H5WEV2UvDnLIalmWlAanUSpvzUp8JlvlqBUma5afGo
         +UIem4I+wlEtcoHueo6kS/E6oC5lXC4vi+tNmTJ8lmN1y1fMbp+j5kkzZnUJ4r1pcD2n
         g91MUFEBGiz9ZS5qEdXsIgZQHQUT1p2I2ja10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xMn8UFu2icKi0VNCmMZSMG6m4IxzNBvBwarwJAVvyN2Zd8ZhMHPd1pHdqrC19BVNpn
         KrROaejTMMep4jokrDBkqjUssTp1LQBiwGiSdv4/4NXByunD5Fy6x6BpfT2/kjCuPUNg
         5HvpUVawf5tG+2XdlOfJl/ZFOkGv0O4GvTuW8=
Received: by 10.101.70.15 with SMTP id x15mr3160914ank.112.1224163112247;
        Thu, 16 Oct 2008 06:18:32 -0700 (PDT)
Received: by 10.100.43.19 with HTTP; Thu, 16 Oct 2008 06:18:32 -0700 (PDT)
In-Reply-To: <20081016115628.GA24836@garry-x300.arpnetworks.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98377>

On Thu, Oct 16, 2008 at 13:56, Garry Dolley <gdolley@arpnetworks.com> wrote:

> I know from an external point of view, it seems pulling a subdir
> wouldn't be a big deal; but if you look at git internals, you start
> to realize why it's an option that isn't on the table.

That's my understanding as well. And you can simply branch
out a subdir when you want to work on it.
I am not saying this should be changed, just that it should
be mention in The Big Overview.


Richard
