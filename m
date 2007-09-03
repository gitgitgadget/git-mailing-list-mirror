From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Mon, 03 Sep 2007 08:51:28 +0100
Message-ID: <46DBBD00.5090308@zytor.com>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>	<46DA5F33.2020005@zytor.com>	<85odgltrtj.fsf@lola.goethe.zz>	<46DA88EF.7080103@zytor.com>	<20070902133803.1b46f599.seanlkml@sympatico.ca>	<7v4picpvgq.fsf@gitster.siamese.dyndns.org> <20070902191644.29d46cd2.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Mon Sep 03 09:52:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS6jL-0003VE-16
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 09:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbXICHwN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 03:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbXICHwM
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 03:52:12 -0400
Received: from terminus.zytor.com ([198.137.202.10]:58736 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbXICHwK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 03:52:10 -0400
Received: from titan.hos.anvin.org ([217.206.93.210])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l837pu8x006195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Sep 2007 00:52:00 -0700
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <20070902191644.29d46cd2.seanlkml@sympatico.ca>
X-Virus-Scanned: ClamAV 0.88.7/4134/Sun Sep  2 22:21:40 2007 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57436>

Sean wrote:
> 
> Given the comment from David, I suspect your patch is all
> that's needed; hopefully Peter can give it a quick test.
> 

It sounds like it; I don't know how to test it other than placing in the 
repository and try to upgrade.  It can't be any worse, so I don't see 
any harm in just doing it.

	-hpa
