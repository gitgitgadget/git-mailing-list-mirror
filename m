From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Bug! Git merge also fails with a wrong error message
Date: Sun, 15 Jan 2012 11:08:38 +0100
Message-ID: <201201151108.39335.jnareb@gmail.com>
References: <loom.20120112T193624-86@post.gmane.org> <m3mx9re6t0.fsf@localhost.localdomain> <4F128B81.2000502@unclassified.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Carlos =?utf-8?q?Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: Yves Goergen <nospam.list@unclassified.de>
X-From: git-owner@vger.kernel.org Sun Jan 15 11:08:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmN13-00045H-Im
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 11:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab2AOKIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jan 2012 05:08:40 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53225 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab2AOKIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 05:08:39 -0500
Received: by eekd4 with SMTP id d4so1555704eek.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 02:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=87ow26KWhiyVre0KcO7sVwGSKw4E6WC56N8O3ld/JJs=;
        b=ew99Fb6q0V3FfiSkIVW8Azjos8h6Lw2zOJRqOR/tUMHZQf6n+KeZDi3QK5NdlyA8BT
         4NPweSY3e+s+t3vzUb/7rgGsxPfASI4BQhh0fQnXTjGGPTfmoqjot84G4RttPwD8t6HS
         WU5l+kPCIpMHW0rE9O4Ac2aqHCw9ERmlfs+KM=
Received: by 10.213.9.139 with SMTP id l11mr1655837ebl.5.1326622116445;
        Sun, 15 Jan 2012 02:08:36 -0800 (PST)
Received: from [192.168.1.13] (absh180.neoplus.adsl.tpnet.pl. [83.8.127.180])
        by mx.google.com with ESMTPS id s16sm56080910eef.2.2012.01.15.02.08.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 02:08:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4F128B81.2000502@unclassified.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188597>

On Sun, 15 Jan 2012, Yves Goergen wrote:
> On 13.01.2012 20:34 CE(S)T, Jakub Narebski wrote:

> > > Since I don't have access to the news system, I need to use the Gmane
> > > website. I don't know exactly what it is.
> > 
> > GMane is an e-mail to news gateway, and a mailing list archive. It
> > exposes mailing list as a newsgroup, so it can be read and written to
> > via newsreader (via Usenet).
> 
> I have Thunderbird, but I have no usenet server to entry in a usenet
> account, so as I said, I don't have access to that part of the internet.
> I had at university, but that's some time ago now.

GMane serves as a Usenet server; that is how it works as mail to news
gateway.  The server name is news.gmane.org... or you can try using the
following URL

  nntp://news.gmane.org/gmane.comp.version-control.git
 
> > git@vger.kernel.org is a public non-subscribe mailing list; you don't
> > need to subscribe to post requests there.  Note that it is a custom on
> > this mailing list to always include all participants in given
> > (sub)thread directly in Cc, so you should get responses to your emails
> > even if you are not subscribed.
> 
> Good to know NOW. It really should have informed me in the first place
> on that website. It's a vital information without which you likely won't
> get anywhere (as I).

You can get this information on GitCommunity page on Git Wiki.  For the
time being (while Git Wiki is served as set of static pages of exported
contents because of lack of hardware) you can find it here:

  https://git.wiki.kernel.org/articles/g/i/t/GitCommunity_c4e3.html

-- 
Jakub Narebski
Poland
