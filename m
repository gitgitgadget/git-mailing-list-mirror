From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Lack of netiquette, was Re: [PATCH v4 00/13] New remote-hg helper
Date: Thu, 1 Nov 2012 13:46:25 -0700
Message-ID: <20121101204625.GC6213@elie.Belkin>
References: <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
 <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
 <5090EFCA.7070606@drmicha.warpmail.net>
 <20121031102712.GB30879@sigill.intra.peff.net>
 <alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
 <CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com>
 <20121031185903.GA1480@elie.Belkin>
 <CAMP44s2-UoT03OeTmM9=nh9wCUt84exPNuHyuThp=WQkxvCNLQ@mail.gmail.com>
 <alpine.DEB.1.00.1210312126080.7256@s15462909.onlinehome-server.info>
 <bec4d263-b458-4636-9fa6-1c1202416810@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 21:46:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU1f5-0002z7-52
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 21:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444Ab2KAUqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 16:46:34 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39153 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab2KAUqd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 16:46:33 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1981227pbb.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ICJV37VTiA/W1Xs/9NxsGMapH5PHjo1azCQibMsvplY=;
        b=oMgsRk8Rg1FyZCVS129ikdWXXIq9b5w5lXZhDkk/KDoLZ1E/WptuD3vEFS8OqIL/Vj
         CEgg7ZyYEmH6Eo/xesLhq6DEMFCCT/1Pbm7Kt3m+lRo1g06TUMteu790ERbCzmkvi/QN
         +Hs6PJDEWt4CGFLdhTzbuWP672+EBl+qY/U/vgMzUgHfYqeWnYC+xWi4kM4Wnfa8pvQq
         de0ItTW87SdeiaxxPzZFNJv6O9YzfymwSG9sKqy457APlmmK2kZmsWsWVnPjyVfkF4oc
         GBXpwNOHQsAebvDUCq4aesVvUdRnnv0RPd6/2gB84wjCeFiikOufScZDgeuTpkUVvDo5
         IgGg==
Received: by 10.66.78.4 with SMTP id x4mr1963892paw.60.1351802792755;
        Thu, 01 Nov 2012 13:46:32 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id b6sm4468951pav.33.2012.11.01.13.46.31
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 13:46:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <bec4d263-b458-4636-9fa6-1c1202416810@email.android.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208887>

Junio C Hamano wrote:

> We've been hoping we can do without a rigid code of conduct written
> down to maintain cordial community focused on technical merits, and
> instead relied on people's common sense, but sense may not be so
> common, unfortunately, so we may have to have one.

I think that except for occasional lapses this list stays pretty close
to what, for example, the Fedora[1] and Ubuntu[2] codes of conduct
require, and what Emily Postnews's guide[3] explains not to do.

What's the next step?

[1] http://www.ubuntu.com/project/about-ubuntu/conduct
[2] http://www.ubuntu.com/project/about-ubuntu/conduct
[3] http://www.templetons.com/brad/emily.html
