From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: dotfile support
Date: Wed, 07 Dec 2005 16:47:27 -0800
Message-ID: <4397829F.1020609@zytor.com>
References: <20050416230058.GA10983@ucw.cz> <118833cc05041618017fb32a2@mail.gmail.com> <20050416183023.0b27b3a4.pj@sgi.com> <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org> <42620092.9040402@dwheeler.com> <Pine.LNX.4.58.0504170857580.7211@ppc970.osdl.org> <42628D1B.3000207@dwheeler.com> <20051207145646.GA9207@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "David A. Wheeler" <dwheeler@dwheeler.com>,
	Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>,
	Morten Welinder <mwelinder@gmail.com>, mj@ucw.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 01:50:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek9xz-0000Yp-Eb
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 01:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbVLHAsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 19:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVLHAsq
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 19:48:46 -0500
Received: from terminus.zytor.com ([192.83.249.54]:20380 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965074AbVLHAsp
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 19:48:45 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB80lXbf007169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Dec 2005 16:47:33 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20051207145646.GA9207@tumblerings.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13352>

Zack Brown wrote:
> Hi,
> 
> What's the status of dotfile support?

Works fine for me; I now maintain my shell config files in git.

	-hpa
