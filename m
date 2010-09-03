From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] parse_object: pass on the original sha1, not the replaced one
Date: Fri, 3 Sep 2010 06:37:41 +0200
Message-ID: <201009030637.41728.chriscool@tuxfamily.org>
References: <20100902211321.18003.34601.chriscool@tuxfamily.org> <AANLkTikBau2-ggvZa2Zp35gTk_j8JEAY8nyVh3i0-ap7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 06:38:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrO2i-0000qG-Sl
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 06:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab0ICEiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 00:38:11 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:34920 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955Ab0ICEiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 00:38:09 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D365A818047;
	Fri,  3 Sep 2010 06:38:02 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <AANLkTikBau2-ggvZa2Zp35gTk_j8JEAY8nyVh3i0-ap7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155235>

On Friday 03 September 2010 01:24:07 Nguyen Thai Ngoc Duy wrote:
> On Fri, Sep 3, 2010 at 7:13 AM, Christian Couder
> 
> <chriscool@tuxfamily.org> wrote:
> > Since no one resent the original patch with an improved commit
> > message, here is my try.
> 
> My bad. I forgot something again. I will think of something to
> demonstrate this. By the way, it breaks t6050.14, bisect and
> replacements.

Ooops, yeah, I will have a look at this.

Thanks,
Christian.
