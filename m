From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/7] Add buffer pool library
Date: Mon, 24 May 2010 12:11:37 +0200
Message-ID: <AANLkTim8olZLKoi4Uk_nPpxhCYKX7b_yUDBrWVW_rm57@mail.gmail.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com> 
	<1274650832-7411-4-git-send-email-artagnon@gmail.com> <20100524074757.GC3412@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 24 12:12:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGUdh-00086j-PC
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 12:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262Ab0EXKL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 06:11:59 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:48591 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532Ab0EXKL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 06:11:59 -0400
Received: by qyk13 with SMTP id 13so5141308qyk.1
        for <git@vger.kernel.org>; Mon, 24 May 2010 03:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=krQixqM9+4s5B58XweIUjke/haxgfu32gAfVUDn4YxU=;
        b=RPArWugiwm9+tWKntvBVxOg7yWJlb+11PZY8j2aVGPjVIBfVoUSdUi0RVceBKY8HVI
         yeFOJYGd0AgxH3JlPIGBrHgiP6SK4KTRB4bzazBvlzsUhqt63nflVza7oP0yX1P5nMIC
         zjA20GW/6wKXm8ePPAa5iqRb6VmP5j7JEDp3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZIfQbESFbOeOdk7IeWYSspwsvpSZaqqfCu85M9y63eBO5G06mXTd1lMUkjS5ru2Dn2
         x2Y6sgIpuVT6ze5hYwGAz+V+oE1yUGNAnunBgyITS0jZ8CZwq2C/DmE5dlngfe+zc8oO
         2r44QFLppTSw+oy6DImxsHVZv3/13WtVb0OKg=
Received: by 10.224.119.16 with SMTP id x16mr2710881qaq.338.1274695917217; 
	Mon, 24 May 2010 03:11:57 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Mon, 24 May 2010 03:11:37 -0700 (PDT)
In-Reply-To: <20100524074757.GC3412@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147622>

Hi,

On Mon, May 24, 2010 at 9:47 AM, Peter Baumann <waste.manager@gmx.de> wrote:
> If this is David's code, shouldn't you then preserve authorship?

Yeah, I thought about that- can we hand-edit the author since atleast
90% of the code is David's? What are your thoughts on importing some
of the revision history from the original repository?
@David: I'll take the responsibility of cleaning it up/ modifying it
and getting it merged into git.git. You can work on the repository
independently, and I'll pull relevant changes into git.git.

-- Ram
