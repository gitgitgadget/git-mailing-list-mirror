From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport
Date: Tue, 26 Aug 2008 15:38:48 -0700
Message-ID: <48B485F8.5030109@zytor.com>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 00:40:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY7Cj-0004eu-Dh
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 00:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbYHZWi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 18:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbYHZWi4
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 18:38:56 -0400
Received: from terminus.zytor.com ([198.137.202.10]:55299 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbYHZWi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 18:38:56 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7QMcsL1024517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Aug 2008 15:38:54 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7QMcsP4010976;
	Tue, 26 Aug 2008 15:38:54 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7QMcmV3006426;
	Tue, 26 Aug 2008 15:38:48 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080826172648.GK26523@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/8095/Tue Aug 26 14:06:44 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93828>

Shawn O. Pearce wrote:
> 
> Discard my prior patch from today.
> 
> This is a patch to last night's full document edition
> (http://article.gmane.org/gmane.comp.version-control.git/93704)
> and addresses only the issue of redirects.
> 

Looks great to me.

	-hpa
